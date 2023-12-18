#include <iostream>
#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <queue>

std::queue<int> queue; //буфер
std::vector<pthread_t> sum_threads;
static int counter;
static int sum_index;
pthread_cond_t condCounter;
pthread_mutex_t mutex; // мьютекс для условных переменных

void *Producer(void* param) {
    int pNum = *((int*)param);
    int time = 1 + rand()%7;
    sleep(time);
    int data;
    data = rand()% 21;
    pthread_mutex_lock(&mutex);
    queue.push(data);
    counter++;
    if (counter > 1)
        pthread_cond_signal(&condCounter);
    printf("Producer %d: Created value = %d\n", pNum, data) ;
    pthread_mutex_unlock(&mutex);

    return nullptr;
}

void *Sumer(void* param) {
    int count = *((int*)param);
    int current_index = sum_index++;
    printf("Summer %d created!\n", current_index) ;
    int time_sum = 3 + rand() % 3;
    int sum = 0;
    sleep(time_sum);
    pthread_mutex_lock(&mutex) ;
    while (count > 0) {
        sum += queue.front();
        queue.pop();
        --count;
    }
    queue.push(sum);
    ++counter;
    if (counter > 1)
        pthread_cond_signal(&condCounter);
    printf("Summer %d: Summa read values = %d\n", current_index, sum);
    pthread_mutex_unlock(&mutex);
    return nullptr;
}

[[noreturn]] void *Handler(void* args) {
    int now_count;
    while (true) {
        pthread_t newSumer;
        pthread_mutex_lock(&mutex) ;
        while (counter < 2) {
            pthread_cond_wait(&condCounter, &mutex);
        }
        sum_threads.push_back(newSumer);
        now_count = counter;
        pthread_create(&newSumer, nullptr, Sumer, (void *)(&now_count));
        counter -= now_count;
        pthread_mutex_unlock(&mutex);
    }
}

int main() {
    int i;
    pthread_mutex_init(&mutex, nullptr);
    pthread_cond_init(&condCounter, nullptr);

    pthread_t handler;
    pthread_create(&handler, nullptr, Handler, nullptr);

    //запуск производителей
    pthread_t threadP[20];
    int producers[20];
    for (i = 0 ; i < 20; ++i) {
        producers[i] = i + 1;
        pthread_create(&threadP[i], nullptr, Producer, (void*)(producers+i)) ;
    }

    for (i = 0 ; i < 20; ++i) {
        pthread_join(threadP[i], NULL);
    }

    for(i = 0; i < sum_threads.size(); ++i) {
        pthread_join(sum_threads[i], NULL);
    }

    sleep(12);
    std::cout << "Result is " << queue.front();
    pthread_mutex_destroy(&mutex);
    pthread_cond_destroy(&condCounter);
    return 0;
}

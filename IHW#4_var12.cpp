#include <iostream>
#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <queue>

pthread_cond_t cond1; // условная переменная
pthread_cond_t cond2; // условная переменная
pthread_mutex_t mutex;
pthread_mutex_t mutex1; // мьютекс для условных переменных
pthread_mutex_t mutex2; // мьютекс для условных переменных
std::queue<std::pair<pthread_t, int>> queue1; // очередь первой кассы
std::queue<std::pair<pthread_t, int>> queue2; // очередь второй кассы
static int queueSize;
static int buyerNum = 1;

//стартовая функция потоков – покупателей
void *Buyer(void* number) {
    int whichQueue = rand() % 2;
    pthread_mutex_lock(&mutex);
    int bNum = buyerNum;
    ++buyerNum;
    if(whichQueue) {
        if(queue2.size() < queueSize) {
            queue2.emplace(pthread_self(), bNum);
            printf("Buyer%d went to the cash register #2\n", bNum);
            pthread_cond_signal(&cond2);
        } else if (queue1.size() == queueSize && queue2.size() == queueSize) {
            pthread_mutex_unlock(&mutex);
            return nullptr;
        } else {
            queue1.emplace(pthread_self(), bNum);
            printf("Buyer%d went to the cash register #1\n", bNum);
            pthread_cond_signal(&cond1);
        }
    }
    else {
        if(queue1.size() < queueSize) {
            queue1.emplace(pthread_self(), bNum);
            printf("Buyer%d went to the cash register #1\n", bNum);
            pthread_cond_signal(&cond1);
        } else if (queue1.size() == queueSize && queue2.size() == queueSize) {
            pthread_mutex_unlock(&mutex);
            return nullptr;
        } else {
            queue2.emplace(pthread_self(), bNum);
            printf("Buyer%d went to the cash register #2\n", bNum);
            pthread_cond_signal(&cond2);
        }
    }
    pthread_mutex_unlock(&mutex);
    return nullptr;
}

//стартовая функция потока - кассира №1
[[noreturn]] void *Cashier1(void* args) {
    int number1;
    int serviceTime;
    while (true) {
        pthread_mutex_lock(&mutex1);
        while(queue1.empty()) {
            pthread_cond_wait(&cond1, &mutex1); // поток спит, пока не появится клиент
        }
        serviceTime = 1 + rand() % 4;
        sleep(serviceTime); // имитация времени обслуживания клиента
        pthread_mutex_lock(&mutex); // обращаемся к критическому сектору
        number1 = queue1.front().second;  // получаем номер клиента
        queue1.pop();   // клиент обслужен и покидает очередь
        printf("Customer #%d served by Cashier1!\n", number1);
        pthread_mutex_unlock(&mutex);
        pthread_mutex_unlock(&mutex1);
    }
}

//стартовая функция потока - кассира №2
[[noreturn]] void *Cashier2(void* args) {
    int number2;
    int serviceTime;
    while (true) {
        pthread_mutex_lock(&mutex2);
        while(queue2.empty()) {
            pthread_cond_wait(&cond2, &mutex2); // поток спит, пока не появится клиент
        }
        serviceTime = 1 + rand() % 4;
        sleep(serviceTime); // имитация времени обслуживания клиента
        pthread_mutex_lock(&mutex);  // обращаемся к критическому сектору
        number2 = queue2.front().second; // получаем номер клиента
        queue2.pop();    // клиент обслужен и покидает очередь
        printf("Customer #%d served by Cashier2!\n", number2);
        pthread_mutex_unlock(&mutex);
        pthread_mutex_unlock(&mutex2);
    }
}

int main() {
    int timeNewBuyer;
    pthread_t cashier1;
    pthread_t cashier2;

    // инициализируем мьютексы и условные переменные
    pthread_mutex_init(&mutex, nullptr);
    pthread_mutex_init(&mutex1, nullptr);
    pthread_mutex_init(&mutex2, nullptr);
    pthread_cond_init(&cond1, nullptr);
    pthread_cond_init(&cond2, nullptr);

    // ввод максимального размера очереди
    std::cout << "Enter the maximum queue size: ";
    std::cin >> queueSize;
    std::cout << std::endl;

    // "открываем" кассы
    pthread_create(&cashier1, nullptr, &Cashier1, nullptr);
    pthread_create(&cashier2, nullptr, &Cashier2, nullptr);

    while(true) {
        pthread_t newBuyer;
        timeNewBuyer = rand() % 5; // клиенты появляются с разной периодичностью
        pthread_create(&newBuyer, nullptr, Buyer, nullptr); // создаем клиента
        sleep(timeNewBuyer);
    }

    //Уничтожение мьютекса и условных переменных, но в данной программе до этого мы не доходим
    pthread_mutex_destroy(&mutex);
    pthread_mutex_destroy(&mutex1);
    pthread_mutex_destroy(&mutex2);
    pthread_cond_destroy(&cond1);
    pthread_cond_destroy(&cond2);
}

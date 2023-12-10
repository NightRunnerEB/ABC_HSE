#include <iostream>
#include <iomanip>
#include <pthread.h>
#include <chrono>

struct Package {
    double* aPointer;   // pointer to A array
    double* bPointer;   // pointer to B array
    int threadNum;      // thread number
    double sum;         // sum counting by current thread
};

// vector sizes
const unsigned int arrSize = 100000000;
//const unsigned int arrSize = 500000000;
//const unsigned int arrSize = 100000000000;

double *A ;  // first vector(a0, a1,...,an)
double *B;   // second vector(b0,b1,...,bn)

//const int threadNumber = 1;
// const int threadNumber = 2;
const int threadNumber = 4;
//const int threadNumber = 8;
//const int threadNumber = 1000;

// func for threads
void *func(void *param) {
    auto* p = (Package*)param;
    p->sum = 0.0;
    for(unsigned int i = p->threadNum ; i < arrSize; i+=threadNumber) {
        p->sum += p->aPointer[i] * p->bPointer[i];
    }
    return nullptr;
}

int main() {
    double rez = 0.0 ; // total result

    A = new double[arrSize];
    B = new double[arrSize];
    for(int i = 0; i < arrSize; ++i) {
        A[i] = double(i + 1);
        B[i] = double(arrSize - i);
    }

    pthread_t thread[threadNumber];
    Package pack[threadNumber];
    //clock_t start_time =  clock();
    auto time = std::chrono::high_resolution_clock::now();
    //create threads
    for (int i=0 ; i<threadNumber ; i++) {
        pack[i].aPointer = A;
        pack[i].bPointer = B;
        pack[i].threadNum = i;
        pthread_create(&thread[i], nullptr, func, (void*)&pack[i]);
    }

    for (int i = 0 ; i < threadNumber; i++) {    // wait for completing
        pthread_join(thread[i], nullptr) ;       // get results
        rez += pack[i].sum;
    }
    // end_time = clock(); // end time
    auto elapsed = std::chrono::high_resolution_clock::now() - time;
    long long millisec = std::chrono::duration_cast<std::chrono::milliseconds>(elapsed).count();

    std::cout << "Result of the vector product = "<<std::setprecision(20) << rez << "\n" ;
    std::cout << "Total time(ms) = " << millisec << "\n";

    delete[] A;
    delete[] B;
    return 0;
}

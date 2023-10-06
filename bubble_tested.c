#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void bubbleSort(int A[], int tamanho) {
    int i, j, trocado;
    do {
        trocado = 0;
        for (i = 0; i < tamanho - 1; i++) {
            if (A[i] > A[i + 1]) {
                int temp = A[i];
                A[i] = A[i + 1];
                A[i + 1] = temp;
                
                trocado = 1;
            }
        }
    } while (trocado);
}

int testeBubbleSort() {
    int tamanho = 10; 
    int A[tamanho];   

    srand(time(NULL));

    for (int i = 0; i < tamanho; i++) {
        A[i] = rand() % 100; 
    }

    bubbleSort(A, tamanho);

    for (int i = 0; i < tamanho - 1; i++) {
        if (A[i] > A[i + 1]) {
            return 0; 
        }
    }

    return 1; 
}

int main() {
    int totalTestes = 1000;
    int sucesso = 0;

    for (int i = 0; i < totalTestes; i++) {
        if (testeBubbleSort()) {
            sucesso++;
        }
    }

    printf("%d de %d testes passaram.\n", sucesso, totalTestes);

    return 0;
}

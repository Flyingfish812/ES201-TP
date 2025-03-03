#include <stdio.h>
#include <stdlib.h>

#define N 128  // Taille de la matrice
#define BLOCK_SIZE 16  // Taille du bloc

// Produit de deux matrices (sans optimisation)
void matrix_multiply(int A[N][N], int B[N][N], int C[N][N]) {
    int i, j, k;
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            C[i][j] = 0;
            for (k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B[k][j];  // Accumulation du produit
            }
        }
    }
}

// Produit de deux matrices (avec optimisation par blocs)
void matrix_multiply_blocked(int A[N][N], int B[N][N], int C[N][N]) {
    int i, j, k, ii, jj, kk;
    for (i = 0; i < N; i += BLOCK_SIZE) {
        for (j = 0; j < N; j += BLOCK_SIZE) {
            for (k = 0; k < N; k += BLOCK_SIZE) {
                // BLOCK_SIZE x BLOCK_SIZE bloc
                for (ii = i; ii < i + BLOCK_SIZE; ii++) {
                    for (jj = j; jj < j + BLOCK_SIZE; jj++) {
                        for (kk = k; kk < k + BLOCK_SIZE; kk++) {
                            C[ii][jj] += A[ii][kk] * B[kk][jj];
                        }
                    }
                }
            }
        }
    }
}

// Transposer une matrice
void transpose_matrix(int B[N][N], int B_T[N][N]) {
    int i, j;
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            B_T[j][i] = B[i][j];  // Transposer
        }
    }
}

// Produit de deux matrices (avec optimisation par blocs et transposition)
void matrix_multiply_transpose(int A[N][N], int B[N][N], int C[N][N]) {
    int i, j, k;
    int B_T[N][N];
    transpose_matrix(B, B_T);

    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            C[i][j] = 0;
            for (k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B_T[j][k];  // Par ligne pour B_T, diminuer le cache miss
            }
        }
    }
}

// Produit de deux matrices (avec optimisation par blocs et transposition)
void matrix_multiply_unrolled(int A[N][N], int B[N][N], int C[N][N]) {
    int i, j, k;
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            C[i][j] = 0;
            for (k = 0; k < N; k += 4) {  // 4 éléments à la fois
                C[i][j] += A[i][k] * B[k][j] +
                           A[i][k + 1] * B[k + 1][j] +
                           A[i][k + 2] * B[k + 2][j] +
                           A[i][k + 3] * B[k + 3][j];
            }
        }
    }
}


// Générer une matrice aléatoire
void generate_matrix(int A[N][N]) {
    int i, j;
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            A[i][j] = rand() % 10;  // 0 à 9
        }
    }
}

// Afficher une matrice
void print_matrix(int A[N][N]) {
    int i, j;
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            printf("%d ", A[i][j]);
        }
        printf("\n");
    }
}

int main() {
    static int A[N][N], B[N][N], C[N][N];

    generate_matrix(A);
    generate_matrix(B);

    matrix_multiply(A, B, C);
    // print_matrix(C);

    printf("Matrix multiplication completed.\n");
    return 0;
}

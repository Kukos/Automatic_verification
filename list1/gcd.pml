/*
    Algorithm:
    if (n > m) swap(n, m)
    if (m > n) m = m - n
    if (m > 2 * n) m = m - 2 * n
    if (m > 3 * n) m = m - 3 * n

    This is gcd algorithm on steroids :)

    CHECK:
        Algorithm always finish work.

    Program:
        Check if -end- state is visited after run

    Command:
        spin -run gcd.pml
*/


#define SWAP(a, b, t) t temp = a; a = b; b = temp
#define SWAP_INT(a, b) SWAP(a, b, int)

active proctype gcd()
{
    int m
    int n

    select(m : 1 .. 100)
    select(n : 1 .. 100)

    do
    :: (n > m) -> SWAP_INT(n, m)
    :: (m > n) -> m = m - n
    :: (m > 2 * n) -> m = m - 2 * n
    :: (m > 3 * n) -> m = m - 3 * n
    :: (m == n) -> break
    od
}
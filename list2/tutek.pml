/*
    Simple tutorial of chan msgs
*/

mtype = {MSG1, MSG2}
chan meeting = [0] of {mtype}

#define PRINT(msg) \
    if \
    :: (msg == MSG1) -> printf("[%d] Hello!\n", _pid) \
    :: else -> printf("[%d] Hi!\n", _pid) \
    fi

active proctype thread1()
{
    mtype msg
    do
    :: meeting ! MSG2 ; meeting ? msg ; PRINT(msg)
    od
}

active proctype thread2()
{
    mtype msg
    do
    :: meeting ? msg ; PRINT(msg) ; meeting ! MSG1
    od
}
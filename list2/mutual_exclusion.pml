/*
    Algorithm:
    Mutual exclusion

    Proc with pid 0 can go into crit section when val[0] == val[N - 1]
    Other Procs can go when val[_pid - 1] != val[_pid]

    CHECK:
       1) Only 1 process can execute crit section code

    Program:
       1) Never Claim is used. This will check assert in every step of program

    Command:
        spin -T -u10000 -g mutual_exclusion.pml
*/

#define N 8

int values[N]
chan msg[N] = [0] of {int}
int crit = 0

#define START_JOB() crit = crit + 1;
#define END_JOB() crit = crit - 1

active proctype thread_first()
{
    int val
    int id = _pid
    assert(id == 0)

    do
    ::  msg[id] ? val ; if
                        :: (val == values[id]) -> START_JOB(); values[id] = (values[id] + 1) % (N + 1) ; END_JOB();
                        :: else -> skip
                        fi
    ::  msg[id + 1] ! values[id]
    od
}

active[N - 1] proctype thread()
{
    int val
    int id = _pid
    assert(id > 0 && id < N)

    do
    :: msg[id] ? val ;  if
                        :: (val != values[id]) -> START_JOB(); values[id] = val ; END_JOB();
                        :: else -> skip
                        fi
    :: msg[(id + 1) % N] ! values[id]
    od
}

/*
active proctype killer()
{
    do
    :: crit = crit + 1; crit = crit - 1;
    od
}
*/

never
{
   do
   :: assert(crit <= 1)
   od
}
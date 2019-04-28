/*
    Algorithm:
    Leader election in a ring of procs

    See: H. Attiya, J. Welch "Distributed Computing" page 37

    CHECK:
       1) In step k-th only k-winner can go to the next round
       2) Last standing man is a leader

    Program:
       1) Timeout is checked, if proc visit this state, then we check that he is no a leader
       2) Last standing has maximum _pid (he is a leader)

    Command:
        spin -run leader.pml (N = 4)
        spin -T -g -s -r -u1000000 leader.pml (N = 10)
*/

#define N 10

mtype = {LEFT, RIGHT}
chan probe_ch[N] = [2] of {mtype, int, int, int}
chan reply_ch[N] = [2] of {mtype, int, int}

inline receive_probe(id, j, k, d, ch1, ch2, mt1, mt2)
{
    if
    :: j == id -> assert(id == N - 1) ;goto accept
    :: j > id && d < (1 << k) -> probe_ch[ch1] ! mt1, j, k, (d + 1)
    :: j > id && (d >= (1 << k)) -> reply_ch[ch2] ! mt2, j, k
    :: j < id -> skip
    fi
}

inline receive_reply(id, j, k, ch, mt, this_reply, other_reply)
{
    if
    :: id != j -> reply_ch[ch] ! mt, j, k
    :: else ->  if
                :: other_reply -> probe_ch[id] ! mt, id, (k + 1), 1
                :: else -> this_reply = true
                fi
    fi
}

active[N] proctype thread()
{
    bool asleep = true
    int id = _pid

    int left
    int right

    mtype mt
    int j
    int k
    int d

    bool has_reply_from_left = false
    bool has_reply_from_right = false

    if
    :: (id == 0) -> left = N - 1
    :: else -> left = id - 1
    fi

    right = (id + 1) % N

    do
    :: asleep -> asleep = false; probe_ch[left]! RIGHT, id, 0, 1 ; probe_ch[right]! LEFT, id, 0, 1
    :: nempty(probe_ch[id]) -> probe_ch[id] ? mt, j, k, d ;
        if
        :: mt == LEFT -> receive_probe(id, j, k, d, right, left, LEFT, RIGHT)
        :: mt == RIGHT -> receive_probe(id, j, k, d, left, right, RIGHT, LEFT)
        fi
    :: nempty(reply_ch[id]) -> reply_ch[id] ? mt, j, k ;
        if
        :: mt == LEFT -> receive_reply(id, j, k, right, LEFT, has_reply_from_left, has_reply_from_right)
        :: mt == RIGHT -> receive_reply(id, j, k, left, RIGHT, has_reply_from_right, has_reply_from_left)
        fi
    :: timeout -> assert(id != (N - 1)) ; break
    od
accept:

}

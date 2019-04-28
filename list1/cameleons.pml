/*
    Algorithm:
    We have 13 yellow, 16 green and 15 red cameleons.

    Cameleons meet always in pairs. If the pair has diff colors, both of them change color to the third one

    CHECK:
        1) There is no situation where all colors have equal numbers of members
        2) There is situation when all cameleons has the same color

    Program:
        1) Assert in loop
        2) Due to fact, that there wont be meeting with change, we end loop in this situation, so -end- state must be visited

    Command:
        spin -run cameleons.pml
*/

active proctype cameleons()
{
    int yellow_num = 13
    int green_num = 16
    int red_num = 15

    do
    :: (yellow_num + green_num == 0 ||  yellow_num + red_num == 0 || green_num + red_num == 0) -> break
    :: else ->  if
                :: (yellow_num >= 1 && green_num >= 1) -> yellow_num--; green_num--; red_num = red_num + 2
                :: (yellow_num >= 1 && red_num >= 1) -> yellow_num--; red_num--; green_num = green_num + 2
                :: (green_num >= 1 && red_num >= 1) -> green_num--; red_num--; yellow_num = yellow_num + 2
                fi
                /* assert will be hit when all num will be equal */
                assert(!(yellow_num == green_num && red_num == yellow_num))
    od
}
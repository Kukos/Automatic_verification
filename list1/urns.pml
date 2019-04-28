/*
    Algorithm:
    We have 150 black balls and 7 white balls

    Get 2 balls
    if (balls have the same color)
        add black ball to urn
    else
        add white ball to urn

    CHECK:
        Always at the end we have 1 white ball

    Program:
        Check assert at the end of process

    Command:
        spin -run urns.pml
*/

active proctype urns()
{
    int black_num = 150;
    int white_num = 75;
	do
	:: (black_num + white_num > 1) ->
		if
		::	(black_num >= 2) -> black_num--
		::	(white_num >= 2) -> white_num = white_num - 2; black_num++
		::	(white_num >= 1 && black_num >= 1) -> black_num--;
		fi

	:: else -> break;
	od

	assert(black_num == 0 && white_num == 1);
}
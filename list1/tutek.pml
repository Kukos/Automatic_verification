/*
    Simple tutorial to check possible inf loops
*/

int count;

/*
active proctype counter()
{
    if
    :: count++
    :: count--
    fi
}
*/

active proctype counter2()
{
	do
	:: count++
	:: count--
	:: (count == 0) -> break
	od
}
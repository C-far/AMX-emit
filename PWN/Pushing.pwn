/**--------------------------------------------------------------------------**\
	Remark : The Zeex's PAWN Compiler is required to use the p-code CALL.
\**--------------------------------------------------------------------------**/
#if __Pawn != 0x030A
	#error Download the Zeex's PAWN Compiler is required to use the p-code CALL.
// '
#endif

#include "a_samp"

main()
{
	new
		value1 = 5,
		value2 = 10;

	print(" ");
	print("Value");
		   
	#emit PUSH.S value2
	#emit PUSH.S value1
	#emit PUSH.C 8
	#emit CALL func
   
	print(" ");
	print("Relative address");
   
	#emit PUSH.C value2
	#emit PUSH.C value1
	#emit PUSH.C 8
	#emit CALL func        
   
	print(" ");
	print("Variable address");
   
	#emit PUSH.ADR value2
	#emit PUSH.ADR value1
	#emit PUSH.C 8
	#emit CALL func
   
	print(" ");
	print("Value address");
   
	#emit LCTRL 1
	#emit ADDR.alt value2
	#emit ADD
	#emit PUSH.pri
	
	#emit LCTRL 1
	#emit ADDR.alt value1
	#emit ADD
	#emit PUSH.pri 
	
	#emit PUSH.C 8
	#emit CALL func
}

func(a, b)
{
	printf("a = %d | 0x%x", a, a);
	printf("b = %d | 0x%x", b, b);
   
	return 0;
}
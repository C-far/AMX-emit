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
		   
	#emit PUSH.S value2 // On push la valeur de value2 se trouvant dans le stack
	#emit PUSH.S value1 // On push la valeur de value1 se trouvant dans le stack
	#emit PUSH.C 8 // On push le nombre de bytes (4 bytes par argument push)
	#emit CALL func // On appelle la fonction "func"
   
	print(" ");
	print("Local address");
   
	#emit PUSH.C value2 // On push l'adresse locale de value2
	#emit PUSH.C value1 // On push l'adresse locale de value1
	#emit PUSH.C 8 // On push le nombre de bytes (4 bytes par argument push)
	#emit CALL func // On appelle la fonction "func"   
   
	print(" ");
	print("Relative address");
   
	#emit PUSH.ADR value2 // On push l'adresse relative de value2
	#emit PUSH.ADR value1 // On push l'adresse relative de value2
	#emit PUSH.C 8 // On push le nombre de bytes (4 bytes par argument push)
	#emit CALL func // On appelle la fonction "func"
   
	print(" ");
	print("Global address");
   
	#emit LCTRL 1 // On charge dans le registre primaire le DATA
	#emit ADDR.alt value2 // On charge dans le registre alterné, l'adresse relative de value2
	#emit ADD // On additionne le DATA et l'adresse relative (pri + alt) | pri += alt
	#emit PUSH.pri // On push la valeur se trouvant dans le registre primaire
	
	#emit LCTRL 1 // On charge dans le registre primaire le DATA
	#emit ADDR.alt value1 // On charge dans le registre alterné, l'adresse relative de value1
	#emit ADD // On additionne le DATA et l'adresse relative (pri + alt) | pri += alt
	#emit PUSH.pri // On push la valeur se trouvant dans le registre primaire
	
	#emit PUSH.C 8 // On push le nombre de bytes (4 bytes par argument push)
	#emit CALL func // On appelle la fonction "func"
}

func(a, b)
{
	printf("a = %d | 0x%x", a, a);
	printf("b = %d | 0x%x", b, b);
   
	return 0;
}
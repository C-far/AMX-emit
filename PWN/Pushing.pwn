/**--------------------------------------------------------------------------**\
	Remark : The Zeex's PAWN Compiler is required to use the p-code CALL.
\**--------------------------------------------------------------------------**/
#if __Pawn != 0x030A
	#error Download the Zeex's PAWN Compiler, it is required to use the p-code CALL.
// '
#endif

#include "a_samp"

main()
{
	new
		value1 = 5,
		value2 = 10,
		data = GetAmxRealData();

	print(" ");
	print("Value");
		   
	#emit PUSH.S value2
	#emit PUSH.S value1
	#emit PUSH.C 8
	#emit CALL func
   
	print(" ");
	print("Local address");
   
	#emit PUSH.C value2
	#emit PUSH.C value1
	#emit PUSH.C 8
	#emit CALL func
   
	print(" ");
	print("Relative address");
   
	#emit PUSH.ADR value2
	#emit PUSH.ADR value1
	#emit PUSH.C 8
	#emit CALL func
   
	print(" ");
	print("Global address");
   
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

GetAmxRealData()
{
	/**
	
		reg.x = registre ...
		hdr.x = header ...
		seg.x = segment ...
		var.x = variable ...
		
	**/

	new
		addr,
		cod,
		base;
		
	#emit LCTRL 1 // reg.pri = hdr.data
	#emit NEG // reg.pri = -reg.pri
	#emit ADD.C 12 // reg.pri += 12
	#emit STOR.S.pri addr // var.addr = reg.pri
	
	#emit LREF.S.pri addr // reg.pri = *(seg.data + var.addr)
	#emit STOR.S.pri cod // var.cod = reg.pri
	addr += 4;
	
	#emit LREF.S.pri addr // reg.pri = *(seg.data + var.addr)
	#emit NEG // reg.pri = -reg.pri
	#emit STOR.S.pri base // var.base = reg.pri
	cod += base;
		
	amx_nothing();
	
	#emit LCTRL 6 // reg.pri = seg.cip
	#emit ADD.C 0xFFFFFFF4 // reg.pri += 0xFFFFFFF4 (-12) = reg.pri -= 12 (SUB.C n'existe pas/doesn't exist)
	#emit LOAD.S.alt cod // reg.alt = var.cod
	#emit ADD // reg.pri += reg.alt
	#emit STOR.S.pri addr // var.addr = reg.pri
	#emit LREF.S.pri addr // reg.pri = *(seg.data + var.addr)
	#emit SUB // reg.pri -= reg.alt
	#emit CONST.alt amx_nothing 
	#emit SUB // reg.pri -= reg.alt
	#emit MOVE.alt // reg.alt = reg.pri
	#emit LCTRL 1 // reg.pri = hdr.data
	#emit XCHG // reg.pri = reg.alt | reg.alt = reg.pri
	#emit SUB // reg.pri -= reg.alt
	#emit STOR.S.pri addr // var.addr = reg.pri (addr = real address)
	
	return addr - base;
}

static amx_nothing()
{
	return 0;
}
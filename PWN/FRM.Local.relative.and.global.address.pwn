#include "a_samp"

// Thanks Zeex.

static stock dth_amxh() return 0;

main()
{      
	new
		var = 5,
		frame_pointer,
		local_address,
		base,
		relative_address,
		global_address;

	/**														**\
		frame_pointer + local_address = relative_address
		relative_address + base = global_address 
	\**														**/
		 
	// Get Frame Pointer
	#emit LCTRL 5
	#emit STOR.S.pri frame_pointer
	// Get Frame Pointer
   
	// Get local address
	#emit CONST.alt var
	#emit STOR.S.alt local_address
	// Get local address
	
	// Get relative address
	#emit ADD
	#emit STOR.S.pri relative_address
	// Get relative address
	
	// Get base
	new 
		cod, 
		dat;
		
	#emit LCTRL 0
	#emit STOR.S.pri cod
	#emit LCTRL 1
	#emit STOR.S.pri dat

	new 
		code_start = cod - dat,
		fn_addr;
		
	#emit CONST.pri dth_amxh
	#emit STOR.S.pri fn_addr

	new 
		call_addr;
		
	dth_amxh();
	
	#emit LCTRL 6
	#emit STOR.S.pri call_addr
	
	call_addr = call_addr - 12 + code_start;
	
	#emit LREF.S.pri call_addr
	
	#emit LOAD.S.alt fn_addr
	#emit SUB
	
	#emit LOAD.S.alt cod
	#emit SUB
	
	#emit STOR.S.pri base
	// Get base
	
	// Get global address
	#emit LOAD.S.alt relative_address
	#emit ADD
	#emit STOR.S.pri global_address // On stocke la valeur se trouvant dans le registre primaire | global_address = pri
	// Get global address
   
	printf("frame_pointer : 0x%x | %d", frame_pointer, frame_pointer);
	printf("local_address : 0x%x | %d", local_address, local_address);
	printf("base : 0x%x | %d", base, base);
	printf("relative_address : 0x%x | %d", relative_address, relative_address);
	printf("global_address : 0x%x | %d", global_address, global_address);
}
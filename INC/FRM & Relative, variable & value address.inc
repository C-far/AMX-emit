#include "a_samp"

main()
{      
	new
		var = 5,
		frame_pointer,
		relative_address,
		data,
		variable_address,
		value_address;

	// frame_pointer + relative_address = variable_address
	// variable_address + data = value_address
		   
	#emit LCTRL 5
	#emit STOR.S.pri frame_pointer
   
	#emit CONST.alt var
	#emit STOR.S.alt relative_address
   
	#emit ADD
	#emit STOR.S.pri variable_address
   
	#emit MOVE.alt
   
	#emit LCTRL 1
	#emit STOR.S.pri data
	#emit ADD
	#emit STOR.S.pri value_address
   
	printf("frame_pointer : 0x%x | %d", frame_pointer, frame_pointer);
	printf("relative_address : 0x%x | %d", relative_address, relative_address);
	printf("data : 0x%x | %d", data, data);
	printf("variable_address : 0x%x | %d", variable_address, variable_address);
	printf("value_address : 0x%x | %d", value_address, value_address);
}
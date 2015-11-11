#include "a_samp"

main()
{      
	new
		var = 5,
		frame_pointer,
		local_address,
		data,
		relative_address,
		global_address;

	/**														**\
		frame_pointer + local_address = relative_address
		relative_address + data = global_address 
	\**														**/
		   
	#emit LCTRL 5 // On charge dans le registre primaire le Frame Pointer | pri = frm
	#emit STOR.S.pri frame_pointer // On stocke la valeur se trouvant dans le registre primaire | frame_pointer = pri
   
	#emit CONST.alt var // On charge dans le registre alterné l'adresse locale de la variable 'var' 
	#emit STOR.S.alt local_address // On stocke la valeur se trouvant dans le registre alterné | local_address = alt
   
	#emit ADD // On additionne le Frame Pointer et l'adresse locale de 'var' (pri + alt) | pri += alt
	#emit STOR.S.pri relative_address // On stocke la valeur se trouvant dans le registre primaire | relative_address = pri
   
	#emit MOVE.alt // On déplace la valeur du registre primaire (l'adresse relative de 'var') dans le registre alterné | alt = pri
   
	#emit LCTRL 1 // On charge dans le registre primaire le DATA | pri = dat
	#emit STOR.S.pri data // On stocke la valeur se trouvant dans le registre primaire | data = pri
	#emit ADD // On additionne le DATA et l'adresse relative de 'var' (pri + alt) | pri += alt
	#emit STOR.S.pri global_address // On stocke la valeur se trouvant dans le registre primaire | global_address = pri
   
	printf("frame_pointer : 0x%x | %d", frame_pointer, frame_pointer);
	printf("local_address : 0x%x | %d", local_address, local_address);
	printf("data : 0x%x | %d", data, data);
	printf("relative_address : 0x%x | %d", relative_address, relative_address);
	printf("global_address : 0x%x | %d", global_address, global_address);
}
/*
	The MIT License (MIT)
	Copyright (c) 2016 - Timothé Dutheil : C_far
	Permission is hereby granted, free of charge, to any person obtaining a 
	copy of this software and associated documentation files (the "Software"), 
	to deal in the Software without restriction, including without limitation 
	the rights to use, copy, modify, merge, publish, distribute, sublicense, 
	and/or sell copies of the Software, and to permit persons to whom the 
	Software is furnished to do so, subject to the following conditions:
	The above copyright notice and this permission notice shall be included 
	in all copies or substantial portions of the Software.
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
	THE SOFTWARE.
*/

#include "a_samp"

main()
{      
	new
		variable = 123456789,
		frame_pointer,
		local_address,
		relative_address,
		data = GetAmxRealData(),
		global_address;

	/**
	**\
		frame_pointer + local_address = relative_address
		relative_address + data = global_address 

		reg.x = registre ...
		hdr.x = header ...
		seg.x = segment ...
		var.x = variable ...
		frm = frame pointer
		
	**/

	// Get Frame Pointer
	#emit LCTRL 5 // reg.pri = frm
	#emit STOR.S.pri frame_pointer // var.frame_pointer = reg.pri
	// Get Frame Pointer
   
	// pri = Frame pointer
   
	// Get local address
	#emit CONST.alt variable // reg.alt = local address of var.variable
	#emit STOR.S.alt local_address // var.local_address = reg.alt
	// Get local address
	
	// alt = Local address
	
	// Get relative address
	#emit ADD // reg.pri += reg.alt
	#emit STOR.S.pri relative_address // var.relative_address = reg.pri
	// Get relative address
	
	// pri = Relative address
	
	// Get global address
	#emit LOAD.S.alt data // reg.alt = var.data
	#emit ADD // reg.pri += reg.alt
	#emit STOR.S.pri global_address // var.global_address = reg.pri
	// Get global address
   
	printf("frame_pointer : 0x%x | %d", frame_pointer, frame_pointer);
	printf("local_address : 0x%x | %d", local_address, local_address);
	printf("relative_address : 0x%x | %d", relative_address, relative_address);
	printf("data : 0x%x | %d", data, data);
	printf("global_address : 0x%x | %d", global_address, global_address);
}

stock GetAmxRealData()
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

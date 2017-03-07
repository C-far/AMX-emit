#include "a_samp"
 
main()
{              
	printf("%d", func(1, 2, 3));
	printf("%d", func2(1, 2, 3));
	printf("%d", func3(1, 2, 3));
}

func(...)
{
	#emit LCTRL 5
	#emit ADD.C 8
	#emit LOAD.I
	#emit SHR.C.pri 2
	#emit RETN
   
	return 0;
}

func2(...)
{
	#emit LOAD.S.pri 8
	#emit SHR.C.pri 2
	#emit RETN
   
	return 0;
}

func3(...)
{
	return numargs_();
}

numargs_()
{
	#emit LOAD.S.pri 0
	#emit ADD.C 8
	#emit LOAD.I
	#emit SHR.C.pri 2
	#emit RETN
	
	return 0;
}
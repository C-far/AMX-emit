#include "a_samp"

/*

	test1 = *(data + frm)
	test2 = *(data + *(data + frm))
	test3 = *(data + *(data + *(data + frm)))
	test4 = *(data + *(data + *(data + *(data + frm))))
	
	test1 = test2 = test3 = test4 = main()'s FRM

*/

main()
{
	new
		frm;
		
	#emit LCTRL 5
	#emit STOR.S.pri frm
	
	printf("FRM_main  :  0x%x", frm);
	
	test1();
}

test1()
{
	new
		frm;
		
	#emit LOAD.S.pri 0
	#emit STOR.S.pri frm
	
	printf("FRM_test1 :  0x%x", frm);
	
	test2();	
}

test2()
{
	new
		frm;
		
	#emit LREF.S.pri 0
	#emit STOR.S.pri frm
	
	printf("FRM_test2 :  0x%x", frm);
	
	test3();
}

test3()
{
	new
		frm;
		
	#emit LREF.S.pri 0
	#emit LOAD.I
	#emit STOR.S.pri frm
	
	printf("FRM_test3 :  0x%x", frm);
	
	test4();
}

test4()
{
	new
		frm;
		
	#emit LREF.S.pri 0
	#emit LOAD.I
	#emit LOAD.I
	#emit STOR.S.pri frm
	
	printf("FRM_test4 :  0x%x", frm);
}

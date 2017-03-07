#include "a_samp"
#tryinclude "YSI\y_amx"

main()
{
	print(" ");

	func1();
	print(" ");

	func2();
	print(" ");

	func3();
	print(" ");
}

func1()
{
	print("--- METHOD 1 ---");

	#if defined _INC_y_amx
		new
			var = 5843,
			relative_address = AMX_GetRelativeAddress(var),
			value = AMX_RawRead(address);

		printf("relative_address = 0x%x", relative_address);
		printf("value = %d", value);
	#else
		print("y_amx non inclu.");
	#endif
}

func2()
{
	print("--- METHOD 2 ---");

	new
		var = 5843,
		relative_address,
		value;

	#emit ADDR.pri var
	#emit STOR.S.pri relative_address

	printf("relative_address = 0x%x", relative_address);

	#emit LREF.S.pri relative_address
	#emit STOR.S.pri value

	printf("value = %d", value);
}

func3()
{
	print("--- METHOD 3 ---");

	new
		var = 5843,
		relative_address,
		value;

	#emit LCTRL 5
	#emit CONST.alt var
	#emit ADD
	#emit STOR.S.pri relative_address

	printf("relative_address = 0x%x", relative_address);

	#emit LREF.S.pri relative_address
	#emit STOR.S.pri value

	printf("value = %d", value);  
}
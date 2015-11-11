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
			relative_address = AMX_GetRelativeAddress(var), // Fonction propre à y_amx permettant de récupérer l'adresse relative d'une variable passée en argument
			value = AMX_RawRead(address); // Fonction propre à y_amx permmettant de récupérer la valeur à l'adresse relative d'une variable passée en argument

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

	#emit ADDR.pri var // On charge l'adresse relative de 'var' dans le registre primaire | frm + offs
	#emit STOR.S.pri relative_address // On stocke le contenu du registre primaire dans la variable 'address'

	printf("relative_address = 0x%x", relative_address);

	#emit LREF.S.pri relative_address // On récupére le contenu de la variable 'relative_address' en supposant que c'est une adresse relative et on va stocker sa valeur dans le registre primaire
	#emit STOR.S.pri value // On stocke le contenu du registre primaire dans la variable 'value'

	printf("value = %d", value);
}

func3()
{
	print("--- METHOD 3 ---");

	new
		var = 5843,
		relative_address,
		value;

	#emit LCTRL 5 // On charge dans le registre primaire le Frame Pointer | pri = frm
	#emit CONST.alt var // On charge dans le registre alterné l'adresse locale de la variable 'var'
	#emit ADD // On additionne le FRM et l'adresse locale de 'var' | pri += alt
	#emit STOR.S.pri relative_address // On stocke le contenu du registre primaire dans la variable 'relative_address'

	printf("relative_address = 0x%x", relative_address);

	#emit LREF.S.pri relative_address // On récupére le contenu de la variable 'relative_address' en supposant que c'est une adresse relative et on va stocker sa valeur dans le registre primaire
	#emit STOR.S.pri value // On stocke le contenu du registre primaire dans la variable 'value'

	printf("value = %d", value);  
}
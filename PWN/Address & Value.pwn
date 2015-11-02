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
			address = AMX_GetRelativeAddress(var), // Fonction propre à y_amx permettant de récupérer l'adresse d'une variable passée en argument
			value = AMX_RawRead(address); // Fonction propre à y_amx permmettant de récupérer la valeur à l'adresse d'une variable passée en argument

		printf("address = 0x%x", address);
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
		address,
		value;

	#emit ADDR.pri var // On charge l'adresse de 'var' dans le registre primaire | frm + offs
	#emit STOR.S.pri address // On stocke le contenu du registre primaire dans la variable 'address'

	printf("address = 0x%x", address);

	#emit LREF.S.pri address // On récupére le contenu de la variable 'address' en supposant que c'est un adresse et on va stocker sa valeur dans le registre primaire
	#emit STOR.S.pri value // On stocke le contenu du registre primaire dans la variable 'value'

	printf("value = %d", value);
}

func3()
{
	print("--- METHOD 3 ---");

	new
		var = 5843,
		address,
		value;

	#emit LCTRL 5 // On charge dans le registre primaire le FRM | pri = frm
	#emit CONST.alt var // On charge dans le registre alterné l'offset de 'var'
	#emit ADD // On additionne le FRM et l'offset | pri = pri + alt
	#emit STOR.S.pri address // On stocke le contenu du registre primaire dans la variable 'address'

	printf("address = 0x%x", address);

	#emit LREF.S.pri address // On récupére le contenu de la variable 'address' en supposant que c'est un adresse et on va stocker sa valeur dans le registre primaire
	#emit STOR.S.pri value // On stocke le contenu du registre primaire dans la variable 'value'

	printf("value = %d", value);  
}
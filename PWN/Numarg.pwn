#include "a_samp"
 
main()
{              
	printf("%d", func(1, 2, 3));
	printf("%d", func2(1, 2, 3));
	printf("%d", func3(1, 2, 3));
}

func(...)
{
	#emit LCTRL 5 // Le registre primaire stocke le frm | pri = frm
	#emit ADD.C 8 // On y ajoute 8 (2*sizeof(cell)) | pri += 8
	#emit LOAD.I // On récupère la valeur à l'adresse dat+pri (pri = frm+8) dans le registre primaire | pri = *(dat + frm + 8)
	#emit SHR.C.pri 2 // pri >>= 2 (pri / 4)
	#emit RETN // On retourne le résultat se trouvant dans le registre primaire
   
	return 0; // On évite le warning 209
}

func2(...)
{
	#emit LOAD.S.pri 8 // Le registre primaire stocke la valeur se trouvant à l'addresse dat+frm+8 | pri = *(dat + frm + 8)
	#emit SHR.C.pri 2 // pri >>= 2 (pri / 4)
	#emit RETN // On retourne le résultat se trouvant dans le registre primaire
   
	return 0; // On évite le warning 209
}

func3(...)
{
	return numargs_();
}

numargs_()
{
	#emit LOAD.S.pri 0 // Le registre primaire stocke la valeur se trouvant à l'adresse dat+frm | pri = *(dat + frm)
	#emit ADD.C 8 // pri += 8
	#emit LOAD.I // On récupère la valeur à l'adresse stockée par le registre primaire | pri = *(dat + pri)
	#emit SHR.C.pri 2 // pri >>= 2 (pri / 4)
	#emit RETN // On retourne le résultat se trouvant dans le registre primaire
	
	return 0;
}
#!/bin/bash
while true
do
clear
 
echo "1.-GESTION DEL ESPACIO EN DISCO"
echo "2.-GESTION DE USUARIOS"
echo "3.-SALIR"
 
read -p "Elige una opcion: " opcion
 
case $opcion in
 
1)
clear
echo "1.-GESTION DEL ESPACIO EN DISCO"
df -hT
read -p "pulse cualquier boton para continuar" 12345
;;
2)
while  true
do
clear
 
echo "4.-LISTAR USUARIOS DE UN GRUPO"
echo "5.-AÑADIR USUARIOS"
echo "6.-BORRAR USAURIOS"
echo "7.-ATRAS"
 
read -p "Elige una opcion: " opcionusuarios
 
case $opcionusuarios in
 
4)
clear
echo "4.-LISTAR USUARIOS DE UN GRUPO"
echo "estos son los grupos y los usuarios asignados;   "
cat /etc/group
read -p "pulse cualquier boton para continuar" 12345
 
;;
5)
clear
echo "5.-AÑADIR USUARIOS"
read -p "escriba el nombre de usuario para crearlo;      " usuario
useradd -m -s /bin/bash -p "$(mkpasswd -5 "$usuario")" "$usuario" #hay que poner un espacio de separacion
;;
 
6)
clear
echo "6.-BORRAR USAURIOS"
read -p "Escriba el nombre de usuario para borrarlo:      " nombre1
userdel -r "$nombre1"
echo "el usuario "$nombre1" fue borrado"
;;
7)
clear
break
;;
esac
done
;;
3)
clear
echo "salida exitosa"      
exit 0
;;
*)
clear
echo "opcion incorrecta, elija una opcion correcta  por favor"
;;
esac
done

#!/bin/bash
dpkg --get-selections > fichero
 
cat fichero | grep dialog > /dev/null 2>&1
 
if [ $? != 0 ]
then
echo "espere..."
apt install dialog > /dev/null 2>&1
rm fichero
fi
 
######################################################################################################
funcionMenu(){
dialog --nocancel --menu "Entornos Virtuales" 40 60 60 \
1 "GESTION DEL ESPACIO EN DISCO" \
2 "GESTION DE USUARIOS" \
3 "Salir" 2>opcion
opcion=$(cat opcion)
rm -f opcion
}
funcionMenu2(){
dialog --nocancel --menu "Entornos Virtuales" 40 60 60 \
4 "LISTAR USUARIOS DE UN GRUPO" \
5 "AÑADIR USUARIOS" \
6 "BORRAR   USUARIOS" 2>opcion
opcion=$(cat opcion)
rm -f opcion
}
funcionaccionesmenu2(){
 
case $opcion in
 
4)
cat /etc/group > grupo.txt
dialog --textbox "grupo.txt" 0 0 0>fapa2
use='cat fapa2'
rm -f fapa
;;
5)
dialog --nocancel --inputbox "Diga la ruta y el nombre del entorno que desea activar o desactivar Ej: /home/pc207/slaguens: " 0 0 2>fich.txt2
usuario=$(cat fich.txt2)
useradd -m -s /bin/bash -p "$(mkpasswd -5 "$usuario")" "$usuario" #hay que poner un espacio de separacion
;;
 
6)
dialog --nocancel --inputbox "Diga la ruta y el nombre del entorno que desea activar o desactivar Ej: /home/pc207/slaguens: " 0 0 2>fich.txt3
nombre1=$(cat fich.txt3)
userdel -r "$nombre1"
 
esac
}
funcionAccionesMenu(){
case $opcion in
1)
#almacenamiento
 
df -hT > almacenamiento.txt
dialog --textbox "almacenamiento.txt" 0 0 0>fapa
alma='cat fapa'
rm -f fapa
;;
 
2)
funcionMenu2
funcionaccionesmenu2
;;
3)
    dialog --infobox "Saliendo..." 0 0; sleep 1; clear; exit 69
;;
 
*)
dialog --msgbox --nocancel "No ha elegido una opcion valida, volviendo al menú principal" 0 0
;;
esac
}
 
 
if [ $? != 69 ]
then
while true
do
funcionMenu
funcionAccionesMenu
done
fi

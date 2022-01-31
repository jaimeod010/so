#!/bin/bash
 
#Autor: Joel
 
#Ejercicio3 entornos virtuales
 
funcionComprobacionRoot(){
if [ "$(id -u)" -ne 0 ]
then
    dialog --infobox "No eres el root, saliendo..." 0 0
    sleep 2; clear; exit
fi
}
funcionMenu(){
dialog --nocancel --menu "Entornos Virtuales" 40 60 60 \
1 "Crear entorno virtual" \
2 "Activar o desactivar entorno virtual" \
3 "Instalar paquetes" \
4 "Desinstalar paquetes" \
5 "Salir" 2>opcion
opcion=$(cat opcion)
rm -f opcion
}
funcionAccionesMenu(){
case $opcion in
1)
    apt policy virtualenv|grep -w "ninguno"
    if [ $? -eq 0 ]
    then
        apt-get install -y virtualenv
    fi
 
    apt-get policy python-virtualenv|grep -w "ninguno"
    if [ $? -eq 0 ]
    then
        apt-get install -y python-virtualenv
    fi
   
    respuesta=0
    while [ $respuesta -eq 0 ]
    do
        dialog --nocancel --inputbox "Introduzca la ruta absoluta donde quiere crear el entorno y el nombre. Ej /home/usuario/slaguens: " 0 0 2>fich
        env_name=$(cat fich)
        rm -f fich
       
        while [ -d "$env_name" ]
        do
            dialog --nocancel --inputbox "El directorio ya existe, elija otro: " 0 0 2>fich
        env_name=$(cat fich)
        rm -f fich
        done
       
        virtualenv "$env_name"
 
        dialog --nocancel --yesno "¿Desea crear otro?" 0 0
        respuesta=$(echo $?)
    done
;;
 
 
2)
    dialog --nocancel --inputbox "Diga la ruta y el nombre del entorno que desea activar o desactivar Ej: /home/pc207/slaguens: " 0 0 2>fich2
    env_nameActDes=$(cat fich2)
    rm -r fich2
   
    dialog --nocancel --menu "Menu Activar Entorno" 40 60 60 \
    1 "Activar" 2 "Desactivar" 2>opcion2
    opcion2=$(cat opcion2)
    rm -f opcion2
 
    case $opcion2 in
    1) # cd $env_nameActDes; dialog --infobox "Activando el entorno..." 0 0 ; sleep 1
    dialog --infobox "Activando el entorno..." 0 0 ; sleep 1
   
    source /env/"$env_nameActDes"/bin/activate
    ;;
    2) #cd $env_nameActDes; dialog --infobox "Desactivando el entorno... " 0 0; sleep 1
    dialog --infobox "Desactivando el entorno... " 0 0; sleep 1
#   cd $env_nameActDes
    deactivate
    ;;
    *) dialog --nocancel --msgbox "Opcion incorrecta, volviendo al menu" 0 0
    ;;
    esac
;;
 
 
3)
    dialog --nocancel --inputbox "Introduzca el paquete a instalar" 0 0 2>fich3
    name_paqIns=$(cat fich3)
    rm -f fich3
    dialog --infobox "Instalando $name_paqIns ..." 0 0 ;sleep 1; clear
    pip install "$name_paqIns"
;;
 
 
4)
    dialog --nocancel --inputbox "Introduzca el paquete a desinstalar" 0 0 2>fich4
    name_paqDes=$(cat fich4)
    rm -f fich4
    dialog --infobox "Desinstalando $name_paqDes ..." 0 0 ; sleep 1;clear
    pip uninstall -y "$name_paqDes"
;;
 
 
5)
    dialog --infobox "Saliendo..." 0 0; sleep 1; clear; exit
;;
 
 
*)
    dialog --msgbox --nocancel "No ha elegido una opcion valida, volviendo al menú principal" 0 0
;;
esac
}
 
funcionComprobacionRoot
 
opcion=0
 
while [ $opcion -lt 6 ]
do
    funcionMenu
    funcionAccionesMenu $opcion
done
 

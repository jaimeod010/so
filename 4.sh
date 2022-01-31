
#!/bin/bash
 
 
fecha=$(date +%d-%m-%Y-%H:%M) #para no poner el comando entero
 
#restaurar tar -zcvf $nombredeusuario.$fecha.tar.gz  /home/$nombredeusuario
#fuciones
#############################################################################################################################################################################################################################################################################################################################################################################################
 
################################copiar
comprobarroot(){
if [ "$(whoami)" = root ] #aqui comprobamos si eres el root, y si no lo eres pues te expulsa del script
 
then
 
echo "eres el root"
 
else
 
echo "no eres el root"
exit 1
fi
}
 
comprobarcarpetacopias(){ #creacion del directorio
cd /home/usuario/examen/ejer4/copia_home > /dev/null 2>&1
    if [ $? = 0 ]
    then
    echo ""
    else
    mkdir /home/usuario/examen/ejer4/copia_home
    cd /home/usuario/examen/ejer4/copia_home
    fi
}
 
 
usuariosdelsistema(){ #por si el usuario usa una bash o zsh (yo uso zsh)
getent passwd | grep /bin/bash|grep -v "root" | cut -d: -f1
getent passwd | grep /bin/zsh|grep -v "root" | cut -d: -f1
}
 
 
comprobarsiestaconectado(){
    w |grep -w "$nombredeusuario" #con el codigo de error puedo comprobar
    if [ $? = 0 ]
    then
    clear
    echo "el usuario esta conectado"
    echo "no se puede hacer la copia de seguridad"
    exit 1
    else
    clear
    echo "el usuario no esta conectado"
    fi
 
}
 
 
comprobardirectoriodelusuario(){
   
ls /home/$nombredeusuario > /dev/null 2>&1
if [ $? = 0 ]
then
echo ""
#HACE LA COPIA
 
tar -zcvf  /home/usuario/examen/ejer4/copia_home/$nombredeusuario.$fecha.tar.gz /home/$nombredeusuario > /dev/null 2>&1
 
else
echo "El directorio /home/$nombredeusuario no existe"
exit 1
fi
}
 
copia(){
    echo "usuarios disponibles: "
    echo "\n"
usuariosdelsistema                                                      ##llamo a los usuarios del sistema
 
    read -p "Dime un nombre de usuario: " nombredeusuario
        comprobarsiestaconectado                                      #compruebo si esta conectado el usuario
        comprobardirectoriodelusuario
}
 
 
 
################################restaurar
 
restaurar(){
echo "usaurios disponibles: "
echo "\n"
    usuariosdelsistema                                                      ##llamo a los usuarios del sistema
 
read -p "Dime un nombre de usuario para la restauracion: " nombredeusuario
    clear
    comprobarsiestaconectado
    clear
    ls /home/usuario/examen/ejer4/copia_home |nl -s.-
read -p "Dime cual quieres restaurar" restauracion
echo "ha seleccionado"
ls |nl -s.-|grep -w "$restauracion"|
 
 
 
cd /home/usuario/examen/ejer4/copia_home
restauracioncopia=$(ls |nl -s.-|grep -w "$restauracion"|cut -d- -f2-8)
tar -zxvf /home/usuario/examen/ejer4/copia_home/$restauracioncopia.tar.gz -C /home/$nombredeusuario > /dev/null 2>&1
}
 
 
################################borrar copias de hace mas de 30 dias
 
borrar(){
    find /home/usuario/examen/ejer4/copia_home/  -type f -mtime +30 -delete
 
 
}
 
#############################################################################################################################################################################################################################################################################################################################################################################################
 
 
#script
#############################################################################################################################################################################################################################################################################################################################################################################################
 
comprobarroot
comprobarcarpetacopias
trap ctrl_c INT
while true
do
echo "-----------------------------------------------------"
 
echo "1.-Realiza copia de Seguridad"
 
echo "2.-Restaura copia de Seguridad"
 
echo "3.-Borrar copia de hace mas de 30 dias"
 
echo "4.-salir"
 
echo "-----------------------------------------------------"
 
read -p "Insetar un numero" opcion
case $opcion in
 
 
 
1)
copia
;;
 
2)
restaurar
;;
 
3)
borrar
;;
 
4)
exit 0
;;
 
*)
echo "elija otro numero"
;;
esac
done
#############################################################################################################################################################################################################################################################################################################################################################################################

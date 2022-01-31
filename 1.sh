#!/bin/bash
rm *.tots
cat archivo.txt|cut --characters=1 archivo.txt >1.tmp #cojo el primer caracter
 
cat archivo.txt|awk -F : '{print $2}'|cut --characters=1-3 > 2.tmp # te coje los 3 primeros caracteres de la parte 2 separada por :
 
cat archivo.txt|awk -F : '{print $3}'|cut --characters=1-3 > 3.tmp # lo mismo pero con el 3 campo
 
cat archivo.txt|awk -F : '{print $5}' > 5.tmp  # te coje el campo 5
 
cat archivo.txt|awk -F : '{print $4}' > 4.tmp # te coje el campo 5
 
###################################################################
 
 
###################################################################
 
paste -d "" 1.tmp 2.tmp 3.tmp > 10.tap
 
paste -d : 5.tmp 4.tmp > 20.tap
##########
numero=$(nl 10.tap |awk -F" " '{print $1}'| tail -n1)
 
for i in $(seq "$numero")
 
do
 
echo "mv$i"  >> 30.tap
 
done
#########
paste -d - 10.tap 30.tap > 40.tap
 
paste -d : 40.tap 20.tap > 60.tots
 
 
rm *.tap
rm *.tmp
 
 
cat 60.tots
 
echo "segunda parte"
 
sleep 1
nombre=$(cat 60.tots|cut -d: -f1)
ram=$(cat 60.tots|cut -d: -f2)
tamano=$(cat 60.tots|cut -d: -f3)
 
archivo=$(cat 60.tots)
for i in $archivo
do
    qemu-img create -f qcow2 -o size=$tamano /var/lib/libvirt/images/$nombre.qcow2
 
    virt-install - -connect qemu:///system --name $nombre --ram $ram --disk path=/var/lib/libvirt/images/$nombre.qcow2,size=$tamano"GB" --vcpus=1 -c /var/lib/libvirt/images/iso/debian10.iso --vnc --ostype=Linux --network bridge=virbr0 --noautoconsole --hvm --keymap es
 
done
 

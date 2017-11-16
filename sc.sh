LAN="192.168.1."
log="ip.log"

for i in {117..118}
do

old[$i]=${out[$i]}
ping -c 1 ${LAN}${i} >> /dev/null
out[$i]=$?
[ ${old[$i]} = ${out[$i]} ] && unset old[$i]
done

if [ ${#old[@]} -gt 0 ]
then
 for i in ${!old[@]} ; do
  echo "${LAN}${i} ${old[$i]} -> ${out[$i]}"
 done
fi

echo ${out[@]} > $log

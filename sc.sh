log="ip.log"
for ip in "10.7.180."{142..144}
do

ping -c 1 $ip >> /dev/null
[ $? = 0 ] && out+=("$ip+") || out+=("$ip-")
done

if [ -f $log ]
then
 mv $log "${log}.old"
 echo ${out[@]} > $log
 diff $log "${log}.old"
else
 echo ${out[@]} > $log
fi

LAN="192.168.1."
log="ip.log"
if [ -f $log ]
then
 let tlc="`date +%s` - `stat -c%Y $log`"
 [ 180 -le $tlc ] && invalidate=true
 out=( $(cat $log) )
else
 eval "out=(`echo [{0..254}]=2`)"
fi

for i in {117..118}
do

if [ ${out[$i]} = 2 -o "$invalidate" = true ]
then
old[$i]=${out[$i]}
ping -c 1 ${LAN}${i} >> /dev/null
out[$i]=$?
[ ${old[$i]} = ${out[$i]} ] && unset old[$i]
fi
done

if [ ${#old[@]} -gt 0 ]
then
 for i in ${!old[@]} ; do
  echo "${LAN}${i} ${old[$i]} -> ${out[$i]}"
 done
 invalidate=true
fi

[ "$invalidate" = true ] && echo ${out[@]} > $log

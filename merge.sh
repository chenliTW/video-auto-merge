chk=0
while read line
do
   if [ "$line" = "---" ]; then
      echo "ffmpeg -f concat -safe 0 -i "$filename.txt" -c copy "$filename" &" 
      ffmpeg -y -f concat -safe 0 -i "$filename.txt" -c copy "$filename" & > /dev/null
      chk="0"
   elif [ "$chk" = "0" ];then
      filename=`echo $line | tr -d '"'`
      chk="1"
      rm $filename.txt
   else
      echo file \'`echo $line | tr -d '"'`\' >> $filename.txt
   fi
done < $1
wait


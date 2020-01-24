chk=0
cat $1 | while read line
do
   if [ "$line" == "---" ]; then
      echo "ffmpeg -f concat -safe 0 -i "$filename.txt" -c copy "$filename" &" 
      ffmpeg -f concat -safe 0 -i "$filename.txt" -c copy "$filename.mp4" & > /dev/null
      chk="0"
   elif [ "$chk" == "0" ];then
      filename=`echo $line | tr -d '"'`
      chk="1"
      rm $filename.txt
   else
      echo file `echo $line | tr -d '"'` >> $filename.txt
   fi
done


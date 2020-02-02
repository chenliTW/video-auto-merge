chk=0
cat $1 | while read line
do
   if [ "$line" = "---" ]; then
      ffmpeg -y -i $infile -vcodec copy -acodec copy -ss $starttime -to $endtime $outfile &
      chk=0
   elif [ $chk -eq 4 ];then
      ffmpeg -y -i $infile -vcodec copy -acodec copy -ss $starttime -to $endtime $outfile &
      outfile=`echo $line | tr -d '"'`
      chk=2
   elif [ $chk -eq 0 ];then
      infile=`echo $line | tr -d '"'`
      chk=1
   elif [ $chk -eq 1 ];then
      outfile=`echo $line | tr -d '"'`
	   chk=2
   elif [ $chk -eq 2 ];then
      starttime=`echo $line | tr -d '"'`
      chk=3
   elif [ $chk -eq 3 ];then
      endtime=`echo $line | tr -d '"'`
      chk=4
   fi
done


 
  usage: work [option]
 
   This tool stores and executes commands as key-value pairs
 
   [option]:
      (none)   displays this message
      --help   displays this message
       [key]   execute the cmd value specified for 'key'
   get [key]   prints the cmd value specified for 'key'
   set [key]   sets previous cmd as the value for 'key'
    rm [key]   removes cmd 'key'
 
      [key]:
   samplecmd   echo "hello, this is a sample cmd";
      looper   for ((i=0; i<5; i++)); do echo $i; done
 aws-ssh-add   ssh-add /home/jmorga27/.ssh/LightsailDefaultKey-us-west-2.pem
   litegrade   cd /home/jmorga27/Cal_Poly/Kurfess/litegrade;
           0   echo "this is the cmd with key '0'"
      cp-vpn   . /home/jmorga27/Cal_Poly/cal_poly_vpn
  clean-clip   xclip -o > temp_f; cat temp_f | xclip; rm temp_f;
         569   cd /home/jmorga27/Cal_Poly/569/
      thesis   cd /home/jmorga27/Thesis
      resume   cd /home/jmorga27/Job_Applications/Resumes/Justin


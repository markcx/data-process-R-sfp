#############################
#Function - readinData
#    arg - file path
#    return - object 
#############################         
readinData<-function(file, i){
	#print(mode(file));
	#print(class(file));
	#print(is.character(file));
	
	if(is.character(file)){
	   obj<-process(file,i) 
	   #print(obj); 
	   return(obj)			
	}
	
}

#############################
#Function - process
#    arg - path of the data file (default=NA),
#	   - int k (radomize the color to differ the date plot line)  	
#    return - list object
#############################
process<-function(file="NA", k=1){
	data<-read.csv(file, header=F);
	j=1;
	timecount=nlevels(as.factor(data$V1));
	vec.OCC <-array();
	vec.OPER <-array();
	sum.OCC <-0;  #latent var
	sum.OPER <-0; #latent var
	#print(nrow(data));
	##begin for loop to calculate 
	for(i in 1:nrow(data)){
		#print(data[i,1]);
	    if((i+1)<=nrow(data)){
		  if(is.numeric(data[i+1,1]) && (data[i,1]!=data[i+1,1])){
		  	vec.OCC[j]<-sum.OCC;
			vec.OPER[j]<-sum.OPER;
			j<-j+1
			sum.OCC<-0;
			sum.OPER<-0

		  }else{
		      if(data[i,6]>=0 && data[i,8]>=0){
			    sum.OCC<-sum.OCC + data[i,6];
			    sum.OPER<-sum.OPER + data[i,7];
			}
    		  }	
	    }else{
		  print("bounded at the end")
		  vec.OCC[j]<-sum.OCC;
		  vec.OPER[j]<-sum.OPER;	
          }
		
	} #end of for loop
	vec.RATIO = vec.OCC/vec.OPER
	return(list(timecount, vec.OCC, vec.OPER, vec.RATIO));
	#with(data, lines(c(1:timecount), c(vec.OCC), col="blue", lty=2, pch=(24%%i)));
}

#setwd("C:/Users/MarkCX/Documents/workspace_R")
setwd("J:/workspace_dev/work_R/SFpark-data-process-R")

############################
#It plots the ratio of occupency
#
############################

#############################
#Function - readinData
#    arg - file path
#    return - object 
#############################         
readinData<-function(file, i, list=c() ){
	#print(mode(file));
	#print(class(file));
	#print(is.character(file));
	
	if(is.character(file)){
	   obj<-process(file,i, list) 
	   #print(obj); 
	   return(obj)			
	}
	
}
##########################
#Function readin zip code file
##########################
zipCodeMap<-function(file="NA"){
	zipcodeMap<-read.csv(file, header=F);
	return(zipcodeMap);
}

#############################
#Function - process
#    arg - path of the data file (default=NA),
#	   - int k (radomize the color to differ the date plot line)  	
#    return - list object
#############################

process<-function(file="NA", k=1, pCellIDlist=c()){
	data<-read.csv(file, header=F);
	#print(data[1,]);
	#print(pCellIDlist)
	j=1;
	timecount=nlevels(as.factor(data$V1));
	vec.OCC <-array();
	vec.OPER <-array();
	sum.OCC <-0;  #latent var
	sum.OPER <-0; #latent var
	#print(nrow(data));
	##begin for loop to calculate 
	for(i in 1:nrow(data)){
		
	    if((i+1)<=nrow(data)){
		  if(is.numeric(data[i+1,1]) && (data[i,1]!=data[i+1,1])){
		  	vec.OCC[j]<-sum.OCC;
			vec.OPER[j]<-sum.OPER;
			j<-j+1
			sum.OCC<-0;
			sum.OPER<-0

		  }else{
			for(j in 1:length(pCellIDlist)){
		        if((data[i,2]=="ON") && data[i,6]>=0 && data[i,8]>=0 && (data[i,5]==pCellIDlist[j])){
			    		 	
					sum.OCC<-sum.OCC + data[i,6];
			    		sum.OPER<-sum.OPER + data[i,7];
				     
				}
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




###########################
# main part of the program
###########################

FILE_PREFIX<-"J:/workspace_dev/work_R/SFpark-data-process-R/data/";
FILE_DATE_PREFIX<-"2013_07_";
ZIPCODE_TABLE_PATH<-"zipcode/Pcellzipcode.txt"
FILE_APPENDIX<-".csv";
#layout(matrix(c(1,2), nrow = 1), widths = c(0.7, 0.3))
#par(mar=c(5,4,4,19)+0.1, xpd=TRUE);
plot(NA, xlim=c(0,24), ylim=c(0,1), xlab="time(24 hr)", ylab="occupancy ratio");
DateSet<-array();
ColorSet<-array();
LineTypeSet<-array();
RefLineSet<-array();
n=1;
#WeekDaySet<-c(1:3,-1,5,-1, -1, 8:12, -1,-1,15:19, -1,-1,22:26,-1,-1,-1,30:31);
#WeekDaySet<-c(1:3,-1,5);
WeekDaySet<-c(1:2);

#print(paste(FILE_PREFIX,ZIPCODE_TABLE_PATH,sep=""));
path<-paste(FILE_PREFIX,ZIPCODE_TABLE_PATH,sep="")
zipTable<-zipCodeMap(path);

zipPool=levels(as.factor(zipTable$V2));

IDpool=c();
#start from first zipcode 
k=5;
###loop over zip table to extract a id pool
for(i in 1:nrow(zipTable)){
	if(as.numeric(zipPool[k])==zipTable$V2[i]){
		IDpool=c(IDpool, zipTable$V1[i])
	}
}


for (i in WeekDaySet){
  #print(i)	
  if(i>0){
      fileDatePre<-FILE_DATE_PREFIX;
	
	if(nchar(as.character(WeekDaySet[i]))==1){
		fileDatePre<-paste(FILE_DATE_PREFIX, as.character(0), sep="");
      }
	
	filepath<-paste(FILE_PREFIX, fileDatePre, as.character(i),FILE_APPENDIX, sep="");
	
	DateSet[n]<-paste(FILE_DATE_PREFIX, as.character(i), " occ rate", sep="");
	##DateSet[n+1]<-paste(FILE_DATE_PREFIX, as.character(i), " oper num", sep="");
	print(filepath)
	obj<-readinData(filepath, i, IDpool)
	##print(obj[[1]][1]);
	with(obj, lines(c(1:obj[[1]][1])/12, c(obj[[4]]), col=i%%5+1, lty=1, pch=24));
	refLineX=which.max(obj[[4]])
	RefLineSet[i]<-refLineX
	#lines(c(refLineX, refLineX), c(0,1), lty=2, col=6) 
      ##lines(c(1:obj[[1]][1]), c(obj[[3]]), col=i%%5+1, lty=2);
	ColorSet[n]<-i%%5+1;
	##ColorSet[n+1]<-i%%5+1;
	LineTypeSet[n]<-1;
	##LineTypeSet[n+1]<-2;
      ###lines(c(1:obj[[1]][1]), c(obj[[2]]), col=255%%i, lty=1, pch=24)
	n<-n+1;
   }
}
#refPeak<-mean(RefLineSet)
refIndex<-which(!is.na(RefLineSet))
sumTemp=0;
for(i in refIndex){
	sumTemp<-sumTemp+RefLineSet[i];
}
refPeak=sumTemp/length(refIndex);   #averaging the time point which has highest occupancy.
lines(c(refPeak, refPeak), c(0,1), lty=2, col=6)
#legend("topright", inset=c(-0.45,0), c(DateSet), col=c(ColorSet),lty=c(LineTypeSet), cex=0.8);


#lines(c(1:obj[[1]][1]), c(obj[[2]]), col="blue", lty=1, pch=24)

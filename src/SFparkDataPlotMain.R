setwd("J:/workspace_dev/work_R/SFpark-data-process-R")
source("ProcessDataModul.R");	#workspace in same directory
###########################
# main part of the program
###########################
##FILE_PREFIX<-"C:/Users/MarkCX/Downloads/";
FILE_PREFIX<-"J:/workspace_dev/work_R/SFpark-data-process-R/data/";
FILE_DATE_PREFIX<-"2013_07_";
FILE_APPENDIX<-".csv";
##########################
par(mar=c(5,4,4,17)+0.1, xpd=TRUE);
plot(NA, xlim=c(0,289), ylim=c(0,1), xlab="time", ylab="number of parking spaces");
DateSet<-array();  #legend label
ColorSet<-array(); #legend color label
LineTypeSet<-array(); #legend line type

n=1;

WeekDaySet<-c(1:5,-1, -1, 8:12, -1,-1,15:19, -1,-1,22:26,-1,-1,-1,30:31);

for (i in WeekDaySet){
    if(i>0){
	fileDatePre<-FILE_DATE_PREFIX;
	
	if(nchar(as.character(WeekDaySet[i]))==1){
		fileDatePre<-paste(FILE_DATE_PREFIX, as.character(0), sep="");
      }
	
	filepath<-paste(FILE_PREFIX, fileDatePre, as.character(i),FILE_APPENDIX, sep="");

	DateSet[n]<-paste(FILE_DATE_PREFIX, as.character(i), " Occupied Num", sep="");
	DateSet[n+1]<-paste(FILE_DATE_PREFIX, as.character(i), " Operation Num", sep="");
	print(filepath)
	obj<-readinData(filepath, i)
	#print(obj[[1]][1]);
	with(obj, lines(c(1:obj[[1]][1]), c(obj[[4]]), col=i%%5+1, lty=1, pch=24));
	#lines(c(1:obj[[1]][1]), c(obj[[3]]), col=i%%5+1, lty=2);
	ColorSet[n]<-i%%5+1;
	#ColorSet[n+1]<-i%%5+1;
	LineTypeSet[n]<-1;
	#LineTypeSet[n+1]<-2;
      #lines(c(1:obj[[1]][1]), c(obj[[2]]), col=255%%i, lty=1, pch=24)
	n=n+1;
    }
}
legend("topright", inset=c(-0.95,0), c(DateSet), col=c(ColorSet),lty=c(LineTypeSet),cex=0.8);


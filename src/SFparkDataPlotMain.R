setwd("C:/Users/MarkCX/Documents/workspace_R")
source("ProcessDataModul.R");	#workspace in same directory
###########################
# main part of the program
###########################
FILE_PREFIX<-"C:/Users/MarkCX/Downloads/";
FILE_DATE_PREFIX<-"2013_07_";
FILE_APPENDIX<-".csv";
#layout(matrix(c(1,2), nrow = 1), widths = c(0.7, 0.3))
par(mar=c(5,4,4,15)+0.1, xpd=TRUE);
plot(NA, xlim=c(0,289), ylim=c(0,16000), xlab="time", ylab="number of parking spaces");
DateSet<-array();  #legend label
ColorSet<-array(); #legend color label
LineTypeSet<-array(); #legend line type

n=1;

WeekDaySet<-c(15:19, 22:26, 30:31)
for (i in WeekDaySet){
	filepath<-paste(FILE_PREFIX, FILE_DATE_PREFIX,as.character(i),FILE_APPENDIX, sep="");
	print(filepath)
	DateSet[n]<-paste(FILE_DATE_PREFIX, as.character(i), " Occupied Num", sep="");
	DateSet[n+1]<-paste(FILE_DATE_PREFIX, as.character(i), " Operation Num", sep="");
	obj<-readinData(filepath, i)
	#print(obj[[1]][1]);
	with(obj, lines(c(1:obj[[1]][1]), c(obj[[2]]), col=i%%5+1, lty=1, pch=24));
	lines(c(1:obj[[1]][1]), c(obj[[3]]), col=i%%5+1, lty=2);
	ColorSet[n]<-i%%5+1;
	ColorSet[n+1]<-i%%5+1;
	LineTypeSet[n]<-1;
	LineTypeSet[n+1]<-2;
      #lines(c(1:obj[[1]][1]), c(obj[[2]]), col=255%%i, lty=1, pch=24)
	n=n+2;
}
legend("topright", inset=c(-0.95,0), c(DateSet), col=c(ColorSet),lty=c(LineTypeSet));


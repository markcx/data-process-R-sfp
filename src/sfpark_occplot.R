setwd("C:/Users/MarkCX/Documents/workspace_R")
data<-read.csv("C:/Users/MarkCX/Downloads/2013_06_21.csv", header=F)
j=1;
timecount=nlevels(as.factor(data$V1));
vec.OCC <- array();
vec.OPER <- array();
sum.OCC <-0;
sum.OPER <-0;
for(i in 1: nrow(data)){
	#print(data[i,1])
	if((i+1)<=nrow(data)){
		if( is.numeric(data[i+1,1]) && ( data[i,1]!= data[i+1,1]) ){	
			vec.OCC[j]<-sum.OCC;
			vec.OPER[j]<-sum.OPER;
			j<-j+1
			#print(j);
			#print("show")
			#print(sum.OPER)	
			sum.OCC<-0;
			sum.OPER<-0
		}else{		
			if(data[i,6]>=0 && data[i,8]>=0){
				sum.OCC <- sum.OCC + data[i,6]	
				sum.OPER <- sum.OPER + data[i,7]
			}
		
		}	
	}else{
		print("bounded at the end")
		vec.OCC[j]<-sum.OCC;
		vec.OPER[j]<-sum.OPER;
	}
	
}
ratio.day = vec.OCC/vec.OPER
picspar<-par(mfrow=c(1,2), no.readonly=TRUE )
plot(c(1:timecount), c(ratio.day), xlim=c(0,288), ylim=c(0,1), type="l", col="blue", pch=16, cex=0.7)
plot(c(1:timecount), c(vec.OCC), xlim=c(0,288), ylim=c(0,max(vec.OPER)), type="l", col="green", pch=16, cex=0.7)
lines(c(1:timecount), c(vec.OPER))


#plot(c(0:289), c(0,ratio.day,1), col="blue", pch=16, cex=0.7)
#plot(c(0:289), c(0,vec.OCC, max(vec.OPER)), pch=16, cex=0.5)
#lines(c(0:289), c(0,vec.OPER, max(vec.OPER))) 

#lines(c(0:289), c(0,vec.OCC, max(vec.OPER)))
#lines(c(0:289), c(0,vec.OPER, max(vec.OPER)))


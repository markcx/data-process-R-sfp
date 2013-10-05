initT=0;
j<-1;
GeoElement<-array();
for(i in 1:nrow(data)){
	if(initT==0){
		initT=data[i,1];
	}
	
	if(initT==data[i,1]){
		print(data[i,10]);
		GeoElement[j]<-as.character(data[i,10]);
	}else{
		print("redantent");
		break;
	}
	j<-j+1;
}

filteredGeoLoc<-c();
j<-1;
for(j in GeoElement){
	x<-strsplit(GeoElement[j]);
	
}
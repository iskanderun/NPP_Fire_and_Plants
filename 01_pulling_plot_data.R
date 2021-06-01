detach("package:BIEN", unload = TRUE)
library(todoBIEN)
source("C:/Users/Brian/Desktop/current_projects/RtodoBIEN/todoBIEN/tests/password_and_username.R")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Desired output:

#1) global file "gentry_statevar"

#gentry_name    S   N        E                                  lat              long
#gentrysite1    34  233   (sum of all dbh's)         (lat of site)   (long of site)
#gentrysite2    22  988   (sum of all dbh's)         (lat of site)   (long of site)


#2) plot-specific files  "gentrysite1_IPD"

#spp             count        dbh
#ACAME         1            1.2
#ACAME         1            0.9
#HETVIL          1           0.2


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Pull stem data from gentry plots in private BIEN
gentry<-todoBIEN::BIEN_stem_sampling_protocol(sampling_protocol = "0.1 ha  transect, stems >= 2.5 cm dbh",cultivated = T,only.new.world = F,natives.only = F,all.metadata = T,all.taxonomy = T,user=user,password=password)
unique(gentry$plot_name) #350+ plots

#Make empty output file
gentry_statevar<-matrix(nrow = length(unique(gentry$plot_name)),ncol = 6)
gentry_statevar<-as.data.frame(gentry_statevar)
colnames(gentry_statevar)<-c("gentry_name","S","N","E","lat","long")


#Iterate through plots
  #a) populate output file
  #b) split plots into seperate files for some reason

for(i in 1:length(unique(gentry$plot_name))){

  print(i/length(unique(gentry$plot_name)))
  
#part to populate output file
data_i<-gentry[which(gentry$plot_name==unique(gentry$plot_name)[i]),]
data_i$scrubbed_species_binomial[which(is.na(data_i$scrubbed_species_binomial))]<-data_i$verbatim_scientific_name[which(is.na(data_i$scrubbed_species_binomial))]

gentry_statevar$gentry_name[i]<-unique(gentry$plot_name)[i]  
gentry_statevar$S[i]<-length(unique(data_i$scrubbed_species_binomial))
gentry_statevar$N[i]<-nrow(data_i)
gentry_statevar$E[i]<-sum(data_i$stem_dbh_cm,na.rm = T)
gentry_statevar$lat[i]<-unique(data_i$latitude)
gentry_statevar$long[i]<-unique(data_i$longitude)


#part to split plots into separate csv's
#spp             count        dbh
#ACAME         1            1.2
#ACAME         1            0.9
#HETVIL          1           0.2



#make csv output file
outcsv<-NULL
outcsv<-matrix(nrow = nrow(data_i),ncol = 3)
outcsv<-as.data.frame(outcsv)
colnames(outcsv)<-c("spp","count","dbh")

outcsv$spp<-data_i$scrubbed_species_binomial
outcsv$count<-1
outcsv$dbh<-data_i$stem_dbh_cm

#write csv output file 
write.csv(x = outcsv,file = paste("genry_data_for_erica/",unique(gentry$plot_name)[i],"_IPD",".csv",sep = ""),row.names = F)

}

#write gentry_statevar output
write.csv(x = gentry_statevar,file = "gentry_statevar.csv",row.names = F)


#clean up workspace
rm(data_i,i,outcsv)



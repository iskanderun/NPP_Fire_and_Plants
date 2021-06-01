#extracting state variables from Gentry plots
# EA Newman newmane@berkeley.edu
# last changed 26 JAN 2018

###########
## Clean up

layout(matrix(1:1, ncol=1))
rm(list=ls(all=TRUE))
###########


setwd("~/Desktop/Working_manuscripts/METE_biomes/R_code")
#df <- read.csv("population_clean.csv", header = TRUE, sep=",")

dat <- read.csv("gentry_plots_sample.csv", sep = ",", header = TRUE)
head(dat)
#df <- dat[,c(1,2,3,4,7,8,29,30)]
df <- dat[,c(1,7,8)]
head(df)
unique(df$elevation_m)

m <- df[which(df$plot_name=='PARQUEER'),]
m

unique(df$scrubbed_species_binomial)


#require("plyr")
#count(gen1, c("scrubbed_species_binomial", "individual_count"))
aggregate(m$individual_count ~ m$scrubbed_species_binomial, 
          data = m, sum)
n_1 <- sum(m$individual_count)
n_1
s_1 <- length(m$scrubbed_species_binomial)
s_1


sites <-unique(dat$plot_name)
dim(sites) <- c(length(sites),1)
sites


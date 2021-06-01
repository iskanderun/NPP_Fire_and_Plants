# graphing state variables of Gentry plots
# EA Newman newmane@berkeley.edu
# last changed 30 DEC 2019

###########
## Clean up

layout(matrix(1:1, ncol=1))
rm(list=ls(all=TRUE))
###########

library("rgl")
install.packages("plot3D")
library("plot3D")
install.packages("plot3Drgl")
library("plot3Drgl")

###########

#setwd("~/Desktop/Working_manuscripts/METE_biomes/R_code")
setwd("~/Desktop/R_scripts/Gentry/R_outputs")

df_gen <- read.csv("gentry_statevar.csv", header = TRUE, sep=",")
df <- df_gen
dim(df)
head(df)

df2 <- data.frame(x=df$E,
                  y=df$S,
                  z=df$N)


head(df2)
x <- df2$x
y <- df2$y
z <- df2$z

###
plot3d(df2,xlim=c(700,8000),ylim=c(10,300),zlim=c(20,1200),
       col = rainbow(20),size=9)
####

# use plot3D


g <- scatter3D(x, y, z, bty = "g", colkey = FALSE,
          #col = ramp.col(c("blue", "yellow", "red")),
          xlab = "E", ylab = "S", zlab = "N", colvar = y,
          phi = 30, type = "h",
          pch = 20, cex = 1, ticktype = "simple")

scatter3D(x, y, z, bty = "g", colkey = FALSE,
          #col = ramp.col(c("blue", "yellow", "red")),
          xlab = "E", ylab = "S", zlab = "N", colvar = y,
          theta = 30, phi = 30, type = "h",
          pch = 20, cex = 1, ticktype = "simple")

scatter3D(x, y, z, bty = "g", colkey = FALSE,
          #col = ramp.col(c("blue", "yellow", "red")),
          xlab = "E", ylab = "S", zlab = "N", colvar = y,
          theta = 60, phi = 30, type = "h",
          pch = 20, cex = 1, ticktype = "simple")

plotrgl()


fit <- lm(z ~ x + y)
# predict values on regular xy grid
grid.lines = 26
x.pred <- seq(min(x), max(x), length.out = grid.lines)
y.pred <- seq(min(y), max(y), length.out = grid.lines)
xy <- expand.grid( x = x.pred, y = y.pred)
z.pred <- matrix(predict(fit, newdata = xy), 
                 nrow = grid.lines, ncol = grid.lines)
# fitted points for droplines to surface
fitpoints <- predict(fit)

scatter3D(x, y, z, pch = 18, cex = 1, 
          theta = 20, phi = 20, ticktype = "simple",
          xlab = "E", ylab = "S", zlab = "N",  
          surf = list(x = x.pred, y = y.pred, z = z.pred,  
                      facets = NA, fit = fitpoints))

plotrgl()



#### 


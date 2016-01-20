# make sure you have all the following libs installed. If not, use install.packages() 
# to get them
library(ggplot2)
library(grid)


rm(list=ls())

# set the seed as the last three digits of your student ID
seed = 111

if (seed == 111) {
  stop("\nThe random generator seed is still set to its default value.\nEdit the script and change it with the last three digits of your student ID\n\n", 
       call. = FALSE)
}
set.seed(seed)

# add other global variable initializations here

################################# FUNCTION DEFINITION #######################################

vol_of_sphere <- function(dim, N) {
  m <- matrix(runif(dim*N,-1,1), ncol=dim)
  sum(sqrt(rowSums(m^2)) <= 1) / N
}


rand_dist_origin <- function(N,dim) {
  m <- matrix(rnorm(N*dim),ncol=dim)
  v <- sqrt(rowSums(m^2))
  return(c(avg = mean(v), min = min(v), max = max(v)))
}

perform_lda_prediction <- function(fit, data, labels) {
  pred = predict(fit, as.data.frame(data))
  class = pred$class
  table(class,labels)
  mean(class == labels)
}

################################# MAIN CODE ###########################################
cat("
-------------------------------------------------------------------------------------
Welcome to the second PAMI demo/homework (year 2016): curse of dimensionality
    
The \"curse of dimensionality\" is a phenomenon (or, better, many phenomena)
occurring when the dimensionality of your problem, e.g. the number of features
that characterizes your observation, increases. When this happens, data tends
to become sparse, making it difficult for any method which requires statistical
significance to work properly.
    
Let us try few examples from http://www.joyofdata.de/blog/curse-dimensionality/
and comment them.
    
")

invisible(readline(prompt = "Press [enter] to continue"))  


N = 1000000 # this is the number of points filling the hyperbox, decrease if too slow

df <- data.frame(
  dim <- 1:15,
  v <- sapply(1:15, function(dim) vol_of_sphere(dim,N))
)

ggplot(df,aes(dim,v)) + 
  geom_point(colour=I("red"), size=I(5), alpha=I(0.5)) + 
  geom_line(colour=I("red"), size=I(.2), alpha=I(0.5)) +
  scale_x_discrete() + 
  labs(title="Ratio between volume of sphere and its containing box",
       x="#dimensions", 
       y="volume ratio") + 
  scale_y_continuous(breaks=0:10/10) + 
  theme(axis.text.x = element_text(colour="black"), 
        axis.text.y = element_text(colour="black"), 
        axis.title.x = element_text(vjust=-0.5, size=15), 
        axis.title.y = element_text(vjust=-0.2, size=15), 
        plot.margin = unit(c(1,1,1,1), "cm"), 
        plot.title = element_text(vjust=2, size=17))  

cat("
This first example shows how the ratio between the volume of a (hyper)sphere
of radius 1 and its containing (hyper)box when the number of dimensions 
increases. Answer the following questions:

Q1) How is this ratio calculated? Look at the code and tell how the volumes
of the sphere and the hypercube are found.

Q2) What is the actual meaning of this plot? What does it mean for a point
in the box to fall or not within the sphere too?

")

invisible(readline(prompt = "Press [enter] to continue"))  

cat("
One of the main concepts whose interpretation is affected by the curse 
of dimensionality is the one of *similarity*, that here is dual to distance.

Q3) Check out the code that generates the following results. What does it do?
Modify the \"dim\" variable and comment the results of the summary() command

")
    
# try to run the following code manually, change dim and comment the results of summary(d)
dim = 2
m <- matrix(runif(dim*N,-1,1), ncol=dim)
d = sqrt(rowSums(m^2))
summary(d)

invisible(readline(prompt = "Press [enter] to continue"))  

cat(" 
Let us perform the same operation more consistently, generating random 
datasets with increasing dimensionality and checking how min, max, and
average distance change.

")

max_dim <- 100
N = 100000

v <- mapply(rand_dist_origin, rep(100000,max_dim-1), 2:max_dim)

df <- data.frame(
  dim = 2:max_dim, 
  aggregation = as.factor(c(rep("min", length(v["min",])), rep("max", length(v["max",])), rep("avg", length(v["avg",])))),
  v = c(v["min",], v["max",], v["avg",])
)

ggplot(df,aes(dim,v)) + 
  geom_point(aes(colour=aggregation), size=I(3), alpha=I(0.6)) + 
  geom_line(aes(colour=aggregation), size=I(.2), alpha=I(0.5)) +
  scale_x_discrete(breaks=1:10*10) + 
  labs(title="Statistics for Distances of Std Norm Distributed Points from 0", 
       x="dimension", 
       y="aggregate value of distances") + 
  scale_y_continuous(breaks=0:max(v)) + 
  theme(axis.text.x = element_text(colour="black"), 
        axis.text.y = element_text(colour="black"), 
        axis.title.x = element_text(vjust=-0.5, size=15), 
        axis.title.y = element_text(vjust=-0.2, size=15), 
        plot.margin = unit(c(1,1,1,1), "cm"), 
        plot.title = element_text(vjust=2, size=17)) + 
  annotate("text", x=0, y=Inf, label="(joyofdata.de)", vjust=1.5, hjust=-.1, size=4) 

cat("
Q4) What happens when dimensionality increases? Note that the difference 
between max and min roughly remains constant... But what happens to the
*relative difference* (i.e. (max-min)/min)? Try to plot it together with
the other data and explain the meaning of this result.

Q5) Finally, consider a classification problem (e.g. a set of 100 \"email\"
observations you need to classify as either \"spam\" or \"not spam\") and
explain how dimensionality might affect its results. Given the same amount
of observations, is it better to have more or less features? What happens
when you have many of them? How can you address potential problems due
to the curse of dimensionality?

")


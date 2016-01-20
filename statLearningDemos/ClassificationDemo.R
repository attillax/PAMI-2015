library(pracma)
library(MASS)
library(class)

rm(list=ls())

################################# MAIN CODE ###########################################
cat("
-------------------------------------------------------------------------------------
Welcome to the third PAMI demo/homework (year 2016): classification

In this demo we will learn to do classification (\"manually\" and using ready-made
R functions) on a very simple dataset. The purpose of the demo is both to show
you how to solve classification problems in R and to allow you to assess your
knowledge about this topic, using some questions which are similar to the ones
which are usually asked during the written exam. For this reason, the size of
the problem is very small, so you should be able to perform all your calculations 
on paper and then use the results you get in R to verify you did everything right.

Let us first generate the dataset.
")

invisible(readline(prompt = "Press [enter] to continue"))  


# prepare data
X1 = c(1,1,1.5,2,2,2,2,3,2.5,2.5,3,4,4,4,5,5)
X2 = c(1,3,2,1,2,3,4,2,2.5,5.5,3.5,2.5,3.5,4.5,3.5,4.5)
Y = c(1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2)
m = data.frame(cbind(X1,X2,Y))

plot(m[,1:2])
points(m[Y==2,1:2], col='red')

cat("
The total number of observations is 16, evenly divided in two classes (1=black and 2=red).
Observations are 2-dimensional, but to explain calculations step-by-step we will start taking
into account just the first dimension. Below here you can see the values of the variable X1
and the labels that have been assigned to the observations:

")
print(rbind(X1,Y))

invisible(readline(prompt = "Press [enter] to continue"))  

# split data to easiy access the different classes
# m1 are all the 2D points in class 1, m2 are the 2D points in class 2
m1 = m[m$Y==1,1:2]
m2 = m[m$Y==2,1:2]
n = dim(m)[1]
n1 = dim(m1)[1]
n2 = dim(m2)[1]

# p values are the priors (the probability that one element belongs to a given class k)
p = as.matrix(c(n1/n, n2/n))

# m1_ and m2_ represent our observations in 1D (using only the X1 values)
m1_ = m1[,1]
m2_ = m2[,1]

cat("
Let us now perform LDA on this 1-dimensional dataset. If you check out the lab material
on LDA (http://davide.eynard.it/teaching/2016_PAMI/Lab10.pdf) you will see that an 
observation x is classified with the class k that returns the highest *discriminant 
function* 

  delta_k(x) = x * mu_k/sigma^2 - mu_k^2/(2*sigma^2) + log(pi_k)

where:

  mu_k are the estimated means of the observations for each class k
  sigma^2 is the estimated variance of the class distributions (note that we assume
          the variance is the same for all classes - we can approximate a common
          variance from the data using pooled variance: see Lab10 notes)
  pi_k are the priors for each class k (n_k/n)

Q1) Calculate all the parameters you need for LDA classification (mu_k, sigmasq, and pi_k).
    Try to do that manually first, then write the R code to do that below here and verify
    that your results are consistent.

")

invisible(readline(prompt = "Press [enter] to continue"))  


# calculate means for m1_ and m2_ (COMPLETE THE CODE)
# mu1 = ...
# mu2 = ...

# calculate pooled variance (COMPLETE THE CODE)
#sigmasq = ...

# pi_k values have already been calculated as p[k] before

cat("
The previous formula for the discriminant function is linear in x (i.e. a_k * x + b_k).

Q2) Calculate now the a_k, b_k parameters that you will use within the discriminant 
    functions later.
    
")

invisible(readline(prompt = "Press [enter] to continue"))  

# COMPLETE THE CODE
# a1 = ...
# a2 = ...
# b1 = ...
# b2 = ...

# the label k assigned to an observation x is the one that corresponds to the
# biggest delta_k(x) 
cat("
Classification according to your LDA implementation returns the following labels:

")
lbls = max.col(cbind(a1 * m[,1] + b1, a2 * m[,1] + b2))
print(lbls)

cat("
... and here are both the table comparing labels and ground-truth and the classification accuracy:

")

print(table(lbls,Y))
print(mean(lbls == Y))

cat("
Q3) What is the result of your classification? Are there any wrong labels (and in this
    case could you explain why)? How much is the accuracy?

Q4) What is the value of the boundary between class 1 and 2? How do you calculate it?

")

invisible(readline(prompt = "Press [enter] to continue"))  

cat("
Let us now perform LDA on the full 2D dataset. As some calculations (e.g. matrix
inversion) are not trivial to do manually, feel free to use the help of R ;-)

")

# 2D case: get means (COMPLETE THE CODE)
# mu1 = ... # note that the code is different in 2D!
# mu2 = ...

# get covariances (COMPLETE THE CODE)
# s1 = ... # note that the code is different in 2D!
# s2 = ...

# calculate pooled covariance and its inverse (COMPLETE THE CODE)
# S = ...
Si = inv(S)

# calculate deltas
deltas = cbind(as.matrix(m[,1:2]) %*% Si %*% mu1 - as.double(1/2 * t(mu1) %*% Si %*% mu1 + log(p[1])),
               as.matrix(m[,1:2]) %*% Si %*% mu2 - as.double(1/2 * t(mu2) %*% Si %*% mu2 + log(p[2])))

cat("
Classification according to your LDA implementation returns the following labels:
    
")
lbls = max.col(deltas)
print(lbls)

cat("
... and here are both the table comparing labels and ground-truth and the classification accuracy:

")

print(table(lbls,Y))
print(mean(lbls == Y))

cat("
Now complete the source code of this script to run LDA using the builtin function 
provided in R and show your results are consistent with it.

Q5) What is the result of your classification? Are there any wrong labels (and in this
    case could you explain why)? How much is the accuracy?
    

")

invisible(readline(prompt = "Press [enter] to continue"))  

# complete and uncomment the code below to automatically run LDA 
lda.fit = lda(Y ~ X1 + X2, data=m)
#lda.pred = predict(...)
#lda.class = ...
#table(lda.class,Y)
#mean(lda.class == Y)


invisible(readline(prompt = "Press [enter] to continue"))  

cat("
Until now, we have just tried to understand how well our model fits the original data
(i.e. the training data). However, we did not conclude anything about how well it will
describe *new* data! Here are some new observations (shown as dots in the plot).

")

X1 = c(1.5,2,2.5,3,3,4,4,4.5)
X2 = c(3.5,5,3.5,1,4.5,1.5,5.5,3.5)
Y = c(1,1,1,1,2,2,2,2)
m.test = data.frame(cbind(X1,X2,Y))

plot(m[,1:2])
points(m[m[,3]==2,1:2], col='red')
points(m.test[,1:2],pch=20)
points(m.test[m.test[,3]==2,1:2], pch=20, col='red')


cat("
Q6) Run the lda predictor you trained using the previous observations to classify 
    the new set of observations and comment the result. Is it expected? Are there
    any misclassifications and if so which ones and for what reason? Can you draw 
    a (rough) classification boundary from the results you got? Can you actually 
    calculate it, similarly to what you did in the 1D case?

    NOTE: to classify the new test set, you can use the lda.fit variable you obtained 
          during training
")

# complete the following code:
# lda.pred = predict(...)
lda.pred = predict(lda.fit, newdata = m.test[,1:2])
lda.class = lda.pred$class
print(table(lda.class, m.test[,3]))
print(mean(lda.class == m.test[,3]))


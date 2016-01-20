# if any of the following libraries cannot be loaded, install it first using the
# install.packages() command
library(leaps)
rm(list=ls())

################################# MAIN CODE ###########################################
cat("
-------------------------------------------------------------------------------------
Welcome to the first PAMI demo/homework (year 2016): linear regression

Today we will work on the 'x20' dataset about population and drinking data.
The dataset has been downloaded from John Burkardt website:
http://people.sc.fsu.edu/~jburkardt/datasets/regression/regression.html
and contains data about the population of different states, their drinking
habits, and their death rate from cirrhosis.

You can find more info here:
http://people.sc.fsu.edu/~jburkardt/datasets/regression/x20.txt

Let us now load the dataset and inspect its contents...")

invisible(readline(prompt = "Press [enter] to continue"))  

# load the dataset
data = read.table("cirrhosis.data",header = TRUE)
attach(data)

cat("\nThe meaning of the variables is the following:

urbanpop: urban population (percentage)
latebirths: late births (reciprocal * 100)
wine: wine consumption per capita
liquor: liquor consumption per capita
deathrate: cirrhosis death rate

We will now try to fit different linear regression models and estimate
the \"deathrate\" response variable from the data.\n")

invisible(readline(prompt = "Press [enter] to continue"))  


cat("First of all, let us give a glance at the dataset as a whole: below
you can see the correlations between all pairs of variables, while
the picture contains the plots of these pairs.\n\n")

pairs(data)
cor(data)

cat("\nQ1: what can you deduce from the plots and the correlations?\n\n")
invisible(readline(prompt = "Press [enter] to continue"))  


cat("\nNow let us look at the results of simple linear regression, trying to
describe deathrate as a function of urbanpop:\n")

fit = lm(deathrate ~ urbanpop)
summary(fit)
Yhat = fitted(fit)

plot(urbanpop,deathrate)
abline(fit, col="green")
segments(urbanpop,Yhat,urbanpop,deathrate,col="blue")

cat("Q2: what can you deduce from this result? How statistically significant is it?
Is this enough to say that there is a causation relationship between the two variables
(i.e. that living in the city increases the probability of dying from cirrhosis)?\n\n")

invisible(readline(prompt = "Press [enter] to continue"))  

cat("\nQ3: Now, try to do the same for all the other variables: complete the source code 
of this demo to include simple linear regressions for latebirths, wine, and liquor,
and comment the results.\n\n")

# you can put your simple linear regression code here

invisible(readline(prompt = "Press [enter] to continue"))  

cat("\nLet us now look at the results we get from multiple linear regression. Include the
code to perform multiple linear regression using all of the variables, and comment about
the results you get.")

# you can put your multiple linear regression code here

cat("\nQ4: do all the variables still look relevant for describing deathrate? If not, which ones
are the best? Try guessing first, then use the \"regsubsets\" command to actually find
which are the best ones if you only could choose two of them.\n\n")

invisible(readline(prompt = "Press [enter] to continue"))  


cat("\nFinally, let us see if there are any interactions amongst these two variables.
Q5: Try first a linear regression (fit1) using them, then another one (fit2) 
adding the interaction, finally compare the two fits and comment on the results.")

# complete the following code below and compare your results
#fit1 = lm(deathrate ~ var1 + var2)
#fit2 = lm(deathrate ~ var1 + var2 + ...)
#summary(fit1)
#summary(fit2)
#anova(fit1, fit2)

detach(data)



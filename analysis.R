# Load the "fatalities" dataset from the "AER" package.
install.packages("AER")
library(AER)
data(Fatalities)

# Exploring the structure and contents of the dataset to understand its variables.
str(Fatalities)
head(Fatalities)
summary(Fatalities)

colSums(is.na(Fatalities))
# There is no missing values in the beertax being the important explanatory varaible to explore the relationship with fatalities. so there is no need to treat one missing values for jail and service.
sum(is.na(Fatalities$beertax))
sum(is.na(Fatalities$fatal_rate))

Fatalities$fatalrate <- Fatalities$fatal / Fatalities$pop * 10000
y <- Fatalities$fatalrate

# Independent variables (including constant term)
X <- cbind(1, Fatalities$beertax)
# Creating the design matrix X, including a column of ones for the constant term.

# Individual effects (random effects) 
state <- Fatalities$state
num_state <- length(unique(state)) #calculates the number of unique entities in the fatalities
alpha <- rep(0, num_state)  #initializes the vector alpha with zeros for each state.
alpha

# Time effects
year <- Fatalities$year
num_year <- length(unique(year))
gamma <- rep(0, num_year)
gamma

# Error term
epsilon <- rep(0, length(y)) #initializes the error term epsilon with zeros for each observation of the dependent variable.

#Converting variables into categorical
Fatalities$year <- factor(Fatalities$year)
Fatalities$state <- factor(Fatalities$state)
fatalities_bar <- with(Fatalities, data.frame(fatalrate_bar = ave(fatalrate,state),
                                              beertax_bar = ave(beertax, state)))
#To perform random effect we need to calculate the value of lambda to check if it lies between 1-2 if
#if lambda is 1 it we can do fixed effects model if zero just OLS
#To calculate lambda we need to first calculate sigma uhat and sigma ahat

#First calculating sigma uhat which we can obtain using the fixed effects model
#Demean to get sigma u hat

#To find sigma u_hat
demeaned_fatalrate <- Fatalities$fatalrate - fatalities_bar$fatalrate_bar
demeaned_beertax <- Fatalities$beertax - fatalities_bar$beertax_bar
B1 = sum((demeaned_beertax-mean(demeaned_beertax))*(demeaned_fatalrate-mean(demeaned_fatalrate)))/sum((demeaned_beertax-mean(demeaned_beertax))^2)
u_hat = demeaned_fatalrate - (B1*demeaned_beertax)
SSE = sum(u_hat^2)
error_variance = SSE/(336-48-1) # for consistent estimates we will use hill-griffith formula

#now to find sigma alpha_hat
Z1 = sum((fatalities_bar$beertax_bar-mean(fatalities_bar$beertax_bar))*(fatalities_bar$fatalrate_bar-mean(fatalities_bar$fatalrate_bar)))/sum((fatalities_bar$beertax_bar-mean(fatalities_bar$beertax_bar))^2)

Z0 = mean(fatalities_bar$fatalrate_bar)- Z1*mean(fatalities_bar$beertax_bar)

vhat = unique(fatalities_bar$fatalrate_bar - Z0 - Z1*fatalities_bar$beertax_bar)
sigma_vhat = sum(vhat^2)/46
sigma_alpha = sigma_vhat - error_variance/7

#now calculating lambda for GLS

lambda = 1 - ((error_variance)^0.5/(error_variance+7*sigma_alpha)^0.5)
#applying transformation for calculation
fatalrate_star= Fatalities$fatalrate - lambda*fatalities_bar$fatalrate_bar
beertax_star = Fatalities$beertax - lambda*fatalities_bar$beertax_bar
Beta1 = sum((beertax_star-mean(beertax_star))
                 *(fatalrate_star-mean(fatalrate_star)))/sum((beertax_star-mean(beertax_star))^2)
#Beta1 = -0.52016 

Beta_not = (mean(fatalrate_star)- Beta1*(mean(beertax_star)))/(1-lambda)
I_not = Beta_not*(1-lambda)
Ut_star = fatalrate_star - I_not - Beta1*(beertax_star)
sigmasq_hat_Beta1 = sum(Ut_star^2)/(336-2)

se_hat = ((sigmasq_hat_Beta1)^0.5)/(sum((beertax_star-mean(beertax_star))^2))^0.5
#standard error_hat= sigmasq_hat/ SSTx

z = Beta1/se_hat
pstat= 2*pnorm(-abs(z))
#pstat>0.05, hence the coefficient does not appear to be significant.

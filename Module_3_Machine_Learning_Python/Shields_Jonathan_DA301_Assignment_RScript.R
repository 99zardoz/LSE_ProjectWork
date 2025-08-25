################################################################
# This file forms the R portion of the assignment for module 3 #
# Jonathan Shields                                             #
################################################################

#Import the tidyverse and moments libraries
library(tidyverse)
library(moments)

#Function to print some descriptive stats for a numeric variable x 
#with name x_name
print_descriptive_stats<-function(x, x_name){
  
  #Measures of central tendency
  mean_x=mean(x)
  median_x=median(x)
  
  #Measures of spread
  q1=quantile(x,0.25)
  q3=spending_score=quantile(x,0.75)
  IQR=q3-q1
  
  min_x=min(x)
  max_x=max(x)
  range_x=max_x-min_x
  
  sd_x=sd(x)
  
  #Measures of data shape
  
  skew_x=skewness(x)
  kurt_x=kurtosis(x)
  
  #Print the stats
  
  cat(sprintf("*******Measures of central tendency for %s ",x_name),"\n",
  sprintf("Mean: %f \n", mean_x),"\n",
  sprintf("Median: %f \n", median_x),"\n",
  sprintf("*******Measures of spread for %s \n",x_name),"\n",
  sprintf("Minimum: %f \n",min_x),"\n",
  sprintf("Maximum: %f \n", max_x),"\n",
  sprintf("Range: %f \n",range_x),"\n",
  sprintf("1st quartile: %f \n ",q1),"\n",
  sprintf("3rd quartile: %f \n", q3),"\n",
  sprintf("IQR: %f \n", IQR),"\n",
  sprintf("Standard deviation: %f",sd_x), "\n",
  sprintf("******Measures of shape for %s \n",x_name),"\n",
  sprintf("Skewness: %f \n",skew_x),"\n",
  sprintf("Kurtosis: %f \n", kurt_x),"\n")
}

#Import Turtle Games data cleaned during Python analysis earlier into data frame
reviews=read.csv("reviews_clean.csv",header=TRUE)

#View data in grid
View(reviews)

#View the first 5 rows and a column summary
head(reviews)
summary(reviews)

#We already know from our earlier analysis that the base file contains
#multiple reviews per customer
#As before we will create a "customers only" dataset to work with customer data

#Group by all customer columns, adding a count and keeping the grouping
customers=reviews %>% group_by(gender,age,remuneration,spending_score,loyalty_points,education) %>% 
                  summarize(count=n(),.groups = "drop")
                                
head(customers)

#We don't need the count it was just there so we could summarize and take the grouping values
customers=select(customers,c(gender,age,remuneration,spending_score,loyalty_points,education))

head(customers)
#Check we have 782 rows as with our customers only dataset in Python
dim(customers)

########################################################################
# Assignment objective 5: exploratory data analysis and visualisations #
########################################################################

#We will now perform some exploration of each variable and create some supporting visuals

#Gender - produce a count for each gender
gender_counts<-customers %>% group_by(gender) %>%
              summarize(count=n())

gender_counts
#Note: females 56% males 44% approx - in any gender-based analysis note the imbalance

#Use grouped data to produce bar plot
ggplot(gender_counts,aes(x=gender,y=count,fill=gender)) +
  geom_bar(stat = "identity") +
  labs(x="Gender",y="Frequency",title="Frequency of customers by gender",fill="Gender") +
  geom_text(aes(label = count), vjust = -0.5) +
  theme_classic()


#Produce age histogram with 5 year bins
meanAge<-mean(customers$age)

ggplot(customers,aes(x=age)) +
  geom_histogram(fill='blue',binwidth=5) +
  geom_vline(xintercept=c(meanAge), color='black') + #Add line for mean
  labs(x="Age",y="Frequency",title="Histogram of customer age",
       subtitle="Distribution is left-skewed with mean just under 40")

menOnly=filter(customers,gender=='Male')
meanAgeMen<-mean(menOnly$age)

womenOnly=filter(customers,gender=='Female')
meanAgeWomen<-mean(womenOnly$age)

#Plot age for both genders as a density plot
ggplot(customers,aes(x=age,fill=gender)) +
  geom_density(alpha=0.5) +
  geom_vline(xintercept=c(meanAgeMen), color='blue') + #Add line for mean(males)
  geom_vline(xintercept=c(meanAgeWomen), color='pink') + #Add line for mean(males)
  labs(x="Age",y="Density",title="Density plot of age by gender",fill="Gender",
       subtitle="Distribution skewed right for both genders: mean line shows female mean age slightly lower")

#Insight: mean age for genders similar but greater spread in ages for male customers, and male customers tend 
#to be slightly older

meanRemunMen=mean(menOnly$remuneration)
meanRemunWomen=mean(womenOnly$remuneration)

#Plot remuneration for both genders as density plot
ggplot(customers,aes(x=remuneration,fill=gender)) +
  geom_density(alpha=0.5) +
  geom_vline(xintercept=c(meanRemunMen), color='blue') + 
  geom_vline(xintercept=c(meanRemunWomen), color='pink') +
  labs(x="Remuneration £k",y="Density",title="Density plot of remuneration by gender",fill="Gender",
       subtitle="Distributions similar (right-skewed) but with more lower paid and higher paid women: mean remunerations similar") +
  theme_classic()

#Explore similar with violin/box plot
ggplot(customers,aes(x=gender,y=remuneration,fill=gender)) +
  geom_violin(alpha=1) +
  geom_boxplot(alpha=0.5) +
  labs(x="Gender",y="Remuneration £k",title="Box/Violin plot of remuneration by gender",fill="Gender",
       subtitle="Distributions similar but with slightly more lower paid and higher paid women") +
  scale_y_continuous(breaks=seq(0,120,10),expand = c(0, 0),limits=c(0,120)) + # Force y axis to start at 0
  theme_classic()

#Insight: distribution of remuneration by gender similar but more lower/higher paid women than men

#Explore spending score by gender with boxplot
ggplot(customers,aes(x=gender,y=spending_score,fill=gender)) +
  geom_boxplot(alpha=0.5) +
  labs(x="Gender",y="Spending score (0-100)",title="Boxplot of spending score by gender",fill="Gender",
       subtitle="Distributions very similar between genders, quite symmetrically distributed") +
  theme_classic()
  
#Explore loyalty points by gender with boxplot
ggplot(customers,aes(x=gender,y=loyalty_points,fill=gender)) +
    geom_boxplot(alpha=0.5) +
    labs(x="Gender",y="Loyalty points accumulated",title="Boxplot of loyalty points by gender",fill="Gender",
         subtitle="Distributions very similar between genders: both have high outliers") +
  theme_classic()
  
#Explore loyalty points by gender and education

#Set education order to use in visual
positions <- c("Basic", "diploma", "graduate","postgraduate","PhD")
  
ggplot(customers,aes(x=education,y=loyalty_points,fill=gender)) +
  geom_boxplot(alpha=0.5) +
  labs(x="Education/Gender",y="Loyalty points accumulated",title="Boxplot of loyalty points by education level",fill="Gender",
       subtitle="Among customers with a high school diploma females tend to accumulate more and males 
less loyalty points, no other insights") +
  scale_x_discrete(labels = c(
                            "Basic" = "Basic", 
                            "diploma" = "Diploma", 
                            "graduate" = "Graduate",
                            "PhD"="PhD",
                            "postgraduate"="Postgraduate"),
                   limits=positions) + #Force the order we want
  theme_classic()

#Scatterplot of loyalty points and age and regression line
ggplot(customers,aes(x=age,y=loyalty_points)) +
  geom_point(color='blue') +
  geom_smooth(method='lm') +
  labs(x="Age",y="Loyalty points",title="Scatterplot of loyalty points and age",
       subtitle="Shows a very weak correlation. Shaded area shows 95% conf. int") +
  theme_classic()

#Scatterplot of loyalty points and spending score with regression line, add label to show "split" in actuals
ggplot(customers,aes(x=spending_score,y=loyalty_points)) +
  geom_point(color='blue') +
  geom_smooth(method='lm') +
  labs(x="Spending score (0-100)",y="Loyalty points",
       title="Linear regression using spending score to predict loyalty points",
       subtitle='Appears to show a reasonable correlation at low values and then "split" for high values.  Shaded area shows 95% conf. int') +
  geom_label(x=90,y=2200,label='"Split" for high values') +
  theme_classic()

#Scatterplot of loyalty points and remuneration with regression line, add label to show "split" in actuals
ggplot(customers,aes(x=remuneration,y=loyalty_points)) +
  geom_point(color='blue') +
  geom_smooth(method='lm') +
  labs(x="Remuneration £k",y="Loyalty points",title="Linear regression using remuneration to predict loyalty points",
       subtitle='Shows a reasonable correlation at low values and then "split" for high values. Shaded area shows 95% conf. int') +
  geom_label(x=95,y=2350,label='"Split" for high values') +
  theme_classic()

#Analysis of sales per product
#Using the reviews dataset, we can group by product and produce a count

salesPerProduct=reviews %>% group_by(product) %>% 
  summarize(count=n(),.groups = "drop")

top20Products=salesPerProduct[order(-salesPerProduct$count),][1:20,]

top20Products

#Produce bar chart of sales by product for top 20 selling products
#Specify factor levels so bars ordered largest->smallest

ggplot(top20Products,aes(x=factor(product,levels=product),
                         y=count,fill=factor(product,levels=product))) +
  geom_bar(stat='identity') +
  geom_text(aes(label=count), vjust=-1) + # Add count above bar
  geom_text(aes(label=factor(product)), vjust=20) + #Add product label inside bar
  labs(title="Sales of top 20 best selling product ids",
       x="",
       y="Sales",
       subtitle="Product ids shown inside bars",
       fill="Product Id") +
  scale_x_discrete(labels = "",breaks="") +
  theme_classic() +
  theme(legend.position="none") # Remove unwanted legend


#############################################################################################
# Assignment objective 6:multiple linear regression analysis of loyalty points accumulation #
#############################################################################################

#Analysis with Python has already shown that the most promising linear relationship is between
#log(loyalty points) as the dependent variable and log(spending score) and log(remuneration) as the
#independent variables

#We will therefore use R to provide the client with evidence of this as they have indicated that R
#is their preferred internal analysis tool

# Import the psych package for multivariate analysis
library(psych)

#Produce a correlation grid, excluding the gender and education categorical
#columns
customer_numerics<-select(customers,-c('gender','education'))

#Check
head(customer_numerics)

corPlot(customer_numerics,cex=2)

#The grid shows the strongest potential linear correlations
#for loyalty points are spending score and remuneration
#It makes sense to select these as our features.
#We will generate some descriptive statistics so the client can have some
#insights generated using R

#Spending score
print_descriptive_stats(customer_numerics$spending_score,"spending score")

#Headlines: mean 49.6, median 50
#max 1, min 99, range 98, Q1 29, Q3 73, IQR 44
#Standard deviation 26.59
#Data is slightly right-skewed and has lighter tails

#Is spending score normally distributed?

qqnorm(customer_numerics$spending_score)
qqline(customer_numerics$spending_score,col='red')

#It seems to deviate from normal distribution in the q-q plot
#Perform a shapiro wilk test

shapiro.test(customer_numerics$spending_score)

#Null hypothesis: residuals are normally distributed
#Alternative hypothesis: residuals are not normally distributed

#The low p-value of 1.22e-12 means we can reject the null hypothesis
#and say that the spending score is not normally distributed

#Perform a similar analysis for remuneration
print_descriptive_stats(customer_numerics$remuneration,"remuneration")

#Headlines: mean 46.05, median 44.28
#min 12, max 112.34, range 100.04, q1 23.16, q3 63.96, IQR 40.8
#Standard deviation 25.24
#The data is somewhat right-skewed and has moderately light tails

###Linear regression analysis using spending score and 
###remuneration to predict loyalty points

#Build a simple linear model for spending score 
modelA=lm(loyalty_points~spending_score,data=customer_numerics)

#Show the summary
summary(modelA)

#The R squared of around 40% does not indicate a particularly good fit for
#spending score alone
#Investigate remuneration alone

#Build a simple linear model for remuneration
modelB=lm(loyalty_points~remuneration,data=customer_numerics)

#Show the summary
summary(modelB)

#Again the R squared of 40% does not indicate that the variation of loyalty
#points is well explained by this model
#Lets look at an MLR model using both as independent variables

modelC=lm(loyalty_points~spending_score + remuneration,data=customer_numerics)

#Show the summary
summary(modelC)

#The R squared now indicates a reasonably good fit at just under 80%
# Lets examine the residuals to look for heteroscedasticty

customers_with_residuals=mutate(customers,
                                residual=residuals(modelC))

ggplot(customers_with_residuals,aes(x=loyalty_points,y=residual)) +
  geom_point()

#As with the Python model, the residuals show a definite pattern

#We will therefore test the log-log model in R to be confident this remains
#a good fit with no heteroscedasticity in R

customers=mutate(customers,
                 log_loyalty=log(loyalty_points),
                 log_spending=log(spending_score),
                 log_remuneration=log(remuneration))

modelD=lm(log_loyalty~log_spending+log_remuneration,data=customers)

summary(modelD)

#We have an R squared of 98% so we can feel that this model explains the 
#variation in loyalty points very well
#The p-values associated with the intercepts and co-efficients are all well
#below 0.05, so we can feel confident that these values are very unlikely
#to be achieved if there were no linear log-log relationship

#Co-efficient values: Intercept -0.465529 log_spending 0.990015
#                     log_remuneration 1.018606

#Add the residuals from the model so we can plot them
customers_with_residuals=mutate(customers,
                                residual=residuals(modelD))


#Import plotly to produce a more visually appealing charts later
library(plotly)

#Plot the residuals
resid_plot=ggplot(customers_with_residuals,aes(x=loyalty_points,y=residual)) +
  geom_point(col='red') +
  labs(title="Distribution of residuals in log-log model by loyalty points: no heteroscedasticity",
       x="Loyalty points",
       y="Residual") +
  theme_classic()

ggplotly(resid_plot)

#Are the residuals normally distributed?

qqnorm(residuals(modelD))
qqline(residuals(modelD),col='red')

#The Q-Q plot suggests some deviation from a normal distribution

#Perform a shapiro-wilk test as an alternative test
shapiro.test(residuals(modelD))

#Null hypothesis: residuals are normally distributed
#Alternative hypothesis: residuals are not normally distributed
#The p-value of well under 0.05 means that we reject the null hypothesis
#and we can assume non-normal residuals as we did under the Python analysis

#This is not a major issue for our model unless it is used for
#formal hypothesis testing

#In answer to the questions put by Turtle Games:
#
# - Can we predict the accumulation of loyalty points given the existing features 
#   using a relatively simple MLR model?
#   The log-log model is reasonably simple and could even be applied in Excel.
#   It provides an accurate prediction of loyalty points
# - Do you have confidence in the model results (goodness of fit evaluation)?
#   The R squared of 98% and p-values<0.05 for the coefficients and intercept
#   enable us to have confidence in the model predictions
# - Where should the business focus its marketing efforts?
#   The cluster analysis performed using k-means in Python gives buyer personas,
#   which can each be targeted with a different strategy to drive higher
#   sales to each group.  This is described in the technical report and 
#   presentation in more detail.
# - How could the loyalty programme be improved?
#   There is clearly scope to use the loyalty data to drive programmes
#   aimed at retain high loyalty customers.  Targeting the top 10% of loyalty
#   point accumulators with a "discount day" for example could promote higher
#   spend and help retain these important customers.
#   This is covered in more detail in the presentation and report.


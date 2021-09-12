######################################################
# Bike Sharing Assignment                            #
######################################################

#removes all list values
rm(list=ls())

#set working directory  (CHANGE TO YOUR WD)
setwd("~/Spring 2021/Supply Chain Analytics/Bike sharing assignment")

#Read the csv
bike_train<-read.csv("bike sharing training for students.csv")
bike_test<-read.csv("bike sharing test for students.csv")

#print the header values
head(bike_train)

#print the structure of dataframe
str(bike_train)

#On analysing the structure of the dataframe we see that there is a date time field
#which cannot be used directly in the model so we convert them into a date field and
#segregate them further in the upcoming steps

#let us convert the datetime field into date type field 
bike_train$date<-as.Date(bike_train$datetime, format="%m/%d/%Y")
bike_test$date<-as.Date(bike_test$datetime, format="%m/%d/%Y")

# let us extract the first date that is 1st of january
daterep_tr<-rep(bike_train$date[1],nrow(bike_train))
daterep_test<-rep(bike_test$date[1],nrow(bike_test))

#we will use the date extracted in the previous step to calculate number of days
bike_train$daynum<-as.numeric(bike_train$date-daterep_tr+1)
bike_test$daynum<-as.numeric(bike_test$date-daterep_test+1)

# we can use the above created column to see if it improves our model or not

# POSIXIt seperates the date field into hours,days and month
date_time_list_tr <-   as.POSIXlt(bike_train$datetime, format = "%m/%d/%Y %H:%M")
date_time_list_test <- as.POSIXlt(bike_test$datetime, format = "%m/%d/%Y %H:%M")

bike_train$hour<-date_time_list_tr$hour #seperates a day into hours
bike_test$hour<-date_time_list_test$hour #seperates a day into hours

bike_train$dayofweek<-date_time_list_tr$wday#tells which day of the week it is 0->Sunday,6>-Saturday etc.
bike_test$dayofweek<-date_time_list_test$wday#tells which day of the week it is 0->Sunday,6>-Saturday etc.

bike_train$month<-date_time_list_tr$mon #tells us the month of the date
bike_test$month<-date_time_list_test$mon #tells us the month of the date

bike_train$hourcat<-as.factor(bike_train$hour) #convert the hour into category type field
bike_test$hourcat<-as.factor(bike_test$hour) #convert the hour into category type field

bike_train$dayofweekcat<-as.factor(bike_train$dayofweek) #convert the week into category type
bike_test$dayofweekcat<-as.factor(bike_test$dayofweek) #convert the week into category type

bike_train$monthcat<-as.factor(bike_train$month)  #convert the month into category type field
bike_test$monthcat<-as.factor(bike_test$month)  #convert the month into category type field

bike_train$workingdaycat<-as.factor(bike_train$workingday) #convert the hour into category type field
bike_test$workingdaycat<-as.factor(bike_test$workingday)

bike_train$holidaycat<-as.factor(bike_train$holiday) #convert the hour into category type field
bike_test$holidaycat<-as.factor(bike_test$holiday)


#Let us further create categorical variables
bike_train$seasoncat<-as.factor(bike_train$season)
bike_test$seasoncat<-as.factor(bike_test$season)

bike_train$weathercat<-as.factor(bike_train$weather)
bike_test$weathercat<-as.factor(bike_test$weather)
str(bike_train)#check the structure of our new data frame now


########################################################################################################################################33
#correlation plot

library(corrplot)

bike_train2 <- bike_train[,c(12,10,11,1,2,3,4,5,6,7,8,9,13,14,15,16,17,18,19,20,21,22)]

bike_train2 <- bike_train2[, sapply(bike_train2, is.numeric)]

corrplot(cor(bike_train2), method='color')

##########################################################################################################################################3
#Model
#summary(MODEL)
bike_train$log_temp<-log(bike_train$temp)
bike_test$log_temp<-log(bike_test$temp)
bike_train$log_humidity<-log(bike_train$humidity)
bike_test$log_humidity<-log(bike_test$humidity)

casual_fit <- lm(casual ~ temp * humidity * hour * daynum * windspeed * workingday * hourcat + dayofweekcat + monthcat + weathercat, data = bike_train)
summary(casual_fit)

registered_fit <- lm(registered ~ windspeed*atemp + workingdaycat*monthcat + hourcat*daynum + hourcat + workingdaycat*atemp*hourcat*daynum + atemp + humidity + daynum + workingdaycat + monthcat + holidaycat + weathercat + holidaycat*atemp + hourcat*monthcat + weathercat*workingdaycat*hourcat, data = bike_train)
summary(registered_fit)

reg_test_out <- predict(registered_fit, bike_test)
cas_test_out <- predict(casual_fit, bike_test)
total_test_out <- reg_test_out + cas_test_out

reg_train_out <- predict(registered_fit, bike_train)
cas_train_out <- predict(casual_fit, bike_train)
total_train_out <- reg_train_out + cas_train_out
RMSE_out<-sqrt(mean((bike_train$count-total_train_out)^2))
RMSE_out

########## Submission ###########

#Create a blank submission using the test set
submission <- data.frame(matrix(nrow=nrow(bike_test), ncol=0)) 

#Make the first row the datetime
submission$datetime <- bike_test$datetime

#Using the model, populate the second column based on the models prediction of the total usage count
submission$count <- total_test_out

#if the model predicts a negative value we replace it with 0 because the total count cannot be negative
submission$count <- ifelse(submission$count < 0, 0, submission$count)

#Write this to a CSV
write.csv(submission,"Final_submission.csv", row.names = FALSE)
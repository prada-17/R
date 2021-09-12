##################################################################################################################

#Course: OTM 714(Supply Chain Analytics)
#Time Series Forecasting Assignmemnt
#Submitted By: Prabhav Pandey

##################################################################################################################


rm(list=ls())  #removes all the list values                                                                      #
install.packages("forecast")                                                                                     #
library(forecast) #package to forecast values                                                                    #
library(readxl) #package to read XL files                                                                        #

##################################################################################################################

#First,let us read the data into a dataframe and look at it
xl_data<-"C:\\Users\\Admin\\Desktop\\Class10_TimeSeries\\TimeSeriesForecasting_Assignment\\ShureData_test.xlsx"
excel_sheets(path=xl_data) #give the path of the excel file

# We will now read excel file specifying the sheet names and the path of excel file
cust_orders <- read_excel(path = xl_data, sheet = "CustOrders") 
forecast_data<-read_excel(path = xl_data, sheet = "ShureForecasts")
#Convert the data into a dataframe format
df_cust_orders<-as.data.frame(cust_orders)
df_shure_forecasts<-as.data.frame(forecast_data)

########################################################################################
                                                                                       #
# Modelling For Product "FLX012                                                        #
                                                                                       #
########################################################################################

#First, let us convert the data for product "FLX102" into a time series object
cust_flx012_ts<-ts(df_cust_orders$FLX012, start=c(2006,1),frequency=12)
# Now we want to train the model till May 2014 and test the model from June 2014
cust_flx012_in <- window(cust_flx012_ts,end=c(2014,5))
cust_flx012_out <- window(cust_flx012_ts,start=c(2014,6))

# Let's take a look at the decomposed data set to see if we observe trend or seasonality
fit_flx012<-stl(cust_flx012_in, s.window="periodic")
#plot the data and look for seasonality and trend
plot(fit_flx012)
#Now let us see the results on varous models
#########################################################################################

#ANN Model for FLX012
modann_flx012 <- ets(cust_flx012_in, model="ANN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx012_ann_in<-fitted(modann_flx012,h=3)
accuracy(fore_flx012_ann_in,cust_flx012_in)  #31.68911

######################################################################################

#AAN Model for FLX012
modaan_flx012 <- ets(cust_flx012_in, model="AAN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx012_aan_in<-fitted(modaan_flx012,h=3)
accuracy(fore_flx012_aan_in,cust_flx012_in)    #32.84955

######################################################################################

#ANA model for product "FLX012"
modana_flx012 <- ets(cust_flx012_in, model="ANA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse", nmse=5)
fore_flx012_ana_in<-fitted(modana_flx012,h=3)
accuracy(fore_flx012_ana_in,cust_flx012_in)  #31.09324

######################################################################################

#AAA Model
modaaa_flx012 <- ets(cust_flx012_in, model="AAA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse", nmse=5)
fore_flx012_aaa_in<-fitted(modaaa_flx012,h=3)
accuracy(fore_flx012_aaa_in,cust_flx012_in)  #32.7723

#######################################################################################

#As we see the RMSE is lowest for ANA model we will choose it
#check the accuracy on test data
modana_flx012_refit <- ets(cust_flx012_ts, model=modana_flx012, use.initial.values=TRUE)
#now let us check the forcasts for 3 month time period
myfore_flx012_ana_3 <- fitted(modana_flx012_refit,h=3)
#now let us check the accuracy of our forecast on test data
accuracy(myfore_flx012_ana_3,cust_flx012_out)  #35.53165

#######################################################################################

##Let us see the accuracy of shure forecast model
#now let us convert the data into a time series object
shure_flx012_forecasts_ts<-ts(df_shure_forecasts$FLX012, start=c(2014,6),frequency=12)
#Now let us check the accuracy of the shure forecasting data
accuracy(shure_flx012_forecasts_ts,cust_flx012_out)  #34.48956

#######################################################################################
#2a
# If we want to forecast into the future, and also generate
# prediction intervals, we can use the forecast() function
# The number following "modana_flx012_refit" is the number of periods

# We can plot the forecasts on our graph
plot(forecast(modana_flx012_refit,3), type="b")
lines(modana_flx012_refit$fitted, col=4, type="b")

# Can check RMSE for different forecast horizons as follows
myforeana_flx012_1 <- fitted(modana_flx012_refit,h=1)
myforeana_flx012_3 <- fitted(modana_flx012_refit,h=3)
myforeana_flx012_5 <- fitted(modana_flx012_refit,h=5)

# To check the accuracy of our forecasts on the test data, we can use the accuracy function
accuracy(myforeana_flx012_1,cust_flx012_out)  #35.28009
accuracy(myforeana_flx012_3,cust_flx012_out)  #35.53165
accuracy(myforeana_flx012_5,cust_flx012_out)  #34.82094


################################################################################
                                                                               #
# Modelling for product FLX019                                                 #
                                                                               #
################################################################################

#First let us convert the data into a time series object starting from January 2006
cust_flx019_ts<-ts(df_cust_orders$FLX019, start=c(2006,1),frequency=12)
# # Now we want to train the model till May 2014 and test the model from June 2014
cust_flx019_in <- window(cust_flx019_ts,end=c(2014,5))
cust_flx019_out <- window(cust_flx019_ts,start=c(2014,6))
# Let's take a look at the decomposed data set to see if we observe trend or seasonality
fit_flx019<-stl(cust_flx019_in, s.window="periodic")
plot(fit_flx019)

######################################################################################

#Train the ANN Model for FLX019
modann_flx019 <- ets(cust_flx019_in, model="ANN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx019_ann_in<-fitted(modann_flx019,h=3)
accuracy(fore_flx019_ann_in,cust_flx019_in) #112.1846

#######################################################################################

#Train AAN Model for FLX019
modaan_flx019 <- ets(cust_flx019_in, model="AAN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx019_aan_in<-fitted(modaan_flx019,h=3)
#fore_flx019_aan_in
accuracy(fore_flx019_aan_in,cust_flx019_in)  #116.5204

######################################################################################

#Train ANA Model for FLX019
#ANA Model
modana_flx019 <- ets(cust_flx019_in, model="ANA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx019_ana_in<-fitted(modana_flx019,h=3)
accuracy(fore_flx019_ana_in,cust_flx019_in)   #106.5702

###################################################################################

#AAA Model
modaaa_flx019 <- ets(cust_flx019_in, model="AAA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx019_aaa_in<-fitted(modaaa_flx019,h=3)
#fore_flx019_aaa_in
accuracy(fore_flx019_aaa_in,cust_flx019_in)  #110.3321

##################################################################################

#We see that ANA model has the lowest RMSE's among all the models for product FLX019
#check the accuracy on test data
modana_flx019_refit <- ets(cust_flx019_ts, model=modana_flx019, use.initial.values=TRUE)
#now let us check the forcasts for 3 month time period
myfore_flx019_ana_3 <- fitted(modana_flx019_refit,h=3)
#now let us check the acuracy of our forecast on test data
accuracy(myfore_flx019_ana_3,cust_flx019_out)  #87.50491

###################################################################################

#Now let us see the performance of Shure forecast
#now let us convert the data into a time series object
shure_flx019_forecasts_ts<-ts(df_shure_forecasts$FLX019, start=c(2014,6),frequency=12)
#Now let us check the accuracy of the shure forecasting data
accuracy(shure_flx019_forecasts_ts,cust_flx019_out)  #76.10828

####################################################################################

#2a
#Forecast for product FLX019
# If we want to forecast into the future, and also generate
# prediction intervals, we can use the forecast() function
# The number following "modana_flx019_refit" is the number of periods
forecast(modana_flx019_refit, 3)

# We can plot the forecasts on our graph
plot(forecast(modana_flx019_refit,3), type="b")
lines(modana_flx019_refit$fitted, col=4, type="b")

# Can check RMSE for different forecast horizons as follows
#fitting the data for different time periods
myforeana_flx019_1 <- fitted(modana_flx019_refit,h=1)
myforeana_flx019_3 <- fitted(modana_flx019_refit,h=3)
myforeana_flx019_5 <- fitted(modana_flx019_refit,h=5)

# To check the accuracy of our forecasts on the test data, we can use the accuracy function
accuracy(myforeana_flx019_1,cust_flx019_out)  #86.45837
accuracy(myforeana_flx019_3,cust_flx019_out)  #87.50491
accuracy(myforeana_flx019_5,cust_flx019_out)  #87.19887

######################################################################################
                                                                                     #
# Modelling For Product "FLX022"                                                     #                                                                #
                                                                                     #
######################################################################################

#First let us convert the data into a time series object
cust_flx022_ts<-ts(df_cust_orders$FLX022, start=c(2006,1),frequency=12)
# We are training the model beginning January 2014 and testing the model beginning June 2016
cust_flx022_in <- window(cust_flx022_ts,end=c(2014,5))
cust_flx022_out <- window(cust_flx022_ts,start=c(2014,6))
# Let's take a look at the decomposed data set to see if we observe trend or seasonality
fit_flx022<-stl(cust_flx022_in, s.window="periodic")
plot(fit_flx022)

######################################################################################

#Check the ANN Model for product FLX022
modann_flx022 <- ets(cust_flx022_in, model="ANN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx022_ann_in<-fitted(modann_flx022,h=3)
accuracy(fore_flx022_ann_in,cust_flx022_in)  #81.17642

######################################################################################

##Check the AAN Model for product FLX022
modaan_flx022 <- ets(cust_flx022_in, model="AAN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx022_aan_in<-fitted(modaan_flx022,h=3)
accuracy(fore_flx022_aan_in,cust_flx022_in)  #93.0037

#########################################################################################

#Check the ANA model for product FLX022
modana_flx022 <- ets(cust_flx022_in, model="ANA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx022_ana_in<-fitted(modana_flx022,h=3)
accuracy(fore_flx022_ana_in,cust_flx022_in)  #79.99313

######################################################################################

#AAA Model
modaaa_flx022 <- ets(cust_flx022_in, model="AAA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx022_aaa_in<-fitted(modaaa_flx022,h=3)
accuracy(fore_flx022_aaa_in,cust_flx022_in)  #90.81331

########################################################################################

#ANA is the best model with minimum RMSE for product "FLX022"
#Check the accuracy on test data
modana_flx022_refit <- ets(cust_flx022_ts, model=modana_flx022, use.initial.values=TRUE)
#now let us check the forcasts for 3 month time period
myfore_flx022_ana_3 <- fitted(modana_flx022_refit,h=3)
#now let us check the acuracy of our forecast on test data
accuracy(myfore_flx022_ana_3,cust_flx022_out)  #93.15707

#######################################################################################

#Now let us see the performance of Shure forecast
#First let us convert the data into a time series object
shure_flx022_forecasts_ts<-ts(df_shure_forecasts$FLX022, start=c(2014,6),frequency=12)
#Now let us check the accuracy of the shure forecasting data
accuracy(shure_flx022_forecasts_ts,cust_flx022_out)  #104.5787

########################################################################################

#Question 2a
#Forecast for product FLX022
# If we want to forecast into the future, and also generate
# prediction intervals, we can use the forecast() function
# The number following "modana_cust_refit" is the number of periods
forecast(modana_flx022_refit, 3)
# We can plot the forecasts on our graph
plot(forecast(modana_flx022_refit,3), type="b")
lines(modana_flx022_refit$fitted, col=4, type="b")

# Can check RMSE for different forecast horizons as follows
#fitting the data for different time periods
myforeana_flx022_1 <- fitted(modana_flx022_refit,h=1)
myforeana_flx022_3 <- fitted(modana_flx022_refit,h=3)
myforeana_flx022_5 <- fitted(modana_flx022_refit,h=5)

# To check the accuracy of our forecasts on the test data, we can use the accuracy function
accuracy(myforeana_flx022_1,cust_flx022_out)  #90.38632
accuracy(myforeana_flx022_3,cust_flx022_out)  #93.15707
accuracy(myforeana_flx022_5,cust_flx022_out)  #91.06706

#######################################################################################
                                                                                      #
#For Product FLX026                                                                   #
                                                                                      #
#######################################################################################

#now let us convert the data into a time series object
cust_flx026_ts<-ts(df_cust_orders$FLX026, start=c(2006,1),frequency=12)
#We are training the model beginning January 2014 and testing the model beginning June 2016
cust_flx026_in <- window(cust_flx026_ts,end=c(2014,5))
cust_flx026_out <- window(cust_flx026_ts,start=c(2014,6))
# Let's take a look at the decomposed data set to see if we observe trend or seasonality
fit_flx026<-stl(cust_flx026_in, s.window="periodic")
#plot the graph to see if trend and seasonality exists in the data
plot(fit_flx026)

#######################################################################################

#ANN Model for FLX026
modann_flx026 <- ets(cust_flx026_in, model="ANN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx026_ann_in<-fitted(modann_flx026,h=3)
accuracy(fore_flx026_ann_in,cust_flx026_in) #30.53968

######################################################################################

#AAN Model for flx026
modaan_flx026 <- ets(cust_flx026_in, model="AAN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx026_aan_in<-fitted(modaan_flx026,h=3)
accuracy(fore_flx026_aan_in,cust_flx026_in)#33.69891

#######################################################################################

# Check ANA Model for product "FLX026"
modana_flx026 <- ets(cust_flx026_in, model="ANA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx026_ana_in<-fitted(modana_flx026,h=3)
#Check the accuracy on training data
accuracy(fore_flx026_ana_in,cust_flx026_in)   #28.3251

#######################################################################################

#Check AAA Model for "FLX026"
modaaa_flx026 <- ets(cust_flx026_in, model="AAA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx026_aaa_in<-fitted(modaaa_flx026,h=3)
#Check the accuracy for training data
accuracy(fore_flx026_aaa_in,cust_flx026_in)  #31.72246

#########################################################################################

#We see that ANA model has the lowest RMSE so we chose it
#Refit the model on the whole dataset
modana_flx026_refit <- ets(cust_flx026_ts, model=modana_flx026, use.initial.values=TRUE)
#now let us check the forcasts for 3 month time period
myfore_flx026_ana_3 <- fitted(modana_flx026_refit,h=3)
#now let us check the accuracy of our forecast on test data
accuracy(myfore_flx026_ana_3,cust_flx026_out)   #30.25708

#######################################################################################

#Now let us see the performance of Shure forecast
#now let us convert the data into a time series object
shure_flx026_forecasts_ts<-ts(df_shure_forecasts$FLX026, start=c(2014,6),frequency=12)
#Now let us check the accuracy of the shure forecasting data
accuracy(shure_flx026_forecasts_ts,cust_flx026_out)  #36.67304

########################################################################################

#Question 2a
#Forecast for product FLX026
# If we want to forecast into the future, and also generate
# prediction intervals, we can use the forecast() function
# The number following "modana_cust_refit" is the number of periods
forecast(modana_flx026_refit, 3)

# We can plot the forecasts on our graph
plot(forecast(modana_flx026_refit,3), type="b")
lines(modana_flx026_refit$fitted, col=4, type="b")

# Can check RMSE for different forecast horizons as follows
#fitting the data for different time periods
myforeana_flx026_1 <- fitted(modana_flx026_refit,h=1)
myforeana_flx026_3 <- fitted(modana_flx026_refit,h=3)
myforeana_flx026_5 <- fitted(modana_flx026_refit,h=5)

# To check the accuracy of our forecasts on the test data, we can use the accuracy function
accuracy(myforeana_flx026_1,cust_flx026_out)  #30.30728
accuracy(myforeana_flx026_3,cust_flx026_out)  #30.25708
accuracy(myforeana_flx026_5,cust_flx026_out)  #29.8457

#######################################################################################
                                                                                      #
#FOR FLX078                                                                           #
                                                                                      #
#######################################################################################

#now let us convert the data into a time series object
cust_flx078_ts<-ts(df_cust_orders$FLX078, start=c(2006,1),frequency=12)
# # We are training the model beginning January 2014 and testing the model beginning June 2016
cust_flx078_in <- window(cust_flx078_ts,end=c(2014,5))
cust_flx078_out <- window(cust_flx078_ts,start=c(2014,6))
# Let's take a look at the decomposed data set to see if we observe trend or seasonality
fit_flx078<-stl(cust_flx078_in, s.window="periodic")
plot(fit_flx078)

########################################################################################

#Model ANN
modann_flx078 <- ets(cust_flx078_in, model="ANN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx078_ann_in<-fitted(modann_flx078,h=3)
#Check the accuracy on training data
accuracy(fore_flx078_ann_in,cust_flx078_in) #61.19365

######################################################################################

#Model AAN
modaan_flx078 <- ets(cust_flx078_in, model="AAN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx078_aan_in<-fitted(modaan_flx078,h=3)
#Check the accuracy on training data
accuracy(fore_flx078_aan_in,cust_flx078_in)#73.22547

################################################################################

#ANA is the best model with minimum RMSE for product "FLX078"
modana_flx078 <- ets(cust_flx078_in, model="ANA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx078_ana_in<-fitted(modana_flx078,h=3)
#Check the accuracy on training data
accuracy(fore_flx078_ana_in,cust_flx078_in)   #57.13112

########################################################################################

#Model AAA
#Prepare the model
modaaa_flx078 <- ets(cust_flx078_in, model="AAA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx078_aaa_in<-fitted(modaaa_flx078,h=3)
#Check the accuracy on training data
accuracy(fore_flx078_aaa_in,cust_flx078_in) #66.19172

########################################################################################

#ANA is the best model with lowest RMSE
#Now let us see the model performance on test data
modana_flx078_refit <- ets(cust_flx078_ts, model=modana_flx078, use.initial.values=TRUE)
#now let us check the forcasts for 3 month time period
myfore_flx078_ana_3 <- fitted(modana_flx078_refit,h=3)
#now let us check the acuracy of our forecast on test data
accuracy(myfore_flx078_ana_3,cust_flx078_out)   #77.748

#########################################################################################

#Now let us see the performance of Shure forecast
#now let us convert the data into a time series object
shure_flx078_forecasts_ts<-ts(df_shure_forecasts$FLX078, start=c(2014,6),frequency=12)
#Now let us check the accuracy of the shure forecasting data
accuracy(shure_flx078_forecasts_ts,cust_flx078_out)  #79.10176

#########################################################################################

#Question 2a
#Forecast for product FLX078
# If we want to forecast into the future, and also generate
# prediction intervals, we can use the forecast() function
# The number following "modana_flx078_refit" is the number of periods
forecast(modana_flx078_refit, 3)

# We can plot the forecasts on our graph
plot(forecast(modana_flx078_refit,3), type="b")
lines(modana_flx078_refit$fitted, col=4, type="b")

# Can check RMSE for different forecast horizons as follows
#fitting the data for different time periods
myforeana_flx078_1 <- fitted(modana_flx078_refit,h=1)
myforeana_flx078_3 <- fitted(modana_flx078_refit,h=3)
myforeana_flx078_5 <- fitted(modana_flx078_refit,h=5)

# To check the accuracy of our forecasts on the test data, we can use the accuracy function
accuracy(myforeana_flx078_1,cust_flx078_out)  #76.8941
accuracy(myforeana_flx078_3,cust_flx078_out)  #77.748
accuracy(myforeana_flx078_5,cust_flx078_out)  #77.81087

#######################################################################################
                                                                                      #
# Modelling For product FLX081                                                        #
                                                                                      #
#######################################################################################

#now let us convert the data into a time series object
cust_flx081_ts<-ts(df_cust_orders$FLX081, start=c(2006,1),frequency=12)
#We are training the model beginning January 2014 and testing the model beginning June 2016
cust_flx081_in <- window(cust_flx081_ts,end=c(2014,5))
cust_flx081_out <- window(cust_flx081_ts,start=c(2014,6))
# Let's take a look at the decomposed data set to see if we observe trend or seasonality
fit_flx081<-stl(cust_flx081_in, s.window="periodic")
#plot the graph to see observe if trend and seasonality exist in data
plot(fit_flx081)

########################################################################################

#Model ANN
modann_flx081 <- ets(cust_flx081_in, model="ANN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx081_ann_in<-fitted(modann_flx081,h=3)
accuracy(fore_flx081_ann_in,cust_flx081_in) #185.4504

########################################################################################

#Train Model AAN
modaan_flx081 <- ets(cust_flx081_in, model="AAN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx081_aan_in<-fitted(modaan_flx081,h=3)
#fore_flx081_aan_in
accuracy(fore_flx081_aan_in,cust_flx081_in)#217.6083

#####################################################################################

#Train the ANA Model
modana_flx081 <- ets(cust_flx081_in, model="ANA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx081_ana_in<-fitted(modana_flx081,h=3)
accuracy(fore_flx081_ana_in,cust_flx081_in)   #175.1507

########################################################################################

#Model AAA
modaaa_flx081 <- ets(cust_flx081_in, model="AAA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx081_aaa_in<-fitted(modaaa_flx081,h=3)
accuracy(fore_flx081_aaa_in,cust_flx081_in) #207.0156

########################################################################################

#We see that ANA model has the lowest RMSE
#Now let us see the model performance on test data
modana_flx081_refit <- ets(cust_flx081_ts, model=modana_flx081, use.initial.values=TRUE)
#now let us check the forcasts for 3 month time period
myfore_flx081_ana_3 <- fitted(modana_flx081_refit,h=3)
#now let us check the acuracy of our forecast on test data
accuracy(myfore_flx081_ana_3,cust_flx081_out)   #186.5216

########################################################################################

#Now let us see the performance of Shure forecast for product FLX 081
#now let us convert the data into a time series object
shure_flx081_forecasts_ts<-ts(df_shure_forecasts$FLX081, start=c(2014,6),frequency=12)
#Now let us check the accuracy of the shure forecasting data
accuracy(shure_flx081_forecasts_ts,cust_flx081_out)  #193.7854

########################################################################################

#2a
#Forecast for product FLX081
# If we want to forecast into the future, and also generate
# prediction intervals, we can use the forecast() function
# The number following "modana_flx081_refit" is the number of periods
forecast(modana_flx081_refit, 3)

# We can plot the forecasts on our graph
plot(forecast(modana_flx081_refit,3), type="b")
lines(modana_flx081_refit$fitted, col=4, type="b")

# Can check RMSE for different forecast horizons as follows
#fitting the data for different time periods
myforeana_flx081_1 <- fitted(modana_flx081_refit,h=1)
myforeana_flx081_3 <- fitted(modana_flx081_refit,h=3)
myforeana_flx081_5 <- fitted(modana_flx081_refit,h=5)

# To check the accuracy of our forecasts on the test data, we can use the accuracy function
accuracy(myforeana_flx081_1,cust_flx081_out)  #182.5314
accuracy(myforeana_flx081_3,cust_flx081_out)  #186.5216
accuracy(myforeana_flx081_5,cust_flx081_out)  #189.2869

########################################################################################
                                                                                       #
#for product FLX102                                                                    #
                                                                                       #
########################################################################################

#now let us convert the data into a time series object
cust_flx102_ts<-ts(df_cust_orders$FLX102, start=c(2006,1),frequency=12)
#We are training the model beginning January 2014 and testing the model beginning June 2016
cust_flx102_in <- window(cust_flx102_ts,end=c(2014,5))
cust_flx102_out <- window(cust_flx102_ts,start=c(2014,6))
# Let's take a look at the decomposed data set to see if we observe trend or seasonality
fit_flx102<-stl(cust_flx102_in, s.window="periodic")
plot(fit_flx102)

########################################################################################

#Model ANN
modann_flx102 <- ets(cust_flx102_in, model="ANN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx102_ann_in<-fitted(modann_flx102,h=3)
#fore_flx102_ann_in
accuracy(fore_flx102_ann_in,cust_flx102_in) #85.73772

######################################################################################

#Model AAN
modaan_flx102 <- ets(cust_flx102_in, model="AAN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx102_aan_in<-fitted(modaan_flx102,h=3)
accuracy(fore_flx102_aan_in,cust_flx102_in) #99.77118

################################################################################

#ANA is the best model with minimum RMSE for product "FLX102"
modana_flx102 <- ets(cust_flx102_in, model="ANA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx102_ana_in<-fitted(modana_flx102,h=3)
#fore_flx081_aan_in
accuracy(fore_flx102_ana_in,cust_flx102_in)   #76.3118

########################################################################################

#Model AAA
modaaa_flx102 <- ets(cust_flx102_in, model="AAA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx102_aaa_in<-fitted(modaaa_flx102,h=3)
#fore_flx019_aaa_in
accuracy(fore_flx102_aaa_in,cust_flx102_in) #88.4817

########################################################################################

# We see that ANA model is the best with lowest RMSE
#Now let us see the model performance on test data
modana_flx102_refit <- ets(cust_flx102_ts, model=modana_flx102, use.initial.values=TRUE)
#now let us check the forcasts for 3 month time period
myfore_flx102_ana_3 <- fitted(modana_flx102_refit,h=3)
#now let us check the acuracy of our forecast on test data
accuracy(myfore_flx102_ana_3,cust_flx102_out)   #106.6166

########################################################################################

#Now let us see the performance of Shure forecast
#now let us convert the data into a time series object
shure_flx102_forecasts_ts<-ts(df_shure_forecasts$FLX102, start=c(2014,6),frequency=12)
#Now let us check the accuracy of the shure forecasting data
accuracy(shure_flx102_forecasts_ts,cust_flx102_out)  #102.3973

########################################################################################

# Question 2a
#Forecast for product FLX102
# If we want to forecast into the future, and also generate
# prediction intervals, we can use the forecast() function
# The number following "modana_flx102_refit" is the number of periods
forecast(modana_flx102_refit, 3)

# We can plot the forecasts on our graph
plot(forecast(modana_flx102_refit,3), type="b")
lines(modana_flx102_refit$fitted, col=4, type="b")

# Can check RMSE for different forecast horizons as follows
#fitting the data for different time periods
myforeana_flx102_1 <- fitted(modana_flx102_refit,h=1)
myforeana_flx102_3 <- fitted(modana_flx102_refit,h=3)
myforeana_flx102_5 <- fitted(modana_flx102_refit,h=5)

# To check the accuracy of our forecasts on the test data, we can use the accuracy function
accuracy(myforeana_flx102_1,cust_flx102_out)  #106.6993
accuracy(myforeana_flx102_3,cust_flx102_out)  #106.6166
accuracy(myforeana_flx102_5,cust_flx102_out)  #107.7073

#######################################################################################
                                                                                      #
# Modelling For FLX105                                                                #
                                                                                      #
#######################################################################################

#now let us convert the data into a time series object
cust_flx105_ts<-ts(df_cust_orders$FLX105, start=c(2006,1),frequency=12)
# We are training the model beginning January 2014 and testing the model beginning June 2016
cust_flx105_in <- window(cust_flx105_ts,end=c(2014,5))
cust_flx105_out <- window(cust_flx105_ts,start=c(2014,6))
# Let's take a look at the decomposed data set to see if we observe trend or seasonality
fit_flx105<-stl(cust_flx105_in, s.window="periodic")
plot(fit_flx105)

########################################################################################

#Model ANN
modann_flx105 <- ets(cust_flx105_in, model="ANN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx105_ann_in<-fitted(modann_flx105,h=3)
accuracy(fore_flx105_ann_in,cust_flx105_in) #186.8786

########################################################################################

#Model AAN for FLX105
modaan_flx105 <- ets(cust_flx105_in, model="AAN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx105_aan_in<-fitted(modaan_flx105,h=3)
accuracy(fore_flx105_aan_in,cust_flx105_in)#205.8562

#######################################################################################

#Model ANA for product "FLX105"
modana_flx105 <- ets(cust_flx105_in, model="ANA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx105_ana_in<-fitted(modana_flx105,h=3)
accuracy(fore_flx105_ana_in,cust_flx105_in)   #168.9206

########################################################################################

#Model AAA
modaaa_flx105 <- ets(cust_flx105_in, model="AAA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx105_aaa_in<-fitted(modaaa_flx105,h=3)
accuracy(fore_flx105_aaa_in,cust_flx105_in) #185.0722

#########################################################################################

#We see that ANA model is best with lowest RMSE
#Now let us see the model performance on test data
modana_flx105_refit <- ets(cust_flx105_ts, model=modana_flx105, use.initial.values=TRUE)
#now let us check the forcasts for 3 month time period
myfore_flx105_ana_3 <- fitted(modana_flx105_refit,h=3)
#now let us check the acuracy of our forecast on test data
accuracy(myfore_flx105_ana_3,cust_flx105_out)   #195.3945

########################################################################################

#Now let us see the performance of Shure forecast
#now let us convert the data into a time series object
shure_flx105_forecasts_ts<-ts(df_shure_forecasts$FLX105, start=c(2014,6),frequency=12)
#Now let us check the accuracy of the shure forecasting data
accuracy(shure_flx105_forecasts_ts,cust_flx105_out)  #217.7631

########################################################################################

#Forecast for product FLX105
# If we want to forecast into the future, and also generate
# prediction intervals, we can use the forecast() function
# The number following "modana_flx105_refit" is the number of periods
forecast(modana_flx105_refit, 3)

# We can plot the forecasts on our graph
plot(forecast(modana_flx105_refit,3), type="b")
lines(modana_flx105_refit$fitted, col=4, type="b")

# Can check RMSE for different forecast horizons as follows
#fitting the data for different time periods
myforeana_flx105_1 <- fitted(modana_flx105_refit,h=1)
myforeana_flx105_3 <- fitted(modana_flx105_refit,h=3)
myforeana_flx105_5 <- fitted(modana_flx105_refit,h=5)

# To check the accuracy of our forecasts on the test data, we can use the accuracy function
accuracy(myforeana_flx105_1,cust_flx105_out)  #189.4226
accuracy(myforeana_flx105_3,cust_flx105_out)  #195.3945
accuracy(myforeana_flx105_5,cust_flx105_out)  #200.1349

########################################################################################
                                                                                       #
#Modelling For FLX107                                                                  #
                                                                                       #
########################################################################################

#now let us convert the data into a time series object
cust_flx107_ts<-ts(df_cust_orders$FLX107, start=c(2006,1),frequency=12)
# Suppose we want to train the model on the first 9 years of data
cust_flx107_in <- window(cust_flx107_ts,end=c(2014,5))
cust_flx107_out <- window(cust_flx107_ts,start=c(2014,6))
# Let's take a look at the decomposed data set to see if we observe trend or seasonality
fit_flx107<-stl(cust_flx107_in, s.window="periodic")
plot(fit_flx107)

########################################################################################

#Model ANN
modann_flx107 <- ets(cust_flx107_in, model="ANN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx107_ann_in<-fitted(modann_flx107,h=3)
#Check the accuracy for training data
accuracy(fore_flx107_ann_in,cust_flx107_in) #82.53761

########################################################################################

#Model AAN
modaan_flx107 <- ets(cust_flx107_in, model="AAN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
#Generate forecast values 3 months ahead
fore_flx107_aan_in<-fitted(modaan_flx107,h=3)
#Check the accuracy for training data
accuracy(fore_flx107_aan_in,cust_flx107_in)#94.92421

########################################################################################

#ANA for product "FLX107"
modana_flx107 <- ets(cust_flx107_in, model="ANA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx107_ana_in<-fitted(modana_flx107,h=3)
#Check the accuracy for training data
accuracy(fore_flx107_ana_in,cust_flx107_in)   #80.41972

########################################################################################

#Model AAA
modaaa_flx107 <- ets(cust_flx107_in, model="AAA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_flx107_aaa_in<-fitted(modaaa_flx107,h=3)
#Check the accuracy for training data
accuracy(fore_flx107_aaa_in,cust_flx107_in) #92.15553

#########################################################################################

#Model ANA is the best model for product FLX107 with lowest RMSE
#Now let us see the model performance on test data
modana_flx107_refit <- ets(cust_flx107_ts, model=modana_flx107, use.initial.values=TRUE)
#now let us check the forcasts for 3 month time period
myfore_flx107_ana_3 <- fitted(modana_flx107_refit,h=3)
#now let us check the acuracy of our forecast on test data
accuracy(myfore_flx107_ana_3,cust_flx107_out)   #71.14235

########################################################################################

#Now let us see the performance of Shure forecast
#now let us convert the data into a time series object
shure_flx107_forecasts_ts<-ts(df_shure_forecasts$FLX107, start=c(2014,6),frequency=12)
#Now let us check the accuracy of the shure forecasting data
accuracy(shure_flx107_forecasts_ts,cust_flx107_out)  #74.31075

########################################################################################

#Forecast for product FLX107
# If we want to forecast into the future, and also generate
# prediction intervals, we can use the forecast() function
# The number following "modana_flx107_refit" is the number of periods
forecast(modana_flx107_refit, 3)

# We can plot the forecasts on our graph
plot(forecast(modana_flx107_refit,3), type="b")
lines(modana_flx107_refit$fitted, col=4, type="b")

# Can check RMSE for different forecast horizons as follows
#fitting the data for different time periods
myforeana_flx107_1 <- fitted(modana_flx107_refit,h=1)
myforeana_flx107_3 <- fitted(modana_flx107_refit,h=3)
myforeana_flx107_5 <- fitted(modana_flx107_refit,h=5)

# To check the accuracy of our forecasts on the test data, we can use the accuracy function
accuracy(myforeana_flx107_1,cust_flx107_out)  #70.99844
accuracy(myforeana_flx107_3,cust_flx107_out)  #71.14235
accuracy(myforeana_flx107_5,cust_flx107_out)  #71.21635

#######################################################################################
                                                                                      #
#Modelling FOR TOTAL                                                                  #
                                                                                      #
#######################################################################################

# now let us convert the data into a time series object
cust_total_ts<-ts(df_cust_orders$Total, start=c(2006,1),frequency=12)
# We are training the model beginning January 2014 and testing the model beginning June 2016
cust_total_in <- window(cust_total_ts,end=c(2014,5))
cust_total_out <- window(cust_total_ts,start=c(2014,6))
# Let's take a look at the decomposed data set to see if we observe trend or seasonality
fit_total<-stl(cust_total_in, s.window="periodic")
plot(fit_total)

######################################################################################

#Check for models
# ANA Model for product TOTAL
modana_total <- ets(cust_total_in, model="ANA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_total_ana_in<-fitted(modana_total,h=3)
#Check the accuracy for training data
accuracy(fore_total_ana_in,cust_total_in) #405.1508 

########################################################################################
#ANN for product "Total"
modann_total <- ets(cust_total_in, model="ANN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_total_ann_in<-fitted(modann_total,h=3)
#Check the accuracy for training data
accuracy(fore_total_ann_in,cust_total_in)   #454.4445

#######################################################################################

#AAN for product "Total"
modaan_total <- ets(cust_total_in, model="AAN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_total_aan_in<-fitted(modaan_total,h=3)
#Check the accuracy for training data
accuracy(fore_total_aan_in,cust_total_in)  #529.4324

######################################################################################

#AAA for product "Total"
modaaa_total <- ets(cust_total_in, model="AAA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="amse",nmse=5)
fore_total_aaa_in<-fitted(modaaa_total,h=3)
#Check the accuracy for training data
accuracy(fore_total_aaa_in,cust_total_in)  #452.7303

########################################################################################

#ANA is the best model with lowest RMSE
#Refit the model on whole dataset
modana_total_refit <- ets(cust_total_ts, model=modana_total, use.initial.values=TRUE)
myfore_total_ana_3 <- fitted(modana_total_refit,h=3)
#now let us check the acuracy of our forecast on test data
accuracy(myfore_total_ana_3,cust_total_out)  #428.0347

######################################################################################

#Now let us see the performance of Shure forecast
#now let us convert the data into a time series object
shure_total_forecasts_ts<-ts(df_shure_forecasts$Total, start=c(2014,6),frequency=12)
#Now let us check the accuracy of the shure forecasting data
accuracy(shure_total_forecasts_ts,cust_total_out)  #507.839

########################################################################################

# Question 2a
#Forecasts for TOTAL
# If we want to forecast into the future, and also generate
# prediction intervals, we can use the forecast() function
# The number following "modana_total_refit" is the number of periods
forecast(modana_total_refit, 3)

# We can plot the forecasts on our graph
plot(forecast(modana_total_refit,3), type="b")
lines(modana_total_refit$fitted, col=4, type="b")
#####################################################################################
#2a Compute and compare RMSE's of 1-month ahead and 5-month ahead forecast based on test \
# data
# Can check RMSE for different forecast horizons as follows
#fitting the data for different time periods
myforeana_total_1 <- fitted(modana_total_refit,h=1)
myforeana_total_3 <- fitted(modana_total_refit,h=3)
myforeana_total_5 <- fitted(modana_total_refit,h=5)


# To check the accuracy of our forecasts on the test data, we can use the accuracy function
accuracy(myforeana_total_1,cust_total_out)  #416.2905
accuracy(myforeana_total_3,cust_total_out)  #428.0347
accuracy(myforeana_total_5,cust_total_out)  #440.7787

#####################################################################################

#Question 2b
#Please refer the MS-Word Document for Answer

####################################################################################

#Question 3 Please refer the MS-Word document for the answer

####################################################################################

#Analyzing Dish Network Data

####################################################################################

#Read the csv file
dish_return<-read.csv("DishWeekly.csv")
dim(dish_return)
head(dish_return)
tail(dish_return)

# Next we'll convert this into a time series object
# we'll take this as weekly data 
dish_ts<-ts(dish_return$Units,start=c(2014,4),end = c(2014,27),frequency=52)

# Suppose we want to train the model on the first 14 weeks and test it on next 10 weeks 
dish_in <- window(dish_ts,start =c(2014,4),end=c(2014,17))
dish_out <- window(dish_ts,start=c(2014,18))

# Let's take a look at the decomposed data set to see if we observe trend or seasonality
#fit_dish<-stl(dish_in, s.window="periodic")
#We are unable to use the stl function as the data is not present for the whole period
#Let us see the plot for training data
plot(dish_in)

#ANN Model
modann_dish <- ets(dish_in, model="ANN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="mse")
fore_ann_dish_in<-fitted(modann_dish,h=1)
accuracy(fore_ann_dish_in,dish_in)  #840.6879

#AAN Model
modaan_dish <- ets(dish_in, model="AAN", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="mse")
fore_aan_dish_in<-fitted(modaan_dish,h=1)
accuracy(fore_aan_dish_in,dish_in)    #922.8053

#ANA Model
modana_dish <- ets(dish_in, model="ANA",lower=c(.05,.05,.05),upper=c(.3,.3,.3), damped=FALSE, opt.crit="mse")
fore_ana_dish_in<-fitted(modana_dish,h=1)
accuracy(fore_ana_dish_in,dish_in)  #840.6879

#AAA Model
modaaa_dish <- ets(dish_in, model="AAA", damped=FALSE, lower=c(.05,.05,.05),upper=c(.3,.3,.3), opt.crit="mse")
fore_aaa_dish_in<-fitted(modaaa_dish,h=1)
accuracy(fore_aaa_dish_in,dish_in) #922.8053

#We see in the above modelling that "ANN" and "ANA" models give us the same RMSE.
#It is because we do not have the data for the whole year as a result R cannot estimate
#seasonality effect as a result we do not have any gamma values in ANA model.


#Now we can take either take ANN or ANA model as both are working the same way with only alpha values
# Let's feed the whole time series into the ANN model to get the fitted values
modann_dish_refit <- ets(dish_ts, model=modann_dish, use.initial.values=TRUE)

#Let us get the forecasted values for the training and test data for 1-month ahead forecast
myforeann_dish_1 <- fitted(modann_dish_refit,h=1)

#Now let us check the accuracy of our forecasts on test data using accuracy function
accuracy(myforeann_dish_1,dish_out)  #1056.089

########################################################################################
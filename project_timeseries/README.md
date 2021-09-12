**Time Series Forecasting Assignment**

**Question 1**

|<p></p><p>Product</p>|<p></p><p>Model</p>|<p>3 month RMSE</p><p>Training</p>|<p></p><p>alpha</p>|<p></p><p>Beta</p>|<p></p><p>gamma</p>|<p>3 month RMSE</p><p>Test</p>|<p>Shure 3 month</p><p>RMSE test</p>|<p></p><p>Difference</p>|
| :- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
|FLX012|ANA|31.09324|0.1338|NA|0.05|35.53165|34.48956|1.04209|
|FLX019|ANA|106.5702|0.0936|NA|0.05|87.50491|76.10828|11.39663|
|FLX022|ANA|79.99313|0.0897|NA|0.05|93.15707|104.5787|-11.42163|
|FLX026|ANA|28.3251|0.1106|NA|0.05|30.25708|36.67304|-6.41596|
|FLX078|ANA|57.13112|0.0505|NA|0.0504|77.748|79.10176|-1.35376|
|FLX081|ANA|175.1507|0.0731|NA|0.05|186.5216|193.7854|-7.2638|
|FLX102|ANA|76.3118|0.0506|NA|0.0503|106.6166|102.3973|4.2193|
|FLX105|ANA|168.9206|0.0956|NA|0.05|195.3945|217.7631|-22.3686|
|FLX107|ANA|80.41972|0.05|NA|0.05|71.14235|74.31075|-3.1684|
|FLXTotal|ANA|405.1508|0.1432|NA|0.0501|428.0347|507.839|-79.8043|

We see that all our models that perform best on the training data are ANA models. That means R sees seasonality in the data for all products. We also see that all, except 3, of our RMSE values are better than what Shure data projected. This makes me curious to understand what process the company is using to do time series forecasting as we have done these forecasts on a very basic level & getting similar or even better results than actual Shure forecasting.

**Question 2**

**Part (a)**

|<p></p><p>Product</p>|<p>1 month RMSE</p><p>Test</p>|<p>3 month RMSE</p><p>Test</p>|<p>5 month RMSE</p><p>Test</p>|
| :- | :-: | :-: | :-: |
|FLX012|35.28009|35.53165|34.82094|
|FLX019|86.45837|87.50491|87.19887|
|FLX022|90.38632|93.15707|91.06706|
|FLX026|30.30728|30.25708|29.8457|
|FLX078|76.8941|77.748|77.81087|
|FLX081|182.5314|186.5216|189.2869|
|FLX102|106.6993|106.6166|107.7073|
|FLX105|189.4226|195.3945|200.1349|
|FLX107|70.99844|71.14235|71.21635|
|FLXTotal|416.2905|428.0347|440.7787|

- We can deduce from the above table that majority of products show a slight increase in RMSE(variability in forecast) as the lead time increases. The increase in RMSE with respect to lead time is not seen for products “FLX012”,“FLX022” ,“FLX026 & FLX 102”.
- Also, for some products such as “FLX019” we see a very small difference in accuracy (RMSE) over different lead time periods while for products such as “FLX105” we see a bigger difference between accuracies over different lead times. 


**Part (b)**

|<p></p><p>Product</p>|<p>Safety stock</p><p>L = 1</p>|<p>Safety stock</p><p>L = 3</p>|<p>Safety stock</p><p>L = 5</p>|
| :- | :-: | :-: | :-: |
|FLX012|81.8254|116.5438|139.8814|
|FLX019|200.5237|287.0161|350.2920|
|FLX022|209.6339|305.5551|365.8312|
|FLX026|70.2919|99.2432|119.8950|
|FLX078|178.3412|255.0036|312.5789|
|FLX081|423.3469|611.7908|760.3963|
|FLX102|247.4687|349.7024|432.6778|
|FLX105|439.3297|640.8939|803.9745|
|FLX107|164.6674|233.3469|286.0876|
|FLXTotal|965.5068|1403.9538|1770.6799|

We can deduce a few things from the above table:

- As the lead time increases the amount of safety stock also increases.
- The accuracy or the root mean squared error shows the variability in our forecast. The more the root mean squared error, the more is the variability in our forecast.  Let us consider RMSE’s for products “FLX012” and “FLX105”. We see that variability in RMSE’s for FLX012 over different lead times is less as compared to FLX105. Due to this, we see that the difference between the safety stock forecasts over different lead times for FLX105 shows higher variability than for FLX012.  

**Question 3**

**Comparing inventory requirements** Sum of safety stock of all products – Total safety stock

**For Lead Time=1,**

Sum of safety stocks for individual products = 2015.4288

Total safety stocks for total demand  =  965.50682

= 2009.42593-965.50682

= **1049.922**

**For Lead Time = 3,**

Sum of safety stocks for individual products = 2899.0958

Total safety stocks for total demand  = 1403.95382

= 2890.33817 – 1403.95382 

=**1495.142**

**For Lead Time = 5,**

Sum of safety stocks for individual products =  3571.6147

Total safety stocks for total demand  = 1770.67996

= 3563.66012 – 1770.67996

= **1800.9348**

**As the cost of all products is roughly the same, we can say that if Shure goes with postponement strategy, they will be keeping less safety stocks as compared to keeping safety stocks for individual** **products. This can help the company to save on inventory holding costs and total variable costs per order. These savings can be used by the company on other areas of business.**

**Dish Network Data**


|Week starting|Actual returns|Forecast returns||
| :-: | :-: | :-: | :- |
|1/26/2014|**12479**|**13356.94**||
|2/2/2014|**12105**|**13313.04**||
|2/9/2014|**12315**|**13252.64**||
|2/16/2014|**13804**|**13205.76**||
|2/23/2014|**14827** |**13235.67**||
|3/2/2014|**12994**|**13315.24**||
|3/9/2014|**14487** |**13299.17**||
|3/16/2014|**14089** |**13358.57**||
|3/23/2014|**14119**|**13395.09**||
|3/30/2014|**13842** |**13431.28**||
|4/6/2014|**13694** |**13451.82**||
|4/13/2014|**12659** |**13463.93**||
|4/20/2014|**12916**|**13423.68**||
|4/27/2014|**12962**|**13398.30**|Squared error|
|5/4/2014|**13734** |**13376.48**|**127820.55**|
|5/11/2014|**11837** |**13394.36**|**2425370.17**|
|5/18/2014|**12594** |**13316.49**|**521991.8**|
|5/25/2014|**10832**|**13280.37**|**5994515.66**|
|6/1/2014|**13836**|**13157.95**|**459751.802**|
|6/8/2014|**13885**|**13191.85**|**480456.923**|
|6/15/2014|**13245**|**13226.51**|**341.8801**|
|6/22/2014|**12184**|**13227.43**|**1088746.16**|
|6/29/2014|**13116**|**13175.26**|**3511.7476**|
|7/6/2014|**12947**|**13172.30**|**50760.09**|
|||**RMSE for test data:**|**1056.09**|



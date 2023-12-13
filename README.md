# Time-Series-and-Machine-learning-models
## Project Title: Bagging-Based Hybrid Time Series Models for Forecasting Indian Economic Indicators

### Project Motivation:
This MSc project, titled "Bagging-Based Hybrid Time Series Models for Forecasting Indian Economic Indicators," is fueled by the imperative to enhance the accuracy of forecasting for economic indicators in India. As data grows and forecasting challenges become more intricate, the study aims to go beyond existing methodologies. Specifically, it focuses on comparing the performance of a newly proposed bagging-based hybrid time series model with established hybrid models. The motivation is driven by the prospect of contributing to advancements in the field and addressing current limitations.

### Introduction and Background:
Time series analysis plays a pivotal role in various fields, with its significance expanding as the volume of time-oriented data grows exponentially. This project focuses on forecasting Indian economic indicators using a blend of statistical and machine learning techniques. Economic indicators serve as the time series dataset, and forecasting them provides valuable insights for decision-making in areas such as finance, policy, and planning.
### Data Source:
1) Clearing Corporation Of India Limited (CCIL)
(https://www.ccilindia.com/Research/Statistics/Pages/CCILTBILLIndex.aspx)

2) Asian Development Bank (ADB) Website :
https://aric.adb.org/database/economic-financial-indicators


### Aim:
To develop a bagging-based hybrid time series model for forecast![image](https://github.com/Adhitibhat/Time-Series-and-Machine-learning-models/assets/110439208/16e1a6f0-aa7c-4aae-8252-fb165447b2d3)
ing Indian economic indicators, aiming to surpass the forecasting capacity of existing hybrid models.
objectives
•	Examine the performance of selected base time series models in forecasting Indian economic indicators.

•	Evaluate the performance of parallel hybrid time series models incorporating various weighting methods.

•	Assess the forecasting capabilities of bagged base time series models.

•	Investigate the performance of a bagging-based parallel hybrid time series model with various weighting methods

### Methodology:
The study utilizes diverse techniques, including base time series models, hybrid models, weighing/aggregating methods, and bagging-based approaches. Base models encompass statistical time series models (e.g., SARIMA, Exponential Smoothing) and machine learning models (e.g., Multi-Layered Perceptron Neural Network Auto Regression). Hybrid models combine decomposition techniques with statistical time series models (e.g., STL+SARIMA, STL+ETS). Performance measures, such as Root Mean Square Error (RMSE) and Relative Rate (%), are employed to assess the accuracy of forecasts.

### Software Used:
Microsoft Excel (2019) is employed for data aggregation and management, Jamovi 2.3.26 for generating tables, and R Studio 4.3.0 for advanced data analysis.

### Conclusion:
The aim of the study was to explore the various time series models, along with their hybrid structures and inspect whether bagging was helpful in improving the forecasting accuracy. Time series and machine learning models with variety of techniques are employed to the trained data of economic indicators collected from 2009 to 2022. The remaining test dataset is used to validate the performance of the models. Strengths and weakness of each models in relation to the data characteristics are observed using graphical representations and metrics 

#### The following conclusions are drawn:
•	From the measures of skewness and kurtosis we observe indicators EI2, EI3, EI8, EI9 and EI11 show notable skewness, while indicators EI5,EI7 and EI9 exhibits high excess kurtosis. 

•	The normality tests results in statistical significance which infers non- normality based on Shapiro Wilk test with p – value<0.05.

•	The time profiles of the indicators reveal non- stationarity, attributed to noticeable trends and recurring seasonal patterns. 

•	The tests for trend confirm the presence of trend in the time series data. whereas the test for seasonality suggests no seasonality in most of the economic indicators except for EI11 and EI12.

•	The ETS model outperforms others in 33.33% of cases, while SARIMA ,STL+ARIMA,NNAR and MLP models are each best in 16.67 % of cases. Observing the RR rate all the base time series models have atleast a 25 % RR rate , except for EI7 and EI11 where SARIMA doesn’t fit well for EI7 and EI11.

•	The Hybrid time series modelling techniques SM, TM and OLSE performs best in 25% of cases, while SWAM is the top model in 16.7 % of cases and WM in 8.3 % of cases.

•	In case of Hybrid time series models SWAM is the best technique for EI11 and the least effective model for EI11 but is the best for EI4.

•	Findings indicates that ETS and STL+SARIMA models are the top choices in 50% of cases while SARIMA and STL+ETS models excel in 47 % of cases
•	Bagged models of SARIMA, ETS and MLP are the best in 25% of cases.

•	Bagged hybrid models with bootstrap samples k=5 and k=20 emerge as the best models in 34% of cases. While the remaining models demonstrate the best performance in 8% of cases.

•	Overall, the study leads to conclusion that bagging leads to more accurate forecasts in 8 out of 12 cases.

•	The Bagging technique requires relatively longer time (approx. 52 min) for computation compared to the computational requirements of base of Hybrid models








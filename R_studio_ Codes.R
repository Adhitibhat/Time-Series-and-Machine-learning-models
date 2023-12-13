library(tidyverse)
library(ggplot2)
library(readxl)
library(forecast) # for prediction and accuracy measures
library(nnfor)
library(neuralnet)

library(readxl)
Data_Final1 <- read_excel("C:/Users/Admin/OneDrive/Desktop/MY MSC PROJECT/PROJECT_FILE/Data_Final1.xlsx", 
                          sheet = "Sheet1")

View(Data_Final1)
D$Time=as.Date(D$Time)
glimpse(D)



###############Splitting into train and test data #############
T1=D[1:192,] #Train data
T2=D[193:204,] # Test data


##################### base model ######################
bm=function(x,y){
  m1=auto.arima(x)
  p1=forecast(m1,12)$mean
  a1=accuracy(p1,y)
  m2=ets(x)
  p2=forecast(m2,12)$mean
  a2=accuracy(p2,y)
  m3=stlm(x,method ="arima")
  p3=forecast(m3,12)$mean
  a3=accuracy(p3,y)
  m4=stlm(x,method ="ets" )
  p4=forecast(m4,12)$mean
  a4=accuracy(p4,y)
  set.seed(46)
  m5=nnetar(x)
  p5=forecast(m5,12)$mean
  a5=accuracy(p5,y)
  set.seed(46)
  m6=mlp(x)
  p6=forecast(m6,12)$mean
  a6=accuracy(p6,y)
  P=cbind(y,p1,p2,p3,p4,p5,p6)
  colnames(P)=c("ACTUAL","SARIMA","ETS","STL+SARIMA","STL+ETS","NNAR","MLP") 
  A=rbind(a1,a2,a3,a4,a5,a6)
  rownames(A)=c("SARIMA","ETS","STL+SARIMA","STL+ETS","NNAR","MLP") 
  L=list(P,A)
  return(L)
}

##################### user defined function for hybrid model Hybrid Model######################
hm=function(m1,m2,m3,m4,m5,m6,x,y){
  #SM method
  p1=forecast(m1,12)$mean
  p2=forecast(m2,12)$mean
  p3=forecast(m3,12)$mean
  p4=forecast(m4,12)$mean
  p5=forecast(m5,12)$mean
  p6=forecast(m6,12)$mean
  P=cbind(p1,p2,p3,p4,p5,p6)
  f1=rowMeans(P) 
  ah1=accuracy(f1,y)
  #TM : 10% of the base forecasts are trimmed
  f2={}
  for(i in 1:nrow(P)){
    v=P[i,]
    v=sort(v)
    f2[i]=mean(v[2:5])
  }
  ah2=accuracy(f2,y)
  #WM : 10% of the base forecasts are trimmed  
  f3={}
  for(i in 1:nrow(P)){
    v=P[i,]
    v=sort(v)
    f3[i]=1/6*(1*v[2]+ sum(v[2:5]+1*v[5]))
  }
  ah3=accuracy(f3,y)
  #SWAM
  pt1=m1$fitted #To compute RMSE from train data
  pt2=m2$fitted
  pt3=m3$fitted
  pt4=m4$fitted
  pt5=m5$fitted
  pt6=m6$fitted
  e1=accuracy(pt1,x)[2] #2nd value gives RMSE
  e2=accuracy(pt2,x)[2]
  e3=accuracy(pt3,x)[2]
  e4=accuracy(pt4,x)[2]
  e5=accuracy(pt5,x)[2]
  e6=accuracy(pt6,x)[2]
  e=c(e1,e2,e3,e4,e5,e6)
  w=order(e)/21 # 6+5+4+3+2+1
  w=matrix(w,1,6)
  f4=w%*%t(P)
  f4=as.vector(f4)
  ah4=accuracy(f4,y)
  #OLSE method
  id=length(x)-length(m6$fitted)+1
  u=lm(x[id:192]~0+m1$fitted[id:192]+m2$fitted[id:192]+m3$fitted[id:192]+m4$fitted[id:192]+m5$fitted[id:192]+m6$fitted)
  beta=u$coefficients
  f5=beta %*% t(P)
  f5=as.vector(f5)
  ah5=accuracy(f5,y)
  #var cov method
  w1={}
  w1[1]=(sum(m1$residuals^2))^(-1)
  w1[2]=(sum(m2$residuals^2))^(-1)
  w1[3]=(sum(m3$residuals^2))^(-1)
  w1[4]=(sum(m4$residuals^2))^(-1)
  w1[5]=(sum(m5$residuals^2,na.rm = TRUE))^(-1)
  w1[6]=(sum(m6$residuals^2,na.rm = TRUE))^(-1)
  w2=w1/sum(w1)
  w2=matrix(w2,1,6)
  f6=w%*%t(P)
  f6=as.vector(f6)
  ah6=accuracy(f6,y)
  Ph=cbind(f1,f2,f3,f4,f5,f6)
  colnames(Ph)=c("SM","TM","WM","SWAM","OLS Based","Var-Cov") 
  rownames(Ph)=month.abb
  Ah=rbind(ah1,ah2,ah3,ah4,ah5,ah6)
  rownames(Ah)=c("SM","TM","WM","SWAM","OLS Based","Var-Cov") 
  L=list(Ph,Ah)
  # prediction interval to be added.
  return(L)
}
############# rough work #############
xt=ts(T1$EI1,start=c(2006,1),frequency=12)
yt=T2$EI1
set.seed(46)
Pb={};Ph={}
k=c(5,10,20,30,40,50) # 500 takes nearly two hours.

# bagged base model
start <- Sys.time()
for(i in 1:length(k)){
  bs=bld.mbb.bootstrap(xt,k[i])
  for(j in 1:k[i]){
  bs1=bs[[j]]
  b=bm(bs1,yt)
  Pb=rbind(Pb,b[[1]])
}
}
print( Sys.time() - start ) # to record time

Pb=data.frame(Pb)
r1=rep(k,k*12)
Pb$index=r1
Pb$m=rep(1:12,155)
write.csv(Pb,"EI1b.csv")

# bagged hybrid model
for(i in 1:length(k)){
  bs=bld.mbb.bootstrap(xt,k[i])
  for(j in 1:k[i]){
    bs1=bs[[j]]
    m1=auto.arima(bs1) # for hybrid model input
    m2=ets(bs1)
    m3=stlm(bs1,method ="arima")
    m4=stlm(bs1,method ="ets" )
    m5=nnetar(bs1)
    m6=mlp(bs1)
    h=hm(m1,m2,m3,m4,m5,m6,bs1,yt)
    Ph=rbind(Ph,h[[1]])
  }
}
Ph=data.frame(Ph)
r1=rep(k,each=12)
Ph$index=r1
write.csv(Ph,"EI1h.csv")


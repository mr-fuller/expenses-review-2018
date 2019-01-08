library(tidyverse)
library(lubridate)
transactions <- read.csv("C:/Users/fullerm/OneDrive/Documents/Finances/transactions.csv")
#clean up the dates
transactions$Date <- as.Date.character(transactions$Date,format = "%m/%d/%Y")
View(transactions)
#change or ignore credit/debit, credit = income, debit = expense



#what is my income for each year?
sum(transactions[transactions$Transaction.Type == 'credit' & 
                   transactions$Date >"2018-12-31" &
                   transactions$Category == 'Income',
                 "Amount"])
aggregate(transactions$Amount,by = list(Year = year(transactions$Date),
                                        Type = transactions$Transaction.Type),
          
          FUN=sum)
#show each category by type by year
df <- aggregate(Amount ~ year(Date) + Transaction.Type + Category, 
          data = transactions[transactions$Category != 'Credit Card Payment',],
          FUN = sum)
spread(df,"year(Date)",Amount)

#show spending by category for 2018
aggregate(Amount~Category,
          data = transactions[transactions$Date > "2017-12-31" & 
                                transactions$Date <"2019-01-01" &
                                transactions$Transaction.Type == "debit",],
          FUN = sum)
rowsum(transactions[c("Amount","Transaction.Type")],format(transactions$Date,"%Y"))
#& transactions$Category != 'Credit Card Payment',"Amount"])


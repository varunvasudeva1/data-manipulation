library(tidyverse)
data(diamonds)

diamonds <- diamonds %>% 
  mutate(clarityOrdered = ordered(ifelse((clarity == "SI1" | clarity == "SI2"), "SI", 
                                         ifelse(clarity == "VS1" | clarity == "VS2", "VS", 
                                                ifelse(clarity == "VVS1" | clarity == "VVS2", "VVS", as.character(clarity)))), 
                                  levels = c("I1", "SI", "VS", "VVS", "IF")))

head(diamonds)

SIdiamonds <- filter(diamonds, clarityOrdered == "SI")
meanCaratSI = mean(SIdiamonds$carat)

VSdiamonds <- filter(diamonds, clarityOrdered == "VS")
meanCaratVS = mean(VSdiamonds$carat)

VVSdiamonds <- filter(diamonds, clarityOrdered == "VVS")
meanCaratVVS = mean(VVSdiamonds$carat)

I1diamonds <- filter(diamonds, clarityOrdered == "I1")
meanCaratI1 = mean(I1diamonds$carat)

IFdiamonds <- filter(diamonds, clarityOrdered == "IF")
meanCaratIF = mean(IFdiamonds$carat)

means <- data.frame(Type = c("SI", "VS", "VVS", "I1", "IF"), Mean = c(meanCaratSI, meanCaratVS, meanCaratVVS, meanCaratI1, meanCaratIF))
means
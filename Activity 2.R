# install packages
#install.packages(c("dplyr", "lubridate"))

library(dplyr)
library(lubridate)

### Tutorial 2 ###

#Reading data
streamH <- read.csv("/cloud/project/activtiy02/stream_gauge.csv")
siteInfo <- read.csv("/cloud/project/activtiy02/site_info.csv")

siteInfo$names

#parsing date/time

exampleDate <- c("2021-01-10 05:23:30")
ymd_hms(exampleDate)

ymd_hms(exampleDate, tz="America/New_York")

ymd_hms(exampleDate, tz="EST")

streamH$dateF <- ymd_hm(streamH$datetime, tz="America/New_York")

# Extracting information from dates

year(streamH$dateF )

leap_year(streamH$dateF )

yday(streamH$dateF )

decimal_date(streamH$dateF )

# Basic Subsetting
peaceH <- streamH[streamH$siteID == 2295637, ]

# Basic Plotting
plot(peaceH$dateF, peaceH$gheight.ft, type="b", pch=19, xlab="Date",
     ylab = "Stage height (ft)")

# Joining data tables
str(streamH)

siteInfo

floods <- full_join(streamH,
                    siteInfo,
                    by="siteID")

# Aggregating data & chaining functions

mean(floods$gheight.ft)

height.ave <- floods %>% 
  group_by(names) %>% 
  summarise(mean.height = mean(gheight.ft)) 

height.day <- floods %>% 
  group_by(names, doy) %>% 
  summarise(mean.height = mean(gheight.ft), max.height = max(gheight.ft))


floods$doy = yday(streamH$dateF )


# Filtering Data

max.cat <- floods %>% 
  group_by(names) %>% 
  filter(gheight.ft >= major.ft)

max.cat <- floods %>%
  group_by(names) %>%
  filter(gheight.ft >= major.ft) %>%
  summarise(n.major = n())


### In-class Prompts ###

#Prompt 1
floods <- full_join(streamH,
                    siteInfo,
                    by="siteID")

#Prompt 2

streamH$dateF <- ymd_hm(streamH$datetime, tz="America/New_York")

#Prompt 3

earlier <- floods %>%
  group_by(names) %>%
  filter(gheight.ft >= flood.ft) %>%
  summarise(min.date = min(dateF))
  
### Group 1 ###

VariableA <- select(floods, names, gheight.ft,datetime)

VariableB <- select(floods, gheight.ft:dateF)

VariableC <- select(floods, -datetime, -siteID)

VariableE <- select(floods, contains("e"), -agency)

VariableF <- select(floods,(!(gheight.ft:dateF)))

### Homework Part 1 ###

Santa.Fe.River <- floods[4266:6473, ]

Fisheating <- floods[1:2208, ]

hist(Fisheating$gheight.ft,
     main = "Fisheating Creek",
     xlab = "Height (ft)",
     col = "tomato2",
     border = "black")

help(hist)

### Group 2 ###

Floods_Mutated <- mutate(floods,
                         stage_meters = gheight.ft * 0.3048,
                         percent_flood = (gheight.ft / major.ft) * 100)

floods_dont_keep <- mutuate(floods, .keep = c("unused"),
                            stage_meters = h)

floods_before <- floods %>% mutate(.before = gheight.ft,
                                   stage_meters = gheight.ft)

floods_removed <- mutate(floods, perecent_floods = (gheight.ft / major.ft) *100,
                         gheight.ft = NULL)

### Group 3 ###

floods$RiverLocation <- ifelse(floods$names == 
                                 "SANTA FE RIVER NEAR FORT WHITE",
                               "Northeren Florida", "Central Florida")

floods$RiverLocationNA <- ifelse(floods$names == "SANTA FE RIVER NEAR FORT WHITE", NA,
                                 "Not Missing")

floods$test <- ifelse(is.na(floods$gheight.ft), 1,0)






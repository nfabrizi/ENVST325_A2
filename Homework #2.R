### Homework 2 ###

# Question 1

Peaceriver <- floods[2209:4265, ]
Withlacoochee <- floods[6474:8681, ]

plot(Fisheating$dateF, Fisheating$gheight.ft,
     main = "Fisheating Creek",
     ylab = "Height (ft)",
     xlab = "Date",
     col = "tomato2")

plot(Santa.Fe.River$dateF, Santa.Fe.River$gheight.ft,
     main = "Santa Fe River",
     ylab = "Height (ft)",
     xlab = "Date",
     col = "blue")

plot(Peaceriver$dateF, Peaceriver$gheight.ft,
     main = "Peace River",
     ylab = "Height (ft)",
     xlab = "Date",
     col = "green")

plot(Withlacoochee$dateF, Withlacoochee$gheight.ft,
     main = "Withlacoochee River",
     ylab = "Height (ft)",
     xlab = "Date",
     col = "orange")

# Question 2 #

Earlier <- floods %>%
  group_by(names) %>%
  filter(gheight.ft >= flood.ft) %>%
  summarise(min.date = min(dateF))

Moderate <- floods %>%
  group_by(names) %>%
  filter(gheight.ft >= moderate.ft) %>%
  summarise(min.date = min(dateF))

Major <- floods %>%
  group_by(names) %>%
  filter(gheight.ft >= major.ft) %>%
  summarise(min.date = min(dateF))

# Question 3 

Worst <- floods %>%
  group_by(names) %>%
  filter(gheight.ft >= major.ft) %>%
  summarise(min.date = min(dateF), 
            flood.level = mean(major.ft),
            maxheight = max(gheight.ft))










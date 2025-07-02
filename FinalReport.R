#Final Report MA4720 Script
#Author: Cody Rorick
setwd("/Users/crorick/Documents/MS Applied Stats Fall 2023/MA4720/scripts")
library(car)
library(Hmisc)
library(lsmeans)
#DATA Cleaning
#Read Spotify data in and filter it down to what we are interested in
spotify <- read.csv('spotify-2023.csv')
spotify <- spotify[c("bpm", "key", "streams")]
spotify$bpm <- as.double(spotify$bpm)
spotify$streams <- as.double(spotify$streams)
spotify <- na.omit(spotify)
spotify <- spotify[spotify$key != '',]
spotify$bpm2 <- cut2(spotify$bpm, g=5)
#Exploratory Analysis
interaction.plot(
    x.factor = spotify$key,
    trace.factor = spotify$bpm2,
    response = spotify$streams,
    fun = mean,
    ylab = "Total Spotify Streams",
    xlab = "Musical Key",
    trace.label = "Beats Per Minute",
    col = c("Blue", "Red", "Black", "Green", "Orange"),
    lwd = 2
)
boxplot(spotify$streams ~ spotify$bpm2 + spotify$key, xlab = 'Treatment Combinations', ylab = 'Total Spotify Streams')
#MODEL ANALYSIS
#fitting model
spotify.aov <- aov(spotify$streams ~ spotify$bpm2 + spotify$key + spotify$bpm2:spotify$key)
options(contrasts = c("contr.sum", "contr.poly"))
drop1(object = spotify.aov, scope = ~., test = "F")
#Analyzing residual plots for normality and equivalency of variance
spotify.z <- resid(spotify.aov)/sd(resid(spotify.aov))
spotify.p <- fitted(spotify.aov)
plot(spotify.z ~ spotify.p, xlab = "Predicted Values", ylab = "Standardized Residuals", main = "Residual Plot")
qqnorm(spotify.z)
qqline(spotify.z)
#Setting up contrasts for the significant effects of BPM
spotify.lsmeans <- lsmeans(object = spotify.aov, ~ bpm2)
summary(contrast(object = spotify.lsmeans, method = 'pairwise', adjust = "tukey"), level = 0.95, infer = c(T, T))



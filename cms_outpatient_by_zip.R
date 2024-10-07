library(ggplot2)
library(dplyr)
library(sf)
library(usmap)
library(plotly)

cms_by_state <- read.csv("cms_by_state.csv", header=TRUE)

colnames(cms_by_state)[colnames(cms_by_state) == "provider_state"] <- "state"
cms_by_state <- cms_by_state[order(cms_by_state$state),]

cms_usa_plot <- plot_usmap(data=cms_by_state,values="AVG_OUTPATIENT", labels=TRUE) +
  scale_fill_continuous(name = "Average Expense ($)", label = scales::comma) +
  ggtitle("Average outpatient expense by state")

ggplotly(cms_usa_plot)


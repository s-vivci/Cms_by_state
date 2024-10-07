# Cms_by_state
Simple R Project to take BigQuery public data about CMS (Centers for Medicaid &amp; Medicare Service) outpatient expenses per state in the USA.

## Data Used
This project uses BigQuery public Medicare data for Outpatient Treatment Costs.

From the google cloud website:
"This public dataset was created by the Centers for Medicare & Medicaid Services. The data summarizes the utilization and payments for procedures, services, and prescription drugs provided to Medicare beneficiaries by specific inpatient and outpatient hospitals, physicians, and other suppliers. The dataset includes the following data - common inpatient and outpatient services, all physician and other supplier procedures and services, and all Part D prescriptions."

https://console.cloud.google.com/marketplace/product/hhs/medicare?inv=1&invt=AbeJZQ&project=sample-project-1-433803

## Google Bigquery
Data is first queried within google bigquery using SQL. The new data containing state and average outpatient treatment costs are stored in a new table. This data is then downloaded as csv.

```
CREATE OR REPLACE TABLE `sample-project-1-433803.vivek_cms_data.cms_by_zip` AS
SELECT provider_state, avg(outpatient_services) as AVG_OUTPATIENT 
FROM `bigquery-public-data.cms_medicare.outpatient_charges_2015`
GROUP BY provider_state
```
## RStudio

The csv file is read into R, and the state column name is changed for use in plot_usmap function.

Then, using the packages 'ggplot2', 'usmap', and 'plotly' in R, the data is plotted to a map of the USA, with interactive feature added by plotly.

```
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

```
![newplot](https://github.com/user-attachments/assets/77b794ee-dd67-4465-a40f-db77d5c6f52a)

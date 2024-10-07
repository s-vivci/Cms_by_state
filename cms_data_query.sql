CREATE OR REPLACE TABLE `sample-project-1-433803.vivek_cms_data.cms_by_zip` AS
SELECT provider_state, avg(outpatient_services) as AVG_OUTPATIENT 
FROM `bigquery-public-data.cms_medicare.outpatient_charges_2015`
GROUP BY provider_state
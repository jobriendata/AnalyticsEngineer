/********************************************************************
What were the: number of events,  unique sessions,  
unique users (i.e., full visitors) that occurred in each hour? 
By “hour” let's assume we mean the hour in which the event occurred.
*********************************************************************/
SELECT COUNT(EVENT) AS Number_of_Events
	,COUNT(DISTINCT (SESSION)) AS Unique_Sessions
	,COUNT(DISTINCT (fullVisitorId)) AS Unique_Users
	,hour
FROM (
	SELECT PARSE_DATE("%Y%m%d", ga.DATE) AS DATE
		,ga.fullVisitorId
		,ga.visitstarttime
		,CONCAT (
			fullvisitorid
			,cast(visitstarttime AS string)
			) AS session
		,hits.hitNumber AS event
		,hits.hour
		,ga.DATE
	FROM `bigquery - PUBLIC - data.google_analytics_sample.ga_sessions_20170801` ga
		,unnest(ga.hits) AS hits
	)
GROUP BY hour
ORDER BY hour

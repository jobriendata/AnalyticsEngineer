/*******************************************************************************************
 Building a dataset that  predicts if a session will ultimately end up with an abandoned cart or a successful purchase.

Additional columns added to the dataset include Event Action, the user_type to determine if it's a new or existing user,
and the various date periods to show trending by Year, Month or Day.

*********************************************************************************************/
SELECT Purchases
	,count(session) AS Sessions
	,eventAction
	,DATE
	,user_type
	,FORMAT_DATE('%Y', DATE) AS year
	,FORMAT_DATE('%m', DATE) AS month
	,FORMAT_DATE('%B', DATE) AS month_name
FROM (
	SELECT PARSE_DATE("%Y%m%d", ga.DATE) AS DATE
		,ga.fullVisitorId
		,ga.visitstarttime
		,CONCAT (
			fullvisitorid
			,cast(visitstarttime AS string)
			) AS session
		,CASE 
			WHEN totals.newvisits = 1
				THEN 'New visitor'
			ELSE 'Returning visitor'
			END AS user_type
		,hits.hitNumber AS event
		,hits.type
		,hits.eventInfo.eventAction
		,CASE 
			WHEN totals.transactions > 0
				THEN 'Had a Purchase'
			ELSE 'No Purchase'
			END AS Purchases
	FROM `bigquery - PUBLIC - data.google_analytics_sample.ga_sessions_ * ` AS ga
		,unnest(ga.hits) AS hits
	WHERE hits.eventInfo.eventAction IS NOT NULL
		AND totals.visits = 1
	)
GROUP BY Purchases
	,DATE
	,eventAction
	,user_type

/********************************************************************
What were the top product categories by Event Action per Unique Users

--Did not limit the result set to be just the top categories by eventAction.  The limitation can 
be set at the visualization layer and allow for flexibility in how "the top" is defined. 

*********************************************************************/
SELECT COUNT(DISTINCT (fullVisitorId)) AS unique_users
	,eventAction
	,v2ProductCategory
FROM (
	SELECT PARSE_DATE("%Y%m%d", ga.DATE) AS DATE
		,ga.fullVisitorId
		,ga.visitstarttime
		,CONCAT (
			fullvisitorid
			,cast(visitstarttime AS string)
			) AS session
		,hits.hitNumber AS event
		,product.v2ProductCategory
		,hits.type
		,hits.eventInfo.eventAction
	FROM `bigquery - PUBLIC - data.google_analytics_sample.ga_sessions_20170801` ga
		,unnest(ga.hits) AS hits
		,unnest(hits.product) AS product
	WHERE hits.type = 'EVENT'
		AND hits.eventInfo.eventAction IN (
			'Quickview Click'
			,'Product Click'
			,'Promotion Click'
			)
	)
GROUP BY v2ProductCategory
	,eventAction
ORDER BY eventAction
	,unique_users DESC

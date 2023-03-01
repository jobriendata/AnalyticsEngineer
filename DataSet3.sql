/**********************************************************************************************************
Let's suppose that we ultimately want to build a model that predicts if a session that contains an “Add to Cart” action/event
will be abandoned or conclude in a successful purchase. Again, we want to use hits.eventInfo.eventAction to find “Add to Cart” actions. 
Assuming that a session with least one transaction (indicated by totals.transactions > 0) means the session had a purchase, 
write a query that summarizes the number of sessions with cart additions broken out by those with and without purchases.

--Did not take into account if we should look at New or Returning Users
**********************************************************************************************************/
SELECT Purchases
	,count(session) AS Sessions
	,eventAction
	,DATE
FROM (
	SELECT PARSE_DATE("%Y%m%d", ga.DATE) AS DATE
		,ga.fullVisitorId
		,ga.visitstarttime
		,CONCAT (
			fullvisitorid
			,cast(visitstarttime AS string)
			) AS session
		,hits.hitNumber AS event
		,hits.type
		,hits.eventInfo.eventAction
		,CASE 
			WHEN totals.transactions > 0
				THEN 'Had a Purchase'
			ELSE 'No Purchase'
			END AS Purchases
	FROM `bigquery - PUBLIC - data.google_analytics_sample.ga_sessions_20170801` ga
		,unnest(ga.hits) AS hits
	WHERE hits.eventInfo.eventAction = 'Add to Cart'
	)
GROUP BY Purchases
	,DATE
	,eventAction

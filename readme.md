# Splice

## Data Set
For this assessment, we are using Google Analytics sample data set - `bigquery-public-data.google_analytics_sample.ga_sessions_20170801` 

## Files
This repo contains four sql files for each of the problem statements.

### Problem Statement 1
What were the number of events, unique sessions, and unique users (i.e., full visitors) that occurred in each hour? By “hour” let's assume we mean the hour in which the event occurred.

File - DataSet1.sql contains the query to solve this statement.  Since we our data set is for one day, I did not include the date in the output. 

### Problem Statement 2
Each event or hit may be associated with nested product-related fields, found in hits.product. Let's suppose we want to know the top product categories (indicated by product.v2ProductCategory) with respect to the total number of unique users who either performed a “Quickview Click”, “Product Click”, or “Promotion Click” action (as indicated by hits.eventInfo.eventAction). We also want to make sure we're analyzing true user-actions (see hits.type) and not page views.

File - DataSet2.sql contains the query to solve this statement.

### Problem Statement 3
Let's suppose that we ultimately want to build a model that predicts if a session that contains an “Add to Cart” action/event will be abandoned or conclude in a successful purchase. Again, we want to use hits.eventInfo.eventAction to find “Add to Cart” actions. Assuming that a session with least one transaction (indicated by totals.transactions > 0) means the session had a purchase, write a query that summarizes the number of sessions with cart additions broken out by those with and without purchases.

File - DataSet3.sql contains the query to solve this statement. 

### Problem Statement 4
Now, knowing how to determine sessions with purchases vs. sessions with abandoned carts, let's wrap this up by building a data set that we think contains useful features for a model that predicts if a session will ultimately end up with an abandoned cart or a successful purchase. In this case, feel free to explore the data and add any data you think might be meaningful. You should expand your final data set to pull from bigquery-public-data.google_analytics_sample.ga_sessions*, giving you more data to work with. Please provide a brief write up of the additional columns/features you've chosen and why you think they matter.

File - DataSet4.sql contains the query to solve this statement. Additional columns added to the dataset include Event Action, the user_type to determine if it's a new or existing user,and the various date periods to show trending by Year, Month or Day.

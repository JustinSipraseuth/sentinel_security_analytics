
SELECT u.user_id
FROM users AS u
LEFT JOIN authentication_events AS ae
	ON u.user_id = ae.user_id
WHERE ae.user_id IS NULL;

SELECT *
FROM authentication_events;

SELECT u.user_id
FROM users AS u
LEFT JOIN authentication_events AS ae
	ON u.user_id = ae.user_id
WHERE ae.user_id IS NULL;

--For Excel Analysis, get all authentication_events, along with organizationIDs with it.
SELECT
    event_id,
    event_timestamp::DATE AS event_date,
    ae.user_id,
    device_id,
	o.organization_id,
    ip_address,
    application_name,
    authentication_method,
    authentication_result
FROM authentication_events AS ae
LEFT JOIN users AS u
	ON u.user_id = ae.user_id
LEFT JOIN organizations AS o
	ON u.organization_id = o.organization_id
;
FROM authentication_events
ORDER BY user_id;

--Integrity is maintained for organizations<-->user. No null organization_id returned, meaning all orgs in users are in organizations.
SELECT u.organization_id
FROM users AS u
LEFT JOIN organizations AS o
	ON u.organization_id = o.organization_id
WHERE o.organization_id IS NULL;

--Integrity is maintained for user<-->authentication_events. No null user_id returned, meaning all users in ae are in users.
SELECT u.user_id
FROM authentication_events AS ae
LEFT JOIN users AS u
	ON u.user_id = ae.user_id
WHERE u.user_id IS NULL;

WITH AuthResultsPerOrg AS
(
	--Counts successes for AuthResults (Days)
	SELECT o.organization_id, CAST(event_timestamp AS DATE) AS DayOfEvent, COUNT(authentication_result) AS NumOfAuthResults,
		SUM(CASE 
			WHEN authentication_result = 'Success' THEN 1
			ELSE 0
		END) AS NumOfAuthSuccesses
	FROM authentication_events AS ae
	INNER JOIN users AS u
		ON u.user_id = ae.user_id
	INNER JOIN organizations AS o
		ON u.organization_id = o.organization_id
	GROUP BY o.organization_id, CAST(event_timestamp AS DATE)
	ORDER BY organization_ID, DayOfEvent ASC
)
SELECT organization_id, DayOfEvent, NumOfAuthResults, NumOfAuthSuccesses, 
	NumOfAuthResults - NumOfAuthSuccesses AS NumOfFailures, 
	(NumOfAuthResults+0.0 - NumOfAuthSuccesses)/NumOfAuthResults*100 AS FailureRate
FROM AuthResultsPerOrg;

WITH AuthResultsPerOrg AS
(
	--Counts successes for AuthResults (Weeks)
	SELECT o.organization_id, EXTRACT(WEEK FROM event_timestamp) AS WeekOfEvent, COUNT(authentication_result) AS NumOfAuthResults,
		SUM(CASE 
			WHEN authentication_result = 'Success' THEN 1
			ELSE 0
		END) AS NumOfAuthSuccesses
	FROM authentication_events AS ae
	INNER JOIN users AS u
		ON u.user_id = ae.user_id
	INNER JOIN organizations AS o
		ON u.organization_id = o.organization_id
	GROUP BY o.organization_id, EXTRACT(WEEK FROM event_timestamp)
	ORDER BY organization_ID, WeekOfEvent ASC
)
SELECT organization_id, WeekOfEvent, NumOfAuthResults, NumOfAuthSuccesses, 
	NumOfAuthResults - NumOfAuthSuccesses AS NumOfFailures, 
	(NumOfAuthResults+0.0 - NumOfAuthSuccesses)/NumOfAuthResults*100 AS FailureRate
FROM AuthResultsPerOrg;

WITH AuthResultsPerOrg AS
(
	--Counts successes for AuthResults (Daily--For Organization 2 Week 33; 17% Failure Anamoly)
	SELECT o.organization_id, CAST(event_timestamp AS DATE) AS DayOfEvent, COUNT(authentication_result) AS NumOfAuthResults,
		SUM(CASE 
			WHEN authentication_result = 'Success' THEN 1
			ELSE 0
		END) AS NumOfAuthSuccesses
	FROM authentication_events AS ae
	INNER JOIN users AS u
		ON u.user_id = ae.user_id
	INNER JOIN organizations AS o
		ON u.organization_id = o.organization_id
	GROUP BY o.organization_id, CAST(event_timestamp AS DATE)
	ORDER BY organization_ID, DayOfEvent ASC
)
SELECT organization_id, DayOfEvent, NumOfAuthResults, NumOfAuthSuccesses, 
	NumOfAuthResults - NumOfAuthSuccesses AS NumOfFailures, 
	(NumOfAuthResults+0.0 - NumOfAuthSuccesses)/NumOfAuthResults*100 AS FailureRate
FROM AuthResultsPerOrg
WHERE DayOfEvent >= (to_date('2026-33', 'IYYY-IW') - interval '3 days')
  AND DayOfEvent <= (to_date('2026-33', 'IYYY-IW') + interval '9 days')
  AND organization_ID = 2;

--Investigating Org 2 Day 8-13 further because it has 48.71% failure rate.
SELECT ae.*, o.organization_id
FROM authentication_events AS ae
	INNER JOIN users AS u
		ON u.user_id = ae.user_id
	INNER JOIN organizations AS o
		ON u.organization_id = o.organization_id
WHERE o.organization_id = 2
  AND CAST(event_timestamp AS DATE) = '2026-08-13';

/*203.0.113.250 is the IP address that looked sketchy.
Before you escalate, I want you to quantify the cluster cleanly. Give me:
total attempts from that IP during the burst :: 54 attempts during the burst in organization 2
number of distinct users targeted :: 14 in the burst
start and end time :: 8/13 19:15:22 - 8/13 19:33:59
whether any attempt from that IP succeeded :: Yes, in multiple places. In fact, there was only one other failure besides the burst.
and whether that IP appears elsewhere in the dataset outside this burst. :: Yes, multiple places. It appears in several other organizations a few times with seemingly normal activity.*/
SELECT COUNT (DISTINCT(ae.user_id))
FROM authentication_events AS ae
	INNER JOIN users AS u
		ON u.user_id = ae.user_id
	INNER JOIN organizations AS o
		ON u.organization_id = o.organization_id
WHERE ip_address = '203.0.113.250' AND o.organization_id = 2 AND authentication_result = 'Invalid Password'
;--ORDER BY event_timestamp ASC;


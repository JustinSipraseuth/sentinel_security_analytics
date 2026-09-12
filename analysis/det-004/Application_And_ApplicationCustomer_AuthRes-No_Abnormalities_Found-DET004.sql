--Investigating failure rate of applications. There are 398 null applications.
--Note that there are no null authentication results, so COUNT is applicable for total results.
/*All failure rates for each application seem to be from 7-<10%,
	with only VPN Portal being higher than this range with 11.68% failure rate.*/
--A 'Failure' is defined as a result that is NOT a success.
WITH AuthenticationResultTotalsPerApplication AS
(
	SELECT application_name, COUNT(authentication_result) AS TotalAuthenticationResults,
		SUM( 
			CASE
				WHEN authentication_result != 'Success' THEN 1
			END
		   ) AS TotalFailures
	FROM authentication_events
	GROUP BY application_name
)
SELECT application_name, TotalAuthenticationResults, TotalFailures, 
	(TotalFailures+0.0)/TotalAuthenticationResults*100 AS FailureRateOfAuthentications
FROM AuthenticationResultTotalsPerApplication;

/*Investigating failure rate of organization-application. 
	As with the previous query, failure rates are about the same, being roughly 5-11%. 
	The only organization-application with an abnormal failure rate 
		is the one with the VPN Portal rapid invalid password.
	Taking that number out, their failure rate falls within that 5-11%.*/
WITH AuthenticationResultTotalsPerApplication AS
(
	SELECT organization_name, application_name, COUNT(authentication_result) AS TotalAuthenticationResults,
		SUM( 
			CASE
				WHEN authentication_result != 'Success' THEN 1
			END
		   ) AS TotalFailures
	FROM authentication_events AS ae
	LEFT JOIN users AS u
		ON ae.user_id = u.user_id
	LEFT JOIN organizations AS o
		ON u.organization_id = o.organization_id
	GROUP BY application_name, organization_name
)
SELECT organization_name, application_name, TotalAuthenticationResults, TotalFailures, 
	(TotalFailures+0.0)/TotalAuthenticationResults*100 AS FailureRateOfAuthentications
FROM AuthenticationResultTotalsPerApplication
ORDER BY FailureRateOfAuthentications;


--Returns 0, so there are NO null authentication_method in this dataset.
SELECT COUNT(*) - COUNT(authentication_method) AS Authentication_Method_NullCount
FROM authentication_events;

--Returns 0, so there are NO null authentication_result in this dataset.
SELECT COUNT(*) - COUNT(authentication_result) AS Authentication_Result_NullCount
FROM authentication_events;

--Aggregate failure rates are all roughly between 8-9%, with MIN being 8.26% and MAX being 9.51%
--From this kind of data grain alone, no single method needs an investigation
--NOTE: There 
WITH AuthenticationResultTotalsPerApplication AS
(
	SELECT authentication_method, COUNT(authentication_result) AS TotalAuthenticationResults,
		SUM( 
			CASE
				WHEN authentication_result != 'Success' THEN 1
			END
		   ) AS TotalFailures
	FROM authentication_events
	GROUP BY authentication_method
)
SELECT authentication_method, TotalAuthenticationResults, TotalFailures, 
	(TotalFailures+0.0)/TotalAuthenticationResults*100 AS FailureRateOfAuthentications
FROM AuthenticationResultTotalsPerApplication
ORDER BY FailureRateOfAuthentications;

--Limitations:
--This only implies that authentication_method does not have any meaningful differences for failure rate.
# DET-004

## Question
Which applications, if any, appear to have abnormal authentication friction, and is that friction widespread across customers or concentrated somewhere specific?

## Important definitions / assumptions
Application: Application used for that authentication.

Assumptions:
- A failure is counted as NOT success.
- A failure rate is total failures divided by total authentication results.
- Authentication results are all NON-NULL, so counting all of them counts the total rows.

## Investigation
First investigated aggregate applications' authentication results.

### Application Testing
Why: Application abnormalities for authentications was requested.
Result: All failure rates for each application seem to be from 7-<10%,
	with only VPN Portal being higher than this range with 11.68% failure rate.
What I think it means: No abnormalities spotted. VPN portal had a burst, hence the higher than average failure rate.
Next: Change the grain to become Application-Customer based to see if any customers have had trouble with any specific applications

### Application-Customer Testing
Why: No abnormalities spotted with applications themselves, so its possible that customers may hve trouble with certain applications.
Result: All failure rates were about 5-11%.
What I think it means: Nothing out of the ordinary.
Next: This concludes the findings.

## Conclusion
No abnormal health at the aggregate application or customer-application level.

## Caveats
I can't claim that there everything is normal, as I only checked aggregate application and application-customer data, as well as I do not have the domain knowledge to continue this investigation, so I cannot say I have checked everything either.

## Recommendation
This investigation should reopen if any applications dseem abnormal by the SOC or if customers start noticing high friction.
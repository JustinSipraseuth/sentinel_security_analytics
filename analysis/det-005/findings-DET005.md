# DET-005

## Question
Is authentication method a useful way to explain differences in authentication outcomes across the Release 1 dataset?
Do any methods show materially different failure behavior, or are the differences too small to support a meaningful conclusion?

## Important definitions / assumptions
Method: The method used for that authentication (e.g., SSO, Password, MFA)

Assumptions:
- A failure is counted as NOT success.
- A failure rate is total failures divided by total authentication results.
- Authentication results are all NON-NULL, so counting all of them counts the total rows.
- Authentication methods are all NON-null.

## Investigation
Investigated authentication results per authentication method

### Method Testing
Why: Authentication Results Grouped By Authentication Method was requested to compare to one another.
Result: Aggregate failure rates are all roughly between 8-9%, with MIN being 8.26% and MAX being 9.51%
What I think it means: No abnormalities spotted.
Next: This concludes the testing.

## Conclusion
No, aggregate authentication method is not a useful way to explain differences in authentication failure amounts. No methods show anything materially different in failure behavior, as the differences are too small to support a small conclusion, with the range of failure rates being only 1.25% wide.

## Limitations
This investigation only implies that authentication_method does not have any meaningful differences for failure rate.

## Recommendation
This investigation should reopen if any methods seem abnormal by the SOC or if customers start noticing high friction.
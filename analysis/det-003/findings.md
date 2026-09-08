I found a noticeable spike in failures for organization 2 in week 33. So, I dug deeper into a daily analysis of week 33 and found that 8/13 had a huge spike in failures above 40%, with the average being near or at 10%.

Investigating 8/13 saw an IP address (203.0.113.250) with 54 failed attempts at an invalid password spread across 14 different users. However, this is not the only location of this IP.

Looking at the whole dataset (authentication_events), this IP appears in other organizations at different times, indicating that 203.0.113.250 isn't associated with just organization 2.

This matters because an abnormal pattern could indicate an unhealthy organization if it recurs. However, this multi-user invalid password burst did not occur more than once.

I recommend monitoring organization 2 for this pattern of many failed logins for several users in a short window with one source, and escalating this to Carlos (SOC Manager).
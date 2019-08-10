# Level 1 - Trivial Challenges

## Challenges

| Challenge | Description | Status |
| --- | --- | --- |
| Confidential Document | Access a confidential document. | 
| Error Handling | Provoke an error that is not very gracefully handled. | 
| Privacy Policy Tier 1 | Read our privacy policy. | :white_check_mark:
| Redirects Tier 1 | Let us redirect you to one of our crypto currency addresses which are not promoted any longer. | 
| Repetitive Registration | Follow the DRY principle while registering a user. | 
| Score Board | Find the carefully hidden 'Score Board' page. | :white_check_mark:
| XSS Tier 0 | Perform a reflected XSS attack with an iframe alerting XSS. | 
| XSS Tier 1 | Perform a DOM XSS attack with an iframe alerting XSS. | 
| Zero Stars | Give a devastating zero-star feedback to the store. | 

## Confidential Document
> Access a confidential document.

## Error Handling
> Provoke an error that is not very gracefully handled.

## Privacy Policy Tier 1
> Read our privacy policy.

This one was funny. I stumbled upon it just clicking on links, looking if I could find the scoreboard somewhere in the pages. ( )

<img src="images/1-privacy-solved.png">

## Redirects Tier 1
> Let us redirect you to one of our crypto currency addresses which are not promoted any longer.

## Repetitive Registration
> Follow the DRY principle while registering a user.


## Score Board
> Find the carefully hidden 'Score Board' page.

Not so carefully hidden when the application calls an endpoint to populate settings, and the scoreboard is in the settings.

<img src="images/1-scoreboard-network-tab.png">

You could also basically just try a bunch of score-board variations and probably get it eventually. Either way, solved!

<img src="images/1-scoreboard-solved.png">

## XSS Tier 0
> Perform a reflected XSS attack with an iframe alerting XSS.

## XSS Tier 1
> Perform a DOM XSS attack with an iframe alerting XSS.

## Zero Stars
>  Give a devastating zero-star feedback to the store.


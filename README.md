# heroku-database-backup-info-collector

Collects database URLs of an Heroku app to an AWS SQS queue.

# Installation

1. Run

    `heroku labs:enable runtime-dyno-metadata`

2. Add to Heroku Scheduler:

    `curl https://raw.githubusercontent.com/frc/heroku-database-backup-info-collector/v1.0/collect.sh|bash -s -- <region> <sqs_url> <days>`

where
* `<region>` is the AWS region for an SQS queue, like `eu-central-1`
* `<sqs_url>` is the SQS queue URL, like `https://sqs.eu-central-1.amazonaws.com/123/queuename`
* `<days>` is the number(s) of weekday(s) you want the script to send the message. `1`=Monday, `2`=Tue, `3`=Wed, `4`=Thu, `5`=Fri, `6`=Sat, `7`=Sun. `123`=Monday+Tuesday+Wednesday, `67`=Saturday and Sunday.

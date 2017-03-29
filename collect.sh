#!/bin/bash
SQS_REGION=$1
SQS_QUEUE_URL=$2

AWS_CLI_URL="https://s3.amazonaws.com/aws-cli/awscli-bundle.zip"
AWS_CLI_INSTALL_DIR="/app/vendor/awscli"
curl --progress-bar -o /tmp/awscli-bundle.zip $AWS_CLI_URL

unzip -qq -d "/tmp" /tmp/awscli-bundle.zip

cd /tmp
chmod +x /tmp/awscli-bundle/install
/tmp/awscli-bundle/install -i $AWS_CLI_INSTALL_DIR
chmod u+x $AWS_CLI_INSTALL_DIR/bin/aws
rm -rf /tmp/awscli-bundle/

while IFS='=' read -r name value ; do
  if [[ $name == *'_DATABASE_URL'* || $name == *'JAWSDB_URL' ]]; then
    $AWS_CLI_INSTALL_DIR/bin/aws sqs send-message --region $SQS_REGION --queue-url $SQS_QUEUE_URL --message-body "{\"type\": \"database\", \"app\": \"$HEROKU_APP_NAME\", \"db\": \"$name\", \"url\": \"${!name}\"}"
  fi
done < <(env)

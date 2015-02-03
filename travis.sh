#!/bin/bash

# travis - executes command for performing lifecycle of travis build

##### Constants

OWNER_NAME=`dirname $TRAVIS_REPO_SLUG`
SSH="ssh -i access_key -o StrictHostKeyChecking=no"

##### Functions

function install
{
    bundle install --path vendor
}

function script
{
    echo "baseurl: http://staging-aerogearsite.rhcloud.com/${OWNER_NAME}/${TRAVIS_BRANCH}" >> _config.yml
    cat _config.yml
    bundle exec jekyll build
}


function after_success
{
    sudo apt-get update -q
    sudo apt-get install -y rsync openssh-client
    eval "ACCESS_KEY=\$ACCESS_KEY_${OWNER_NAME}"
    echo '-----BEGIN RSA PRIVATE KEY-----$MIIEpAIBAAKCAQEA0wqa0C40I1wB4/8DN5uIn6zDbhaIpnfTmVjVHLRA+webzLS1$J1SrGwP8kqSePJMa8HWRez3bQx/l4rZsKLobN8vyugFxze6RHnzbYYzgwJQ1cJj3$BkBVzL1KgCIiIdAoFGUZzUYMMYXu+m84hJCTXZULpZJ1IlzPuGs1N7LBEjJB3h7c$MaYtSdrJz+Q563lessrZZK5FEIbcFl5uvRSDpKCzxRGx2imA1MG9VMSXT9fTBIYU$n0oyPH+B/Q/Mf1e5XFjfMoeTYzGSEX55TV1BthYfVT6EA42/nDiFNRl//mBSDhvU$7lhs72pLEBa2KBkCib7xD3fzXDPENyJlhGPwrQIDAQABAoIBAQC/4Mp1MS0SYRsO$8tM4Ad+sXeWp+C7yO8xVhmDtIi5ajsZmzn5ObjrL60n/AlEkfhNmQV6ukMUEOMJI$6NdaCCurBXGBEMMqGxgygg7smKvYLGiSIWGne2MHLavI6D/kQl/Oe0WET4XSmRV4$+RqH3PM/iL34IjsBrSTnZgISzCGiqgw0KE4RIpFmpw6fRXmahimIM+DayOCAzPZV$+jH0Fgppz9ESAcSgDpqMcHJU7atvy5rt1KLenRjGeB6f3rN6TsC4hUAK0Dil1QAG$Sc+CTPLds13RRNmvwmVRZKMHSZjhlmLaomnfqUs/bAT2uw40GtUasU/9XkLlkVld$gBnMRIn5AoGBAPB1jihLf+v8yShMqhJpF0cRxNkXCZRzNPj7+x22HQkA5iKuFw23$utq2S8b5ZH1m7N9QxT//KYHT3EsSNqxz+VMdksYlecOZLgcXrqyuWaIYWgvLcs6l$Yhv4iuXns6aBbEyhXhjanr6RYlQgrhVUtIVKwRtRT2rwaJD+bx1lrtnLAoGBAOCu$U5mBQIvUBcsbqyBaBk5AL+ch9acT/rA/dnyoyqYyOlOgo0tfmz30aa4fFuzEOQnh$1Ck0tiJ14i9mHLnkF0PnU6rgSQaXttHpNiNn+fgOpjozzENMVPKqp9Zu1Dz+gd/5$RtG2hCDEM1anXjolw/uCEoXlsSDw26jXnVShFPBnAoGAcn8nT5yTruTRS/UlTlro$EJkvaEeF8j/hS2WArycWMEFTU9QdehSwTpBbCMWbyfKGe9dT9SMkuoMM9FoZ2ofm$gmMkjmEt16tKtWnbbLIgUATUa6VWZ3tsefEhAlQPwQsDbIGx8pe22vsTHQfqnJGW$25k61i0jacJLqC7e7dqLJX0CgYAubtiIGNYmD6NC3mz3OqOi+FDuC26hINi5w+PQ$z3FR939mWQRmR1Pl8eUFPxeVxtei2zDlcydQ59vev9Of9yt3tQ7teXyeCCyYJQIz$PwHB6gUgciP8pIHJxMr63dyu3koo53NjU7zqqKGTfvNSQQvHppH9agK5NA2xTx4M$p12UcQKBgQDLsjOV5kCSyHvwnFS9Cf5CnB/T9uirM3t6cnqe9bJwCA0iM6nqGOI2$zdP5zZNa5IGg2EUAZeYSUwI0BJTsRTlnq1Oe0oVixhlOc0zFKu3r0aGyICGeV9mf$'$ACCESS_KEY'==$-----END RSA PRIVATE KEY-----' | tr '$' '\n' > access_key
    chmod 600 access_key
    $SSH 54c626194382ecaadb000076@staging-aerogearsite.rhcloud.com mkdir -p app-root/repo/$OWNER_NAME/$TRAVIS_BRANCH/
    rsync -avzq -e "${SSH}" _site/ 54c626194382ecaadb000076@staging-aerogearsite.rhcloud.com:app-root/repo/$OWNER_NAME/$TRAVIS_BRANCH/
}

##### Main

while [ "$1" != "" ]; do
    case $1 in
        install )               install
                                ;;
        script )                script
                                ;;
        after_success )         after_success
                                ;;
    esac
    shift
done
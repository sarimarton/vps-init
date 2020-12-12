FROM amazon/aws-cli

RUN yum install -y socat

ENTRYPOINT ["/usr/bin/socat", "TCP-LISTEN:1111,fork", "system:'read msg; eval \"aws $msg\"'"]

# Use it in clients like this:
# echo '--version' | socat -,ignoreeof TCP:aws-svc:1111
# echo 'translate translate-text --region eu-north-1 --source-language-code hu --target-language-code sw --text 'szeretnék vásárolni' | socat -,ignoreeof TCP:aws-svc:1111

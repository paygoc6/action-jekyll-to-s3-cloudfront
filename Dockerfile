FROM jekyll/jekyll:4.2.0

RUN apk update && \
    apk add python3 && \
    pip3 install awscli
    
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

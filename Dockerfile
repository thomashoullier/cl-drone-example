FROM fukamachi/sbcl:latest-alpine

RUN apk add git file && \
    ros install fukamachi/rove fukamachi/cl-coveralls

ENTRYPOINT ["/bin/sh"]

FROM alpine:3.12
LABEL maintainer "Lei Zhang <antiagainst@gmail.com>"

WORKDIR /usr/src/app

RUN apk --update add --no-cache --upgrade \
      cppcheck \
      python3 \
      py3-lxml && \
    rm -rf /usr/share/ri && \
    adduser -u 9000 -D -s /bin/false app

COPY engine.json /
COPY . ./
RUN chown -R app:app ./

USER app

VOLUME /code
WORKDIR /code

CMD ["python3", "/usr/src/app/bin/codeclimate-cppcheck"]

# docker-alp-certbot
Installs cerbot into an Alpine Linux container

![certbot](https://certbot.eff.org/images/certbot-logo-1A.svg)

## Description

Certbot is an easy-to-use automatic client that fetches and deploys SSL/TLS certificates for your webserver. Certbot was developed by EFF and others as a client for Lets Encrypt and was previously known as the official Lets Encrypt client or the Let's Encrypt Python client. Certbot will also work with any other CAs that support the ACME protocol.

https://certbot.eff.org/

## Usage
### Generating certificate
    docker run --name=certbot \
      -v /etc/localtime:/etc/localtime:ro \
      -v <path to certificates>:/etc/letsencrypt \
      -e DOCKMAIL=<mail address> \
      -e DOCKMAILDOMAINS=<domains list> \
      -p 80:80 \
      -p 443:443 \
      digrouz/docker-alp-certbot certbot

### Renewing certificate
    docker run --name=certbot \
      -v /etc/localtime:/etc/localtime:ro \
      -v <path to certificates>:/etc/letsencrypt \
      -e DOCKMAIL=<mail address> \
      -e DOCKMAILDOMAINS=<domains list> \
      -p 80:80 \
      -p 443:443 \
      digrouz/docker-alp-certbot certbot-renew


## Environment Variables

When you start the `certbot` image, you can adjust the configuration of the `certbot` instance by passing one or more environment variables on the `docker run` command line.

### `DOCKMAIL`

This variable is mandatory and specifies the mail that has to be used to generate the certificates.

### `DOCKMAILDOMAINS`

This variable is mandatory and specifies a list of domains (comma separated)  for which a certificate should be generates

## Notes

* The docker entrypoint will upgrade operating system at each startup.


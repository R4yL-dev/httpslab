#!/bin/bash

# TODO:
#   2. If no cert
#       2.1. Process init nginx conf template (for certbot challange).
#       2.2. Challange domain with certbot (onlycert).
#       2.3. Delete init nginx conf template.
#   3. Process https nginx conf template (for https).
#   4. Reload nginx.

CERT_PATH="/etc/letsencrypt/live/$DOMAIN/fullchain.pem"

# Process nginx conf template
envsubst </etc/nginx/template/https.template.conf >/etc/nginx/conf.d/https.conf

# Check if certificate already exists
if [ ! -f "$CERT_PATH" ]; then
    certbot --nginx -d $DOMAIN --email $EMAIL --agree-tos --no-eff-email
fi

# Add cron job for certificate renewal
echo "0 0,12 * * * root /opt/certbot/bin/python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew -q" | tee -a /etc/crontab >/dev/null

# Run nginx
exec nginx -g "daemon off;"

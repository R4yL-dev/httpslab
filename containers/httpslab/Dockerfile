FROM debian:bookworm

# Update package list
RUN apt update

# Remove installed certbot
RUN apt remove certbot -y

# Install packages main
RUN apt install -y \
    nginx \
    python3 \
    python3-pip \
    python3-venv \
    libaugeas0 \
    gettext-base

# DEBUG
RUN apt install -y \
    procps \
    iputils-ping \
    net-tools \
    curl \
    vim

# Clean up
RUN rm -fr /var/lib/apt/lists/*

# Install certbot
RUN python3 -m venv /opt/certbot && \
    /opt/certbot/bin/pip install --upgrade pip && \
    /opt/certbot/bin/pip install certbot certbot-nginx && \
    ln -s /opt/certbot/bin/certbot /usr/local/bin/certbot

# Copy template file
COPY confs/nginx/https.template.conf /etc/nginx/template/https.template.conf

# Copy and make executable init script
COPY scripts/init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 80
EXPOSE 443


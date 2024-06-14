FROM nginx:alpine

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Install Certbot and the Nginx plugin
RUN apk add --no-cache certbot-nginx

# Copy renewal script to cron hourly directory
COPY renew_certificates.sh /etc/periodic/hourly/renew_certificates

# Make the script executable
RUN chmod +x /etc/periodic/hourly/renew_certificates

#Expose to reverse proxy the server
EXPOSE 80
EXPOSE 443
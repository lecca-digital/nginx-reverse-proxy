FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf

#Expose to reverse proxy the server
EXPOSE 80
EXPOSE 443
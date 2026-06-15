FROM nginx:1.29-alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy static site content
COPY html/ /usr/share/nginx/html/

# Copy nginx config
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

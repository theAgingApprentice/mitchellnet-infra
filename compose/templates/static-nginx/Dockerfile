FROM nginx:1.29-alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy static site content
COPY html/ /usr/share/nginx/html/

# Copy nginx config
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Health check (wget is built into alpine)
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD wget -qO- http://localhost/ || exit 1

EXPOSE 80

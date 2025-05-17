FROM node:18-alpine

# Install dependencies
RUN apk add --update --no-cache \
    python3 \
    build-base \
    openssh \
    ffmpeg \
    curl \
    ca-certificates

# Create n8n directory
RUN mkdir -p /home/node/.n8n

# Set working directory
WORKDIR /usr/src/app

# Install n8n
RUN npm install n8n -g

# Set environment variables
ENV NODE_ENV=production
ENV N8N_PORT=5678
ENV WEBHOOK_URL=https://${RAILWAY_PUBLIC_DOMAIN}
ENV N8N_DIAGNOSTICS_ENABLED=false

# Expose port
EXPOSE 5678

# Start n8n
CMD ["n8n", "start"]

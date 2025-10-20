# Base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY app/package*.json ./
RUN npm install --production

# Copy source code
COPY app/ .

# Expose app port
EXPOSE 8080

# Start app
CMD [ "npm", "start" ]

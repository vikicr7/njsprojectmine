# Use official Node.js 18 image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --production

# Copy source code (assuming all app code is in 'app' folder)
COPY app/ ./

# Expose application port
EXPOSE 8080

# Set environment
ENV NODE_ENV=production

# Start the app
CMD ["npm", "start"]

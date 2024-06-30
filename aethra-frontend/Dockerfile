# Use the official Node.js 20.9-alpine image as a base
FROM node:20.9-alpine AS builder

# Set the working directory to /app
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Clear npm cache and install dependencies with --legacy-peer-deps
RUN npm cache clean --force && npm install --legacy-peer-deps

# Copy the rest of the application to the working directory
COPY . .

# Build the application
RUN npm run build
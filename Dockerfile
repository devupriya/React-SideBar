# Use an official Node.js runtime as the base image
FROM node:20-alpine AS builder

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Expose the port the app runs on
# Build the application
RUN npm run build

FROM node:20-alpine


RUN npm install -g serve

WORKDIR /app


COPY --from=builder /app/dist ./dist

EXPOSE 3000

CMD ["serve", "-s", "dist"]

## without serve and build
# FROM node:20-alpine
# WORKDIR /app
# COPY . .
# RUN npm install
# RUN npm run build
# EXPOSE 3000
# CMD ["npm", "start"]

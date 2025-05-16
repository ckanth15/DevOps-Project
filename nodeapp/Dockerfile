# Base image
FROM node:16.15.0

# Working directory for node
WORKDIR /usr/app

# Copy package files to docker image
COPY package.json .

# Run the command
RUN npm install

# Copy all files from application to the docker image
COPY . .

# Finall app configuration
EXPOSE 8080
CMD ["node","app.js"]

FROM node:18-alpine

# Woking directory /app
WORKDIR /app

COPY package*.json .

RUN npm install

# Copying the rest of the files
COPY . .

# Exposing the port
EXPOSE 3000

# Starting the app
CMD [ "npm", "start" ]
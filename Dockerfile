FROM node:18-alpine
WORKDIR /app

COPY . .
EXPOSE 3000

COPY package*.json ./

ENTRYPOINT ["npm", "start"]

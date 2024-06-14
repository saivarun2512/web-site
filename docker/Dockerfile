FROM node:alpine

WORKDIR /app

COPY ./app/package.json /app/ 

RUN npm install

COPY ./app/server.js /app/ 

RUN mkdir -p ./public/images
COPY ./images/ ./public/images/

COPY ./app/index.html ./public/

EXPOSE 3000

CMD ["node", "server.js"]

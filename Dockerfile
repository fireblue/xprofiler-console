FROM node:18.12.1-alpine3.15 as build

WORKDIR /app

COPY . .

RUN npm config set registry https://registry.npm.taobao.org && npm install

EXPOSE 8443

CMD [ "npm", "start" ]

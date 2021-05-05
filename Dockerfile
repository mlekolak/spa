FROM node:16.0.0-alpine3.13 AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build
RUN mv dist/* dist/app/

FROM nginx:1.20.0-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist/app /usr/share/nginx/html

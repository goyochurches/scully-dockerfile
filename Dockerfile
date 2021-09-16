
FROM node:14.17.0-alpine as node
WORKDIR /app
COPY package.json /app/
RUN npm install
COPY ./ /app/
RUN npm run build -- --prod 
RUN npm run scully


# building nginx
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*

COPY --from=node /app/dist/static/ /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

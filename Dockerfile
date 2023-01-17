# ---- Dependencies ----
FROM node:16-alpine AS dependencies
WORKDIR /app
COPY package.json ./
RUN yarn install

# ---- Build ----
FROM dependencies AS build
WORKDIR /app
COPY . /app
RUN yarn build

FROM nginx:1.16-alpine
COPY --from=build /app/dist /usr/share/nginx/html
WORKDIR /app
COPY . /app
RUN ls -a
COPY default.conf /etc/nginx/conf.d/default.conf
RUN wget https://github.com/tindy2013/subconverter/releases/download/v0.7.2/subconverter_linux64.tar.gz && tar -zxvf subconverter_linux64.tar.gz
#COPY ./subconverter /
RUN ls -a
# EXPOSE 80

CMD nohup ./subconverter/subconverter & nginx -g "daemon off;"

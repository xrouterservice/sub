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
USER root
COPY --from=build /app/dist /usr/share/nginx/html
COPY --from=ochinchina/supervisord:latest /usr/local/bin/supervisord /usr/bin/supervisord
#COPY . /app
COPY ./supervisord.conf /supervisord.conf
COPY ./start.sh /start.sh
RUN chmod 755 /start.sh
COPY ./default.conf /etc/nginx/conf.d/default.conf
WORKDIR /app
RUN wget https://github.com/tindy2013/subconverter/releases/download/v0.7.2/subconverter_linux64.tar.gz && tar -zxvf subconverter_linux64.tar.gz
RUN rm ./subconverter/pref.example.*

COPY /pref.example.toml ./subconverter/pref.example.toml

EXPOSE 155 443
CMD ["/usr/bin/supervisord","-c","/supervisord.conf"]

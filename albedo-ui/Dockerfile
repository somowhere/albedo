
FROM nginx

COPY ./dist /data

RUN rm /etc/nginx/conf.d/default.conf

ADD ./nginx.conf /etc/nginx/conf.d/

RUN /bin/bash -c 'echo init ok'


EXPOSE 80

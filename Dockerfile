FROM openjdk:13-alpine3.10
RUN apk add --update --no-cache nodejs npm graphviz
RUN mkdir -p /gitlab-pages-render 
COPY package.json /gitlab-pages-render
RUN cd /gitlab-pages-render && \
    npm install --save
COPY render.js /gitlab-pages-render
COPY .mume /root/.mume

RUN ln -s /gitlab-pages-render/render.js /bin/render.js

CMD [ "/bin/render.js" ]
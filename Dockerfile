FROM openjdk:8-jre-alpine3.9
RUN apk update && \
    apk upgrade && \
    apk add --no-cache nodejs-current \
                       npm \
                       graphviz \
                       ttf-droid \
                       ttf-droid-nonlatin && \
    ln -s /gitlab-pages-render/render.js /bin/render

RUN mkdir -p /gitlab-pages-render 
COPY ["package.json", "render.js", "/gitlab-pages-render/"]

RUN cd /gitlab-pages-render && \
    npm install --save
COPY .mume /root/.mume

CMD [ "/bin/render" ]
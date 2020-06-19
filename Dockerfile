FROM openjdk:13-alpine3.10
RUN apk add --update --no-cache nodejs-current \
                                npm \
                                graphviz \
                                ttf-droid \
                                ttf-droid-nonlatin
RUN mkdir -p /gitlab-pages-render 
COPY ["package.json", "render.js", "/gitlab-pages-render/"]
RUN cd /gitlab-pages-render && \
    npm install --save && \
    ln -s /gitlab-pages-render/render.js /bin/render.js
COPY .mume /root/.mume
 
CMD [ "/bin/render.js" ]
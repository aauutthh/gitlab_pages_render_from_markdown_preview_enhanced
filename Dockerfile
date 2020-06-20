FROM openjdk:8-jre-alpine3.9
RUN apk update && \
    apk upgrade && \
    apk add --no-cache nodejs-current \
                       npm \
                       graphviz \
                       ttf-droid \
                       ttf-droid-nonlatin && \
    ln -s /markdown-preview-enhanced-render/render.js /bin/render

RUN mkdir -p /markdown-preview-enhanced-render
COPY ["package.json", "render.js", "/markdown-preview-enhanced-render/"]

RUN cd /markdown-preview-enhanced-render&& \
    npm install --save
COPY .mume /root/.mume

CMD [ "/bin/render" ]
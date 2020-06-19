FROM node:12.18.1-slim
RUN mkdir -p /gitlab-pages-render
COPY render.js /gitlab-pages-render
COPY package.json /gitlab-pages-render
RUN cd /gitlab-pages-render && \
    npm install && \
    ln -s /gitlab-pages-render/render.js /bin/render.js

CMD [ "/bin/render.js" ]
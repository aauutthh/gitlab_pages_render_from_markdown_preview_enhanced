FROM node:12.18.1-slim
RUN useradd -ms /bin/sh gitlab

USER gitlab

RUN mkdir -p /home/gitlab/gitlab-pages-render 
COPY package.json /home/gitlab/gitlab-pages-render
RUN cd /home/gitlab/gitlab-pages-render && \
    npm install
COPY render.js /home/gitlab/gitlab-pages-render
COPY .mume /home/gitlab/.mume

USER root
RUN ln -s /home/gitlab/gitlab-pages-render/render.js /bin/render.js

USER gitlab
CMD [ "/bin/render.js" ]
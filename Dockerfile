FROM node:22
WORKDIR /app
COPY . /app
RUN yarn install
EXPOSE 3000
CMD "yarn" "dev"

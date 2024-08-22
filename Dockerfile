FROM node:alpine AS build
WORKDIR /opt/app
COPY package.json package-lock.json ./
RUN npm install
COPY public ./public
COPY src ./src
RUN npm run build

FROM node:alpine
RUN npm install -g serve
WORKDIR /opt/app
COPY --from=build /opt/app/build ./build
EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]

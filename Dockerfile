FROM node
WORKDIR /app
COPY package.json ./
COPY Node.tar.gz .
RUN tar xzf Node.tar.gz
RUN npm install
EXPOSE 3000
CMD ["npm", "start"]

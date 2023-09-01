
FROM node
WORKDIR /app
COPY Node.tar.gz .
RUN tar xzf Node.tar.gz
COPY src/index.js /app/
RUN npm install -g pm2
CMD ["pm2-runtime", "start", "index.js"]

#FROM node
#WORKDIR /app
#COPY Node.tar.gz .
#RUN tar xzf Node.tar.gz
#RUN npm install
#EXPOSE 3000
#CMD ["npm", "start"]


FROM node
WORKDIR /app
COPY Node.tar.gz .
RUN tar xzf Node.tar.gz
COPY src/index.js /app/
RUN npm install 
CMD ["npm", "start"]

#FROM node
#WORKDIR /app
#COPY Node.tar.gz .
#RUN tar xzf Node.tar.gz
#RUN npm install
#EXPOSE 3000
#CMD ["npm", "start"]

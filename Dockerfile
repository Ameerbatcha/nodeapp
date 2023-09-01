
FROM node
WORKDIR /app
COPY Node.tar.gz .
RUN tar -xf Node.tar.gz
RUN rm -rf Node.tar.gz
RUN npm install 
EXPOSE 3000
CMD ["npm", "start"]

#FROM node
#WORKDIR /app
#COPY Node.tar.gz .
#RUN tar xzf Node.tar.gz
#RUN npm install
#EXPOSE 3000
#CMD ["npm", "start"]

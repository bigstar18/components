./stop.sh
cp=./bin
for file in ./lib/*.jar
do
   cp=$cp:$file
done
nohup java -Djava.rmi.server.hostname=172.17.12.27 -Xms256m -Xmx2500m -classpath $cp -Djava.security.policy=ServerShell.policy gnnt.mebsv.hqservice.ServerStart gnnt.mebsv.hqservice.service.server.ReceiverThread port=20103 poollength=100 processMarketName=HQServiceServerStart >>./logs/sys.log & 

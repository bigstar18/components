./stop.sh
cp=./bin
for file in ./lib/*.jar
do
   cp=$cp:$file
done
nohup java -Djava.rmi.server.hostname=172.17.12.22 -Xms256m -Xmx512m -classpath $cp -Djava.security.policy=ServerShell.policy gnnt.MEBS.logonService.ServerShell  logonService_aubroker  logonService_aubroker >>./logs/sys.log & 

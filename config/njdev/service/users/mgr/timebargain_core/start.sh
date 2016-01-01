./stop.sh
cp=./bin
for file in ./lib/*.jar
do
   cp=$cp:$file
done
nohup java -Djava.rmi.server.hostname=10.0.100.181 -d64 -Xms4096m -Xmx8000m -classpath $cp -Djava.security.policy=ServerShell.policy gnnt.MEBS.timebargain.server.ServerShell timebargaincoreServerShell >>./logs/sys.log & 

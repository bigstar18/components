./stop.sh
cp=./bin
for file in ./lib/*.jar
do
   cp=$cp:$file
done
nohup java -Djava.rmi.server.hostname=172.17.12.22 -Xms800m -Xmx6000m -classpath $cp -Djava.security.policy=ServerShell.policy gnnt.MEBS.timebargain.server.ServerShell timebargaincoreServerShell >>./logs/sys.log & 

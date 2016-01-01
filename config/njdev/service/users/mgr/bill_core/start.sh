./stop.sh
cp=./bin
for file in ./lib/*.jar
do
   cp=$cp:$file
done
nohup java -Djava.rmi.server.hostname=10.0.100.181 -Xms1g -Xmx2g -classpath $cp -Djava.security.policy=ServerShell.policy gnnt.MEBS.bill.core.ServerShell billcoreServerShell >>./logs/sys.log & 

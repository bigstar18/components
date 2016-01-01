./stop.sh
cp=./bin
for file in ./lib/*.jar
do
   cp=$cp:$file
done
nohup java -Djava.rmi.server.hostname=172.17.12.27 -Xms256m -Xmx512m -classpath $cp -Djava.security.policy=ServerShell.policy gnnt.mebsv.hqtrans.ServerStart HQTransServerShell >>./logs/sys.log & 

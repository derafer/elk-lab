export JAVA_OPTS="-Djava.security.egd=file:///dev/urandom \
-Dcom.sun.management.jmxremote=true \
-Dcom.sun.management.jmxremote.port=12345 \
-Dcom.sun.management.jmxremote.rmi.port=12346 \
-Dcom.sun.management.jmxremote.ssl=false \
-Dcom.sun.management.jmxremote.authenticate=false \
-Xloggc:"${TOMCAT_PATH}/logs/garbage-collection.log" \
-verbose:gc \
-XX:+HeapDumpOnOutOfMemoryError \
-XX:HeapDumpPath="${TOMCAT_PATH}/logs/" \
-Djava.rmi.server.hostname=$WM_IPADDR \
-Xverify:none"
export CATALINA_OPTS="-Xms256M \
-Xmx512M \
-server \
-XX:+UseParallelGC"
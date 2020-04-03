FROM sysincz/java-applet-player:v1.0
#FROM desktopcontainers/java-applet-player

ENV DEBIAN_FRONTEND noninteractive

ENV JAVA_HOME=/opt/jdk1.8.0_121
ENV JRE_HOME=/opt/jdk1.8.0_121/jre
ENV PATH=$PATH:/opt/jdk1.8.0_121/bin:/opt/jdk1.8.0_121/jre/bin

ADD https://files-cdn.liferay.com/mirrors/download.oracle.com/otn-pub/java/jdk/8u121-b13/jdk-8u121-linux-x64.tar.gz /opt/
RUN ls -lrta /opt/
#ADD /jdk-8u121-linux-x64.tar.gz /opt/

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && update-alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so mozilla-javaplugin.so $JAVA_HOME/jre/lib/amd64/libnpjp2.so 1 \
 && update-alternatives --set mozilla-javaplugin.so $JAVA_HOME/jre/lib/amd64/libnpjp2.so \
 && update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 1 \
 && update-alternatives --set java $JAVA_HOME/bin/java


RUN echo "#!/bin/bash  " > /usr/local/bin/ssh-app.sh \
 && echo "mkdir -p $HOME/.java/deployment/security/"  >> /usr/local/bin/ssh-app.sh \
 && echo "echo \"\$WEB_URL_JAVA_EXCEPTION\" > $HOME/.java/deployment/security/exception.sites"  >> /usr/local/bin/ssh-app.sh \
 && echo "kill \$(pidof firefox-esr) 2>/dev/null" >> /usr/local/bin/ssh-app.sh \
 && echo "firefox --new-instance \$WEB_URL\n" >> /usr/local/bin/ssh-app.sh 

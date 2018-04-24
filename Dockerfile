FROM       xemuliam/alpine
MAINTAINER Viacheslav Kalashnikov <xemuliam@gmail.com>
ARG        JAVA_MIRROR=http://download.oracle.com/otn-pub/java
ARG        JAVA_FOLDER=512cd62ec5174c3487ac17c61aaa89e8
ENV        JAVA_VERSION=8 \
           JAVA_UPDATE=171 \
           JAVA_BUILD=11 \
           JAVA_HOME=/usr/lib/jvm/default-jvm
RUN        apk add --no-cache --virtual=.build-deps curl unzip && \
           curl -jkSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
             ${JAVA_MIRROR}/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_FOLDER}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz | tar xvz -C /tmp && \
           mkdir -p /usr/lib/jvm && \
           mv /tmp/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE} /usr/lib/jvm/java-${JAVA_VERSION}-oracle && \
           ln -s java-${JAVA_VERSION}-oracle ${JAVA_HOME} && \
           ln -s ${JAVA_HOME}/bin/* /usr/bin/ && \
           rm -rf ${JAVA_HOME}/*src.zip \
             ${JAVA_HOME}/jre/bin/javaws \
             ${JAVA_HOME}/jre/lib/*javafx* \
             ${JAVA_HOME}/jre/lib/*jfx* \
             ${JAVA_HOME}/jre/lib/amd64/libdecora_sse.so \
             ${JAVA_HOME}/jre/lib/amd64/libfxplugins.so \
             ${JAVA_HOME}/jre/lib/amd64/libglass.so \
             ${JAVA_HOME}/jre/lib/amd64/libgstreamer-lite.so \
             ${JAVA_HOME}/jre/lib/amd64/libjavafx*.so \
             ${JAVA_HOME}/jre/lib/amd64/libjfx*.so \
             ${JAVA_HOME}/jre/lib/amd64/libprism_*.so \
             ${JAVA_HOME}/jre/lib/deploy* \
             ${JAVA_HOME}/jre/lib/desktop \
             ${JAVA_HOME}/jre/lib/ext/jfxrt.jar \
             ${JAVA_HOME}/jre/lib/javaws.jar \
             ${JAVA_HOME}/jre/lib/plugin.jar \
             ${JAVA_HOME}/jre/plugin \
             ${JAVA_HOME}/lib/*javafx* \
             ${JAVA_HOME}/lib/missioncontrol \
             ${JAVA_HOME}/lib/visualvm && \
           curl -jkSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/jce_policy-${JAVA_VERSION}.zip \
             ${JAVA_MIRROR}/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip && \
           cd /tmp && unzip -jo -d ${JAVA_HOME}/jre/lib/security jce_policy-${JAVA_VERSION}.zip && \
           rm -rf /tmp/* \
             ${JAVA_HOME}/jre/lib/security/README.txt && \
           apk del .build-deps && \
           apk add --no-cache bash

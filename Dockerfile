FROM quay.io/wildfly/wildfly-s2i:latest
WORKDIR build
COPY pom.xml .
COPY src src
RUN mvn clean package -Popenshift
RUN mv "target/server/standalone/deployments" "target/jboss-ext-deployments"

FROM quay.io/wildfly/wildfly-runtime:latest
COPY --from=0 --chown=jboss:root /build/target/server $JBOSS_HOME
COPY --from=0 --chown=jboss:root /build/target/jboss-ext-deployments $JBOSS_HOME/standalone/deployments

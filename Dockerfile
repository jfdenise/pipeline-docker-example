FROM quay.io/wildfly/wildfly-s2i:latest

RUN mvn clean package -Popenshift
RUN mv "target/server/standalone/deployments" "target/jboss-ext-deployments"

FROM quay.io/wildfly/wildfly-runtime:latest
COPY --from=0 --chown=jboss:root target/server $JBOSS_HOME
COPY --from=0 --chown=jboss:root target/jboss-ext-deployments $JBOSS_HOME/standalone/deployments

FROM quay.io/wildfly/wildfly-s2i:latest
WORKDIR /build
RUN mkdir src
RUN ls -l
COPY --chown=jboss:root * ./src
ENV S2I_DESTINATION_DIR=/build
RUN /usr/local/s2i/assemble
RUN mv "src/target/server/standalone/deployments" "target/jboss-ext-deployments"

FROM quay.io/wildfly/wildfly-runtime:latest
COPY --from=0 --chown=jboss:root /build/src/target/server $JBOSS_HOME
COPY --from=0 --chown=jboss:root /build/src/target/jboss-ext-deployments $JBOSS_HOME/standalone/deployments
RUN chmod -R ug+rwX $JBOSS_HOME

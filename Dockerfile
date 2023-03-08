FROM quay.io/wildfly/wildfly-s2i:latest
WORKDIR /build
RUN mkdir src
COPY --chown=jboss:root * ./src
ENV S2I_DESTINATION_DIR=/build
RUN /usr/local/s2i/assemble
#RUN mv "$JBOSS_HOME/standalone/deployments" "/build/jboss-ext-deployments"

FROM quay.io/wildfly/wildfly-runtime:latest
COPY --from=0 --chown=jboss:root $JBOSS_HOME $JBOSS_HOME
#COPY --from=0 --chown=jboss:root /build/jboss-ext-deployments $JBOSS_HOME/standalone/deployments
RUN chmod -R ug+rwX $JBOSS_HOME

FROM container-registry.oracle.com/database/enterprise:19.3.0.0

# Copy patch files and OPatch utility into the image
COPY ./software/p36582781_190000_Linux-x86-64.zip /tmp/
COPY ./software/p6880880_190000_Linux-x86-64.zip /tmp/

# Set environment variables
ENV ORACLE_HOME=/opt/oracle/product/19c/dbhome_1
ENV PATH=$ORACLE_HOME/bin:$PATH

RUN rm -rf $ORACLE_HOME/OPatch $ORACLE_HOME/OPatch_backup
RUN unzip -q /tmp/p6880880_190000_Linux-x86-64.zip -d $ORACLE_HOME
RUN unzip /tmp/p36582781_190000_Linux-x86-64.zip -d /tmp
RUN unzip /tmp/p36912597_190000_Linux-x86-64.zip -d /tmp


RUN mkdir -p /opt/oracle/product/19c/dbhome_1/test_directory && \
    echo "Directory creation inside dbhome_1 successful"
    
# Apply the patch
RUN cd /tmp/36582781/ && \
    opatch apply -silent && \
    echo "Cleaning up patch files..." && \
    rm -rf /tmp/36582781/
    
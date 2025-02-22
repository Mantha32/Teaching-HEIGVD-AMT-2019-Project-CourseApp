#!/bin/bash

# Source: https://github.com/payara/Payara-Examples/blob/master/administration-examples/setup-sample-domain.sh

# Payara Variable Initialisation
# DOMAIN_NAME will be the name that you use to reference your domain when
# working with some Payara/Glassfish commands.
DOMAIN_NAME="domain1"

# The PAYARA_HOME variable points to your Payara install location. The below
# path would be appropriate for Payara versions 4.1.x
#PAYARA_HOME="/opt/payara5/glassfish"

#Doriane PAYARA home
PAYARA_HOME="/Users/dorianekaffo/Desktop/semestre5/AMT/Serveurs/payara5/glassfish"

# The ASADMIN variable points to the location of the asadmin script used
# to run the Payara asadmin commands
ASADMIN=${PAYARA_HOME}/bin/asadmin


echo "AS_ADMIN_PASSWORD=admin" > /tmp/gfpw.txt;

#${ASADMIN} --interactive=false --user admin --passwordfile=/tmp/gfpw.txt change-admin-password

# The use of the DOMAIN_NAME variable at the end of the asadmin command is used
# to determine the directory with which the domain's data is stored in within
# your Payara install. The name must contain only ASCII characters and be valid
# for a directory name on your operating system.
#
# More information regarding the use and option of the asadmin create-domain
# command can be found at: https://docs.oracle.com/html/E24938_01/create-domain.htm

#${ASADMIN} delete-domain ${DOMAIN_NAME}

#${ASADMIN} --user admin --passwordfile=/tmp/gfpw.txt create-domain --portbase ${PORT_BASE} ${DOMAIN_NAME}


## Check out the Ip address for de mysql database running in docker
#DB_IP=$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysqlcourse)

# Start the newly created sampleDomain domain using the asadmin start-domain
# command.

${ASADMIN} start-domain ${DOMAIN_NAME} && \
${ASADMIN} --interactive=false --user admin  create-jdbc-connection-pool --restype javax.sql.DataSource --datasourceclassname com.mysql.jdbc.jdbc2.optional.MysqlDataSource --property user=root:password=adminpw:DatabaseName=schedule:ServerName=172.19.0.2:port=3306 pool_course && \
${ASADMIN} --interactive=false --user admin  create-jdbc-resource --connectionpoolid pool_course jdbc/schedule

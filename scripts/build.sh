#!/bin/sh

# apollo config db info
# shellcheck disable=SC2125
apollo_config_db_url=jdbc:mysql://10.100.183.34:3306/ApolloConfigDB?characterEncoding=utf8
apollo_config_db_username=root
apollo_config_db_password=7nQw0TqT

# apollo portal db info
apollo_portal_db_url=jdbc:mysql://10.100.183.34:3306/ApolloPortalDB?characterEncoding=utf8
apollo_portal_db_username=root
apollo_portal_db_password=7nQw0TqT

# meta server url, different environments should have different meta server addresses
dev_meta=http://127.0.0.1:8080
#fat_meta=http://127.0.0.1:8081
#uat_meta=http://127.0.0.1:8082
#pro_meta=http://127.0.0.1:8083

#-Dfat_meta=$fat_meta -Duat_meta=$uat_meta -Dpro_meta=$pro_meta

META_SERVERS_OPTS="-Ddev_meta=$dev_meta"

# =============== Please do not modify the following content =============== #
# go to script directory
cd "${0%/*}"

cd ..

# package config-service and admin-service
echo "==== starting to build config-service and admin-service ===="

mvn clean package -DskipTests -pl apollo-configservice,apollo-adminservice -am -Dapollo_profile=github -Dspring_datasource_url=$apollo_config_db_url -Dspring_datasource_username=$apollo_config_db_username -Dspring_datasource_password=$apollo_config_db_password

echo "==== building config-service and admin-service finished ===="

echo "==== starting to build portal ===="

mvn clean package -DskipTests -pl apollo-portal -am -Dapollo_profile=github,auth -Dspring_datasource_url=$apollo_portal_db_url -Dspring_datasource_username=$apollo_portal_db_username -Dspring_datasource_password=$apollo_portal_db_password $META_SERVERS_OPTS

echo "==== building portal finished ===="

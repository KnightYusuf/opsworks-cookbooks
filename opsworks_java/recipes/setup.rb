#include_recipe 'opsworks_java::tomcat_config'
execute 'owner tomcat' do
2	  command 'chown -R ec2-user /opt/tomcat'
execute 'start tomcat' do
2	  command '/opt/tomcat/bin/./shtartup.sh'


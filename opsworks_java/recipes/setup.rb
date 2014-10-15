#include_recipe 'opsworks_java::tomcat_config'
execute 'owner tomcat' do
	  command 'chown -R ec2-user /opt/tomcat'
execute 'start tomcat' do
	  command '/opt/tomcat/bin/./shtartup.sh'


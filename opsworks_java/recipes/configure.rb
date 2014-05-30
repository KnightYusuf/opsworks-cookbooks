include_recipe 'opsworks_java::context'

execute "import_redis_jar" do
command "wget https://github.com/downloads/jcoleman/tomcat-redis-session-manager/tomcat-redis-session-manager-1.2-tomcat-7.jar
-P #{node['opsworks_java']['tomcat']['lib_dir']}"

execute "import_jedis_jar" do
command "wget http://repo1.maven.org/maven2/redis/clients/jedis/2.4.2/jedis-2.4.2.jar
-P #{node['opsworks_java']['tomcat']['lib_dir']}"
                     

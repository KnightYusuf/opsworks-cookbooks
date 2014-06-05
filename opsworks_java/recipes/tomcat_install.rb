tomcat_pkgs = value_for_platform_family(
  'debian' => ["tomcat#{node['opsworks_java']['tomcat']['base_version']}", 'libtcnative-1', 'libmysql-java'],
  'rhel' => ["tomcat#{node['opsworks_java']['tomcat']['base_version']}", 'tomcat-native', 'mysql-connector-java']
)

tomcat_pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

link ::File.join(node['opsworks_java']['tomcat']['lib_dir'], node['opsworks_java']['tomcat']['mysql_connector_jar']) do
  to ::File.join(node['opsworks_java']['tomcat']['java_shared_lib_dir'], node['opsworks_java']['tomcat']['mysql_connector_jar'])
  action :create
end

execute "import_redis_jar" do
  command "wget https://github.com/downloads/jcoleman/tomcat-redis-session-manager/tomcat-redis-session-manager-1.2-tomcat-7.jar -P #{node['opsworks_java']['tomcat']['lib_dir']}"
end

execute "import_jedis_jar" do
  command "wget http://repo1.maven.org/maven2/redis/clients/jedis/2.4.2/jedis-2.4.2.jar -P #{node['opsworks_java']['tomcat']['lib_dir']}"
end

execute "import_spymemcached_jar" do
  command "wget http://repo1.maven.org/maven2/net/spy/spymemcached/2.10.2/spymemcached-2.10.2.jar  -P #{node['opsworks_java']['tomcat']['lib_dir']}"
end

execute "import_memcach_manager_jar" do
  command "wget http://repo1.maven.org/maven2/de/javakaffee/msm/memcached-session-manager-tc7/1.8.1/memcached-session-manager-tc7-1.8.1.jar  -P #{node['opsworks_java']['tomcat']['lib_dir']}"
end

# remove the ROOT webapp, if it got installed by default
include_recipe 'opsworks_java::remove_root_webapp'

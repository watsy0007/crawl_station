require 'rake'

desc 'show module list'
task :module_list do
  Dir['module/*'].each { |dir| puts dir.split('/').last }
end

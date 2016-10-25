require 'rake'

desc 'show module list'
task :module_list do
  Dir['parser/*'].each { |dir| puts dir.split('/').last }
end

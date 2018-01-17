require 'fileutils'
require 'chef/knife'

class Testfile < Chef::Knife


 banner 'knife testfile (options)'

option:opt,
      :short => '-o ',
      :long => '--option '

option:file_name,
      :short => '-n FILE_NAME',
      :long => '--name FILE_NAME'

option:dir_name,
      :short => '-p  FILE_PATH',
      :long => '--path  FILE_PATH'
def run
  file=config[:file_name]
  dir=config[:dir_name]

   if config[:opt] == 'create'
     create_file(file,dir)
   elsif config[:opt] == 'delete'
     delete_file(file,dir)
 end

end


def create_file(file,dir)
FileUtils.mkdir_p(dir) unless Dir.exists?(dir)
f = File.new(File.join(dir,file),"w+")
end

def delete_file(file,dir)
if File.directory?("#{dir}")
 if File.exists?("#{dir}/#{file}")
FileUtils.rm("#{dir}/#{file}")
 elsif puts "file not exists"
end
elsif puts "dir not exists"
end

end
end


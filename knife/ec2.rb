require 'aws-sdk'
require 'chef/knife'

class Ec2Action < Chef::Knife

banner 'knife ec2 action (options)'

option:action,
      :short=>'-a start or stop',
      :long=>'--action start or stop'
option:instance_id,
      :short=>'-i id',
      :long=>'--instance id'

def run
@id = config[:instance_id]
@ec2 = Aws::EC2::Resource.new(region:'us-west-2')
@ins = @ec2.instance("#{@id}")
if config[:action]=='start'
start_instance
elsif config[:action]=='stop'
stop_instance
end
end

def start_instance
      #ec2 = Aws::EC2::Resource.new(region:'us-west-2')
       #@ins = ec2.instance("#{@id}")
if @ins.exists?
  case @ins.state.code
  when 0  # pending
puts "#{@id} is pending, so it will be running in a bit"
  when 16  # started
    puts "#{@id} is already started"
  when 48  # terminated
    puts "#{@id} is terminated, so you cannot start it"
  else
    @ins.start
  end
end
end

def stop_instance
          #ec2 = Aws::EC2::Resource.new(region:'us-west-2')
          #ins = ec2.instance("#{@id}")
if @ins.exists?
  case @ins.state.code
 when 48  # terminated
    puts "#{@id} is terminated, so you cannot stop it"
  when 64  # stopping
    puts "#{@id} is stopping, so it will be stopped in a bit"
  when 80  # stopped
    puts "#{@id} is already stopped"
else
    @ins.stop
  end
end
end
end


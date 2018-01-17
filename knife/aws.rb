require 'aws-sdk'  # v2: require 'aws-sdk'
require 'chef/knife'
 class AwsIam < Chef::Knife
banner 'knife aws iam (options)'
option:opt,
      :short=>'-o option',
      :long=>'--option option'
option:user,
      :short=>'-u user_name',
      :long=>'--user user_name'
option:group,
      :short=>'-g group_name',
      :long=>'--group group_name'
option:add_user_to_group,
      :short=>'-a',
      :long=>'--add'
option:remove_user_from_group,
      :short=>'-r',
      :long=>'--remove'
option:policy,
      :short=>'-p policy name',
      :long=>'--policy policy name'
def run
  @iam = Aws::IAM::Client.new(region: 'us-west-2')
  @name=config[:user]
  @group = config[:group]
  @policy = config[:policy]
 puts "#{@group}"
  if config[:opt] == 'create'
     create_iam_user
     login_profile
    create_userkeys
  elsif config[:opt] =='delete'
    delete_accesskeys
    delete_loginprofile
    delete_iam_user
  end

   if config[:group]
   create_group
   end

  if config[:add_user_to_group]
  add_to_group
  elsif  config[:remove_user_from_group]
  remove_from_group
  end

 if config[:policy]
 attach_policy_to_group
 end

end


def add_to_group
k=@iam.add_user_to_group({
group_name: @group,
user_name: @name,
})
puts "#{@name} added to #{@group}"
rescue Aws::IAM::Errors::EntityAlreadyExists
  puts 'User already added to group'
end

def attach_policy_to_group
k =@iam.attach_group_policy({
                 group_name: @group,
  policy_arn: "arn:aws:iam::aws:policy/#{@policy}",
})
puts "policy #{@policy} attached to group #{@group}"
end

def remove_from_group
k = @iam.remove_user_from_group({
  group_name:@group,
  user_name: @name,
})
puts "user #{@user} removed from group #{@group}"
rescue Aws::IAM::Errors::NoSuchEntity
puts "user does not exist in the group"
end

end


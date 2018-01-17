require 'aws-sdk'  # v2: require 'aws-sdk'
require 'chef/knife'
require 'json'
 class AwsIa < Chef::Knife

def create_iam_user
  begin
    @user = @iam.create_user(user_name: @name)
    @iam.wait_until(:user_exists, user_name:@name)
  puts @user
  rescue Aws::IAM::Errors::EntityAlreadyExists
  puts 'User already exists'
  end
end

def create_userkeys
  begin
   k=@iam.create_access_key({ user_name:@name })
   puts k
    rescue Aws::IAM::Errors::LimitExceeded
      puts "Too many access keys. Can't create any more."
   end
end

def login_profile
 k=@iam.create_login_profile({
   password: "h]6EszR}vJ*m",
   password_reset_required: true,
   user_name:@name,
})
  puts k
  rescue Aws::IAM::Errors::EntityAlreadyExists
  puts 'Profile already exists'

end

def create_group
  k=@iam.create_group({group_name:@group})
  puts k
  rescue Aws::IAM::Errors::EntityAlreadyExists
  puts 'Group already exists'
end

end      

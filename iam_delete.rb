require 'aws-sdk'  # v2: require 'aws-sdk'
require 'chef/knife'
 class AwsIam < Chef::Knife



def delete_accesskeys
   list_access_keys_response = @iam.list_access_keys({ user_name:@name })
   k =@iam.delete_access_key({
   access_key_id: list_access_keys_response.access_key_metadata[0].access_key_id,
   user_name:@name, })
   rescue Aws::IAM::Errors::NoSuchEntity
   puts "accesskeys does not exist"
end

def delete_loginprofile
  k = @iam.delete_login_profile({ user_name:@name,})
  rescue Aws::IAM::Errors::NoSuchEntity
  puts "login profile does not exist"
end

def delete_iam_user
 k =@iam.delete_user({ user_name: @name, })
  puts "user #{@name} is deleted"
  rescue Aws::IAM::Errors::NoSuchEntity
  puts "user does not exist"
end


def delete_group
k =@iam.delete_group({
  group_name:@group, # required
})
puts "deleted the group #{@group}"
rescue Aws::IAM::Errors::NoSuchEntity
  puts "group does not exist"
rescue Aws::IAM::Errors::DeleteConflict
 puts "Cannot delete the group"
 puts "to delete the group first remove the users from the group"
end


end
            

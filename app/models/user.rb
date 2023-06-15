# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  likes_count     :integer
#  password_digest :string
#  private         :boolean
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many :photos, { :class_name => "Photo", :foreign_key => "owner_id", :dependent => :destroy }
  has_many :received_follow_requests, { :class_name => "FollowRequest", :foreign_key => "recipient_id", :dependent => :destroy }
  has_many :sentfollowrequests, { :class_name => "FollowRequest", :foreign_key => "sender_id", :dependent => :destroy }
  has_many :likes, { :class_name => "Like", :foreign_key => "fan_id", :dependent => :destroy }
  has_many :comments, { :class_name => "Comment", :foreign_key => "author_id", :dependent => :destroy }
  #mount_uploader :image, ImageUploader

  def follow_request_for(other_user_id)
    FollowRequest.where({ sender_id: self.id, recipient_id: other_user_id }).at(0)
  end
end

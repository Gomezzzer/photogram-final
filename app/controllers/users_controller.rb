class UsersController < ApplicationController
  def index
    users = User.all
    @list_of_users = users.order({:username => :asc})
    
    render({ :template => "user/index.html.erb" })
  end

  def show
    if session.fetch(:user_id) != nil
    user = params.fetch("username")
    matching_user = User.where({ :username => user }).first
    @the_user = matching_user

  
    follow_requests = FollowRequest.all
    list_of_follow_request = follow_requests.order({:created_at => :desc})
    @pending_followers =list_of_follow_request.where({:recipient_id => @current_user.id})

    
    render({ :template => "user/show.html.erb" })
    else 
      redirect_to("/user_sign_in", { :alert => "You need to sign in first." })
    end
  end
  
  def liked_photos
    @photos = @current_user.photos
     
    render({:template=>"user/liked_photos.html.erb"})
  end

  def feed
    user = params.fetch("username")
    matching_user = User.where({ :username => user }).first
    @the_user = matching_user
    @accepted_follow_request_count = @current_user.sentfollowrequests.where({ :status => "accepted"}).count
    @accepted_follow_request = @current_user.sentfollowrequests.where({ :status => "accepted"})
    render({:template=>"user/feed.html.erb"})
  end
  def discover
    
    
    render({:template=>"user/discover.html.erb"})
  end

end

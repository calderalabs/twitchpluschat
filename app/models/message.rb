class Message < ActiveRecord::Base
  belongs_to :user

  def emoticon_set_ids
    user.emoticon_set_ids
  end

  def user_id
    user.name
  end
end

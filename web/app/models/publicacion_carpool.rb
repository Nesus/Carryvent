class PublicacionCarpool < ActiveRecord::Base
  belongs_to :user_evento
  #has_many :comment
  acts_as_commentable
end

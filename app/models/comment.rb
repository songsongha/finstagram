class Comment < ActiveRecord::Base

    belongs_to :user
    belongs_to :finstagram_post

    # this prevents comments being added tot he database that don't have text, user or finstagram_post attributes
    validates_presence_of :text, :user, :finstagram_post

    
end

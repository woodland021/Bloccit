class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :sponsored_posts
end

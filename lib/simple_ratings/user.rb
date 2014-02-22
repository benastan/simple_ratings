module SimpleRatings
  class User < Struct.new(:id)
    # def ratings
    #   Rating.where(user_id: id)
    # end
  end
end
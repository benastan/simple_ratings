require 'spec_helper'

describe SimpleRatings::Rating do
  def create(attrs)
    SimpleRatings::Rating.create(attrs)
  end

  describe '.where_venue' do
    let!(:old_rating) { create venue_id: 'a', user_id: 1, stars: 4 }
    
    let!(:rating) { create venue_id: 'a', user_id: 1, stars: 4 }
    
    let!(:other_user_rating) { create venue_id: 'a', user_id: 2, stars: 4 }
    
    let!(:other_venue_rating) { create venue_id: 'b', user_id: 1, stars: 4 }
    
    subject(:venue_ratings) { SimpleRatings::Rating.where_venue('a').all }

    it { should_not include old_rating }
    
    it { should include rating }
    
    it { should include other_user_rating }
    
    it { should_not include other_venue_rating }
  end
end

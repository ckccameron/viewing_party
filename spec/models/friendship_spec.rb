require 'rails_helper'

describe Friendship do
  describe "relationships" do
    it {should belong_to(:user)}
  end

  describe ".methods" do
    it "can create friendship reciprocal" do
      user1 = create(:user)
      user2 = create(:user)

      expect(Friendship.all.count).to eq(0)

      Friendship.create_friendships_reciprocal(user1.id, user2.id)
      
      expect(Friendship.all.count).to eq(2)
    end
  end
end

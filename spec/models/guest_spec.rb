require 'rails_helper'

describe Guest do
  describe 'validations' do
    it { should validate_inclusion_of(:is_host).in_array([true, false]) }
  end

  describe 'relationships' do
    it { should belong_to :party }
    it { should belong_to :user }
  end

  describe 'class methods' do
    it '#create_invites' do
      host = create(:user)
      friend1 = create(:user)
      friend2 = create(:user)

      party = create(:party)
      party_params = { party: { guests: [friend1.email, friend2.email] } }

      Guest.create_invites(party_params, host, party)

      expect(Guest.first.user_id).to eq(host.id)
      expect(Guest.all[1].user_id).to eq(friend1.id)
      expect(Guest.all[2].user_id).to eq(friend2.id)
      expect(Guest.first.party_id).to eq(party.id)
    end
  end
end

require 'rails_helper'

describe Party do
  describe 'validations' do
    it { should validate_presence_of(:movie_id) }
    it { should validate_presence_of(:movie_title) }
    it { should validate_presence_of(:duration) }
    it { should validate_numericality_of(:duration) }
    it { should validate_presence_of(:datetime) }
  end

  describe 'relationships' do
    it { should have_many :guests }
  end

  describe 'class methods' do
    it '#format_datetime' do
      raw_datetime = {"date(1i)"=>"2021", "date(2i)"=>"1", "date(3i)"=>"31", "date(4i)"=>"10", "date(5i)"=>"45"}
      result = Party.format_datetime(raw_datetime)
      expect(result).to be_a(DateTime)
      expect(result).to eq("2021/1/31 10:45".to_datetime)
    end

    it '#format_params' do
      params = {"utf8"=>"✓", "movie_id"=>"550", "movie_title"=>"Fight Club", "duration"=>"139", "party"=>{"date(1i)"=>"2021", "date(2i)"=>"1", "date(3i)"=>"31", "date(4i)"=>"10", "date(5i)"=>"45", "guests"=>["", "birdperson@hotmail.com", "terry_scary@yahoo.com"]}, "commit"=>"Create This Party", "controller"=>"parties", "action"=>"create"}.symbolize_keys

      datetime = "2021/1/31 10:45".to_datetime
      expected = { movie_id: 550, duration: 139, datetime: datetime, movie_title: "Fight Club" }
      expect(Party.format_params(params)).to eq(expected)
    end

    describe '#query_method' do
      before :each do
        @host1 = create(:user)
        @friend1 = create(:user)
        @friend2 = create(:user)

        @host2 = create(:user)
        @friend3 = create(:user)
        @friend4 = create(:user)

        @party1= create(:party)
        @party2= create(:party)
        @party3= create(:party)
        @party4= create(:party)

        create(:guest, party_id: @party1.id, user_id: @host1.id, is_host: true)
        create(:guest, party_id: @party2.id, user_id: @host1.id, is_host: true)
        create(:guest, party_id: @party3.id, user_id: @host2.id, is_host: true)
        create(:guest, party_id: @party4.id, user_id: @host2.id, is_host: true)
        create(:guest, party_id: @party1.id, user_id: @friend1.id, is_host: false)
        create(:guest, party_id: @party1.id, user_id: @friend2.id, is_host: false)
        create(:guest, party_id: @party1.id, user_id: @host2.id, is_host: false)
        create(:guest, party_id: @party2.id, user_id: @friend4.id, is_host: false)
        create(:guest, party_id: @party3.id, user_id: @host1.id, is_host: false)
      end

      it "returns parties that a user is hosting" do
        expect(Party.host_is(@host1)).to eq([@party1, @party2])
        expect(Party.host_is(@friend1)).to eq([])
      end

      it "returns parties that a user is guest" do
        expect(Party.guest_is(@host1)).to eq([@party3])
        expect(Party.guest_is(@friend3)).to eq([])
      end
    end
  end
end

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
  end
end

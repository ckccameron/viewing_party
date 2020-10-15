class Party < ApplicationRecord
  has_many :guests, dependent: :destroy

  validates :movie_id, :duration, :datetime, :movie_title, presence: true
  validates :duration, numericality: true
  validates_date :datetime, on_or_after: -> { Time.zone.today }

  def self.format_params(data)
    {
      movie_id: data[:movie_id].to_i,
      duration: data[:duration].to_i,
      datetime: format_datetime(data[:party]),
      movie_title: data[:movie_title]
    }
  end

  def self.format_datetime(data)
    date = [data['date(1i)'], data['date(2i)'], data['date(3i)']].join('/')
    time = [data['date(4i)'], data['date(5i)']].join(':')
    datetime = date + ' ' + time
    datetime.to_datetime
  end

  def self.host_is(current_user)
    Party.where("guests.user_id = #{current_user.id} and guests.is_host = true").joins(:guests)
  end

  def self.guest_is(current_user)
    Party.where("guests.user_id = #{current_user.id} and guests.is_host = false").joins(:guests)
  end
end

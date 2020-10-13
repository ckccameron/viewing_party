class Party < ApplicationRecord
  has_many :guests

  validates_presence_of :movie_id, :duration, :datetime, :movie_title
  validates_numericality_of :duration
  validates_date :datetime, on_or_after: lambda { Date.today }

  def self.format_params(data)
    {
      movie_id: data[:movie_id].to_i,
      duration: data[:duration].to_i,
      datetime: format_datetime(data[:party]),
      movie_title: data[:movie_title]
    }
  end

  def self.format_datetime(data)
    date = [data["date(1i)"], data["date(2i)"], data["date(3i)"]].join('/')
    time = [data["date(4i)"], data["date(5i)"]].join(':')
    datetime = date + ' ' + time
    datetime.to_datetime
  end
end

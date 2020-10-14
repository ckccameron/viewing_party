class Guest < ApplicationRecord
  belongs_to :party
  belongs_to :user

  validates :is_host, inclusion: { in: [true, false] }

  def self.create_invites(party_params, current_user, party)
    Guest.create({ user_id: current_user.id, party_id: party.id, is_host: true })
    guests_emails = party_params[:party][:guests]
    guests_emails.delete("")
    guests_emails.each do |email|
      guest = User.find_by(email: email)
      Guest.create({ user_id: guest.id, party_id: party.id })
    end
  end
end

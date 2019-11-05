class Attendance < ApplicationRecord

  belongs_to :user #Une participation appartient à un utilisateur
  belongs_to :event # et un événement.

  after_create :new_attendee

  def new_attendee
    AdminMailer.new_attendee(self).deliver_now
  end

end

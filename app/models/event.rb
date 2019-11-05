class Event < ApplicationRecord

## has_one_attached :picture

belongs_to :user admin, class_name: "User"

has_many :attendances # Un événement appartient à un administrateur (utilisateur).
has_many :users, through: :attendances # Un événement a plusieurs participations, et plusieurs participants (utilisateurs) au travers des participations.

## validates :user_id, presence: true

validates :start_date,
  presence: true
  validate :start_must_be_future # et il est impossible de créer ou modifier un événement dans le passé.

validates :duration,
  presence: true,
  numericality: { only_integer: true, greater_than: 0 } #strictment positif
  validate :duration_must_be_multiple_of_5 # le nombre de minutes doit être un multiple de 5

validates :title, length: {in: 5..140}, # il doit faire au moins 5 caractères et maxi 140 caractères
  presence: true

validates :description, length: {in: 20..1000}, # la description doit faire entre 20 et 1000 caractères.
  presence: true

validates :price, inclusion: 1..1000, # integer doit être compris entre 1 et 1000. (pas d'événement gratuit pour cette première version de l'application
  presence: true

validates :location,
  presence: true

## validate :has_picture

private
    #Valider que la date de début est bien dans le futur
    def start_must_be_future
      return if start_date.blank? #On sort de la boucle si start_date est vide

      if start_date < Time.now
        errors.add(:start_date, "cannot be past")
      end
    end
    #Duration is multiple of 5
    def duration_must_be_multiple_of_5
      return if duration.blank? #On sort si la fonction est vide
  ​
      if duration % 5 != 0
        errors.add(:duration, "Duration has to be multiple of 5")
      end
    end
end
###########
# Méthode pour calculer la end_date de l'event.
# def end_date
# 	start_date + duration * 60
# end

# def is_coming?(user)
#   if self.attendances.where(user_id: user.id).count > 0
#     return true
#   else
#     return false
#   end
# end
#
# def has_picture
#   if self.picture.attached? == false
#     errors.add(:picture, "Avec une photo c'est plus sympa !")
#   end
# end

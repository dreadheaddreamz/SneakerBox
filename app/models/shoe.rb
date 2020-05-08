class Shoe < ActiveRecord::Base
    validates :name, presence: true
    validates :date, presence: true
    validates :brand, presence: true
    validates :release, presence: true
    validates :hyperating, presence: true
    belongs_to :user




end
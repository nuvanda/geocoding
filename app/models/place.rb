class Place < ActiveRecord::Base
  attr_accessor :raw_address

  belongs_to :user

  geocoded_by :address, if: ->(obj) { obj.address.present? and obj.address_changed? }
  reverse_geocoded_by :latitude, :longitude

  after_validation :geocode
  after_validation :reverse_geocode, unless: ->(obj) { obj.address.present? },
                   if: ->(obj){ obj.latitude.present? and obj.latitude_changed? and obj.longitude.present? and obj.longitude_changed? }
end

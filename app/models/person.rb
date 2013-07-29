# encoding: utf-8
require "digest/sha1"

class Person < ActiveRecord::Base
  #for multiple table inheritance gem (ActsAsRelation)
  acts_as_superclass

  #relationships
  has_many :hours

  #attributes
  attr_accessible :address, :city, :email, :first_name, :last_name, :phone, :plain_password, :latitude, :longitude
  attr_protected :password

  #validations
  validates :first_name, :last_name, presence: true
  validates :address, presence: true,
            allow_blank: false
  validates :email, presence: true,
            uniqueness: true,
            format: { with: /^[a-zA-Z0-9_.-]+@([a-zA-Z0-9_ -]+\.)+[a-zA-Z]{2,4}$/ }
  validates_numericality_of :latitude, greater_than: -180.0, less_than_or_equal_to: 180.0
  validates_numericality_of :longitude, greater_than: -85.0, less_than_or_equal_to: 85.0

  #methods
  def plain_password=(password)
    return if password.nil?
    self.encrypt_password(password)
  end
  def plain_password
    ""
  end
  def self.encrypt_password(password)
    Digest::SHA1.hexdigest("a1#{password}2b")
  end
  def authenticate(username, password)
    where("?")
  end
end

# encoding: utf-8
require "digest/sha1"

class User < ActiveRecord::Base

  #associations
  belongs_to :company
  has_many :checkings, dependent: :destroy
  accepts_nested_attributes_for :checkings

  #attributes
  attr_accessible :street, :city, :email, :first_name, :last_name, :phone, :latitude, :longitude, :number, :company_id, :username, :hour_value
  attr_protected :password

  #geolocation
  # geocoded_by :full_address
  # after_save :geocode

  # validations
  validates :first_name, :last_name, :username, presence: true
  validates :username, uniqueness: true, format: { with: /^[a-z0-9_-]{3,25}$/ }
  validates :street, presence: true, allow_blank: false
  validates :hour_value, presence: true, allow_blank: false
  validates :email, presence: true, uniqueness: true, format: { with: /^[a-zA-Z0-9_.-]+@([a-zA-Z0-9_ -]+\.)+[a-zA-Z]{2,4}$/ }
  validates_numericality_of :latitude, greater_than: -180.0, less_than_or_equal_to: 180.0, allow_nil: true
  validates_numericality_of :longitude, greater_than: -180.0, less_than_or_equal_to: 180.0, allow_nil: true
  validates_numericality_of :hour_value, greater_than: 0.0

  #scopes
  scope :employees, ->(company_id) { where(["manager=? and company_id=?", false, company_id]) }

  #methods
  def location_ok?(x,y)
    ((latitude-0.001..latitude).include?(x) || (latitude..latitude+0.001).include?(x)) && ((longitude-0.001..longitude).include?(y) || (longitude..longitude+0.001).include?(y))
  end

  def full_address
    "#{number}, #{street}, #{city}"
  end

  def name
    "#{first_name} #{last_name}"
  end

  def plain_password=(password)
    return if password.nil?
    self.password = self.class.encrypt_password(password)
  end

  def plain_password
    ""
  end

  def self.authenticate(options)
    password = options[:password]
    username = options[:username]
    where("(email=? and password=?) or (username=? and password=?)", username, encrypt_password(password), username, encrypt_password(password)).first
  end

  def self.encrypt_password(password)
    Digest::SHA1.hexdigest("a1#{password}2b")
  end
end

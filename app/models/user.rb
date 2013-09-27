# encoding: utf-8
require "digest/sha1"

class User < ActiveRecord::Base

  #associations
  belongs_to :company
  has_one :task, dependent: :destroy
  has_many :checkings, through: :task

  accepts_nested_attributes_for :checkings

  #attributes
  attr_accessible :first_name, :last_name, :username, :email, :street, :city, :number, :latitude, :longitude, :manager, :company_id
  attr_protected :password

  #address geolocation
  geocoded_by :full_address
  after_validation :geocode

  #callbacks
  before_update :check_changed_attributes

  #validations
  [:first_name, :last_name, :password, :username, :email, :street, :city, :number].each do |v|
    validates v, presence: true
  end

  validates :username, uniqueness: true, format: { with: /^[a-z0-9_-]{3,35}$/ }
  validates :email, uniqueness: true, format: { with: /^[a-zA-Z0-9_.-]+@([a-zA-Z0-9_ -]+\.)+[a-zA-Z]{2,4}$/ }
  validates :plain_password, format: { with: /^[a-zA-Z0-9_-]{3,25}$/ }

  #scopes
  scope :employees, ->(company_id) { where(["manager=? and company_id=?", false, company_id]) }

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
    return if password.blank? || password.nil?
    self.password = self.class.encrypt_password(password)
  end

  def plain_password
    "blabla"
  end

  def check_changed_attributes
    @changed_to = self.changes
  end

  def changed_to=(value)
    @changed_to = value
  end

  def changed_to
    @changed_to
  end

  def self.authenticate(options)
    password = options[:password]
    username = options[:username]
    where("(email=? and password=?) or (username=? and password=?)", username, encrypt_password(password), username, encrypt_password(password)).first
  end

  def self.encrypt_password(password)
    Digest::SHA1.hexdigest("a1#{password}2b")
  end

  def self.with_no_task(company_id)
    array = Array.new
    self.employees(company_id).each do |u|
      array << u unless u.task
    end
    array
  end
end

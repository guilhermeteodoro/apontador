# encoding: utf-8
require "digest/sha1"

class Person < ActiveRecord::Base
  has_many :hours

  attr_accessible :address, :city, :cpf, :email, :first_name, :last_name, :phone, :plain_password, :latitude, :longitude, :admin, :institution
  attr_protected :password

  validates :first_name, :last_name, presence: true
  validates :email, presence: true,
            uniqueness: true,
            format: { with: /^[a-zA-Z0-9_.-]+@([a-zA-Z0-9_ -]+\.)+[a-zA-Z]{2,4}$/ }
  validates_length_of :cpf, minimum: 11, maximum: 11
  validates_numericality_of :latitude, greater_than: -180.0, less_than_or_equal_to: 180.0
  validates_numericality_of :longitude, greater_than: -85.0, less_than_or_equal_to: 85.0
  validates :institution, presence: true,
            if: :admin?

  def admin?
    return admin
  end
  def plain_password=(pass)
    return if pass.nil?
    self.encrypt_password(pass)
  end
  def plain_password
    ""
  end
  def self.encrypt_password(password)
    Digest::SHA1.hexdigest("a1#{password}2b")
  end

end

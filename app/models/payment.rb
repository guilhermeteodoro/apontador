class Payment < ActiveRecord::Base

  #associations
  belongs_to :user
  has_many :checkings, through: :user

  #attributes
  attr_accessible :concluded, :token, :user_id

  #validations
  validates :token, uniqueness: true

  #class variables
  @@symbols_array = [('a'..'z'),('A'..'Z'),(0..9)].map{|i| i.to_a}.flatten


  def token=(*value)
    write_attribute(:token, self.class.token_generator) if read_attribute(:token).nil?
  end

  def self.token_generator
    loop do
      token = (0...20).map{ @@symbols_array[rand(@@symbols_array.length)] }.join
      break token unless Payment.where(token: token).exists?
    end
  end

end

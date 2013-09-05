class Payment < ActiveRecord::Base

  #associations
  belongs_to :user
  has_many :checkings, through: :user

  #attributes
  attr_accessible :concluded, :date, :token_generated

  #validations


  def initializer
    symbols_array = [('a'..'z'),('A'..'Z'),(0..9)].map{|i| i.to_a}.flatten
    token_generated = false
  end

  def generate_token
    self.token = (0...20).map{ symbols_array[rand(symbols_array.length)] }.join if token_generated
    token_generated = true
  end

  def token
    self.token
  end

end

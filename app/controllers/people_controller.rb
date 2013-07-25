class PeopleController < ApplicationController
  respond_to :html

  def index
    @people = Person.all
    respond_with @people
  end
end

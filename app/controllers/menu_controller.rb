class MenuController < ApplicationController
  def show
    Menu.new
    binding.pry
  end
end
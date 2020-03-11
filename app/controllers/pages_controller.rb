class PagesController < ApplicationController
  def splash
    @lines = File.readlines("public/list.txt").reverse
  end
end


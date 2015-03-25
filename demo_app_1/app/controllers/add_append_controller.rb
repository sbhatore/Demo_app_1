# This controller has methods for add and append pages of the application
class AddAppendController < ApplicationController
  def home
  end

  def append
  end

  def add
  end

  def view_appended
    if cookies.signed[:appended]
      cookies.signed[:appended] <<= (params[:input].to_s)
    else
      cookies.signed[:appended] = params[:input].to_s
    end
    @appended = cookies.signed[:appended].to_i
  end

  def view_added
    if cookies.signed[:added]
      cookies.signed[:added] = (cookies.signed[:added].to_i + params[:input].to_i).to_s
    else
      cookies.signed[:added] = params[:input].to_s
    end
    @added = cookies.signed[:added].to_i
  end
end

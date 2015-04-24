class PingPongController < ApplicationController
  def home
  end

  def selected_no
  	if !params[:ping_pong].nil?
  	
  		number=params[:ping_pong][:number]
  	redirect_to offend_path(number:number)
  	end
  end

  def selected_array

  	if !params[:ping_pong].nil?
  		@numbers=params[:ping_pong][:numbers]
      store_array(@numbers)
      redirect_to defend_path
  	end


  end
end

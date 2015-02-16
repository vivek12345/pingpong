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
  		numbers=params[:ping_pong][:numbers]
  		my_numbers=numbers.split(',')
  		defend_numbers={
  			numbers:my_numbers.map do |n|
  			{
  				d_number:n
  			}
  			end
  		}
  		redirect_to defend_path(defend_numbers)
  	end


  end
end

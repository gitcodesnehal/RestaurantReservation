class ReservationsController < ApplicationController
	
	@@tables=10 #Total number of tables in restaurant
	@@table_Capacity=8 #Table capacity is maximum 8 people
	@@can_reserve=true #check if reservation can be done
	def get_tables
		@@tables
	end
	def get_can_reserve
		@@can_reserve
	end

	def index
		#Reservation.delete_all       #Uncomment this to clear the database table
		@reservations=Reservation.all
	end

	def show
			#@reservation=Reservation.find(params[:id])
	end


	def create
		if @@tables!=0
			if params[:reservation][:people].to_i>0 && params[:reservation][:people].to_i<@@table_Capacity
				tables_required=1
			else
				tables_required=((params[:reservation][:people].to_i).to_f/8).ceil
			end
			@@tables=@@tables-tables_required
			#if tables available for reservtion
			if @@tables>=0
				@reservation=Reservation.new(reservation_params)
				@reservation.save
				@@can_reserve=true
			#if tables not available for reservation
			else
				@@tables=@@tables+tables_required
				@reservation=Reservation.new()
				@reservation.save
				@@can_reserve=false
			end
			redirect_to @reservation
		end
	end

	private def reservation_params
		params.require(:reservation).permit(:name, :people, :res_time)
	end


end

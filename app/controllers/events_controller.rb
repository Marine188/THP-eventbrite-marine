class EventsController < ApplicationController

  def index
    @events = Event.all
  end
  def new
  		@event = Event.new
  	end

  	def create
  		@event = Event.new(user: current_user, start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location])
  		@event.save
  		@event.picture.attach(params[:picture])

  		if @event.save
  			redirect_to event_path(@event)
  			flash[:success] = "Your event has been successfully created"
  		else
  			render 'new'
  		end
  	end

  	def show
  		@event = Event.find(params[:id])
  	end

  	def edit
  		@event = Event.find(params[:id])
  	end

  	def update
  		@event = Event.find(params[:id])

  		if @event.update(admin: current_user, start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location])
  			redirect_to event_path
  			flash[:success] = "Your event has been successfully edited"
  		else
  			render :edit
  		end
  	end

  	def destroy
  		@event = Event.find(params[:id])
  		@event.destroy
  		redirect_to root_path
  	end
end

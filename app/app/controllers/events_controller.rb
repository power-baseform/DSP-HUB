## Baseform
## Copyright (C) 2018  Baseform

## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.


class EventsController < Admin::UsersController
  before_action :set_challenge

  def edit
    @event = Event.find(params[:id])
    @currentTab = "events"
  end

  def new
    @event = Event.new
  end

  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to edit_event_challenge_path(challenge: @challenge, event: @event), notice: 'Event was successfully updated.' }
        format.json { render :edit  , status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @event = Event.new(event_params)
    @event.challenge = @challenge

    respond_to do |format|
      if @event.save
        format.html { redirect_to edit_challenge_path(@challenge, tab: "events"), notice: 'Event was successfully created.' }
        format.json { render :edit, status: :created, location: @challenge }
      else
        format.html { render :edit_section }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.destroy
        format.html { redirect_to edit_challenge_path(@challenge, tab: 'events'), notice: 'Event was successfully destroyed.' }
        format.json { render :index  , status: :ok, location: @event }
      else
        format.html { render :index }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def event_params
    params.require(:event).permit(:data, :designacao, :local)
  end
end

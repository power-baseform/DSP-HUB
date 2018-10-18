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


class ParticipantsController < Admin::UsersController
  before_action :set_participant, only: [:show, :edit, :update, :destroy, :reset_gamification]
  helper_method :sort_column, :sort_direction

  # GET /participants
  # GET /participants.json
  def index
    @participants = current_system.participants
    if params[:search].present?
      @participants = Participant.search_for(params[:search])
      @participants = @participants.where(pkid: current_system.participant_ids)
    end
    @participants = @participants.order(sort_column + " " + sort_direction).page params[:page]
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
    @logs = @participant.logs.where(system_id: current_system.id).order(timestamp: :desc).page params[:page]
  end

  # GET /participants/new
  def new
    @participant = Participant.new
  end

  # GET /participants/1/edit
  def edit
  end

  def reset_gamification
    return redirect_to @participant, notice: 'Gamification was successfully reseted' if @participant.reset_gamification current_system
    redirect_to @participant, notice: 'Something went wrong'
  end

  # POST /participants
  # POST /participants.json
  def create
    @participant = Participant.new(participant_params)

    respond_to do |format|
      if @participant.save
        format.html { redirect_to @participant, notice: 'Participant was successfully created.' }
        format.json { render :show, status: :created, location: @participant }
      else
        format.html { render :new }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participants/1
  # PATCH/PUT /participants/1.json
  def update
    respond_to do |format|
      if @participant.update(participant_params)
        format.html { redirect_to @participant, notice: 'Participant was successfully updated.' }
        format.json { render :show, status: :ok, location: @participant }
      else
        format.html { render :edit }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant.toggle
    @participant.save
    respond_to do |format|
      format.html { redirect_to @participant, notice: "Participant was successfully #{@participant.activo ? "activated." : "disabled."}" }
      format.json { head :no_content }
    end
  end

  private
    def sort_column
      Participant.column_names.include?(params[:sort]) ? params[:sort] : "nome"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:id])
      redirect_to root_path if !current_user.can_see_any(@participant.systems)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_params
      params.fetch(:participant, {})
    end
end

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


class ChallengesController < Admin::UsersController
  before_action :set_challenge, only: [:show, :edit, :update, :destroy, :gamification, :download_gamification]
  before_action :set_current_tab, only: [:edit, :edit_section]
  helper_method :sort_column, :sort_direction

  def index
    @challenges = Challenge.all
    @challenges = @challenges.with_locale(current_locale)
    @challenges = @challenges.with_system(current_system)
    @challenges = @challenges.search_for(params[:search]) if params[:search].present?
    @challenges = @challenges.order(sort_column + " " + sort_direction).page params[:page]
  end

  def show
    redirect_to edit_challenge_path(@challenge)
  end

  def new
    @challenge = Challenge.new
  end

  def download_gamification
    gamification = GamificationReader.new current_system
    send_data gamification.export(@challenge), filename: "gamification_#{@challenge.codigo}.xlsx", disposition: 'attachment'
  end

  def gamification
    gamification = GamificationUpdate.new(@challenge, params[:gamification_form])
    new_gamififcation = gamification.safe_params
    @challenge.gamification = new_gamififcation.to_json
    respond_to do |format|
      if @challenge.save
        format.html { redirect_to edit_challenge_path(@challenge, tab: "game"), notice: 'Challenge gamification was successfully created.' }
        format.json { render :edit, status: :created, location: @challenge }
      else
        format.html { redirect_to :back, notice: "Something went wrong"}
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @currentTab = "issue" unless @currentTab.present?
  end

  def create
    @challenge = Challenge.new(challenge_params)

    respond_to do |format|
      if @challenge.save
        save_tags
        format.html { redirect_to edit_challenge_path(@challenge), notice: 'Challenge was successfully created.' }
        format.json { render :edit, status: :created, location: @challenge }
      else
        flash.now[:alert] = "#{@challenge.errors.size} errors on this challenge."
        format.html { render :new }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @challenge.update(challenge_params)
        save_tags
        format.html { redirect_to edit_challenge_path(@challenge), notice: 'Challenge was successfully updated.' }
        format.json { render :edit, status: :ok, location: @challenge }
      else
        @currentTab = "issue"
        format.html { render :edit }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to challenges_url, notice: 'Challenge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def sort_column
      Challenge.column_names.include?(params[:sort]) ? params[:sort] : "codigo"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def save_tags
      tag_ids = params[:challenge][:tag_ids].reject(&:empty?)

      removed_ids = @challenge.tag_ids - tag_ids
      @challenge.challenge_tags.where(tag_fk: removed_ids).delete_all
      new_ids = tag_ids - @challenge.tag_ids
      new_ids.each do |t|
        ChallengeTag.create(tag_fk: t, challenge: @challenge)
      end

      @challenge.save
    end

    def set_current_tab
      @currentTab = params[:tab]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_challenge
      @challenge = Challenge.find(params[:id])
      redirect_to root_path if !current_user.can_see(@challenge.system)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def challenge_params
      params.require(:challenge).permit(:titulo, :codigo, :descricao, :fkscope, :data_inicio, :data_fim, :publicado, :sistema, :fk_city, :locale, :hashtags, :shape_url, :shape_mobile_url, :mapontop, :type, :image, :comments_title, :comments_description, :gamification_chart_iframe)
    end
end

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


class CommunityChallengesController < Admin::UsersController
  before_action :set_community_challenge, only: [:show, :edit, :update, :destroy]

  # GET /community_challenges
  # GET /community_challenges.json
  def index
    @community_challenges = CommunityChallenge.all.page params[:page]
  end

  # GET /community_challenges/1
  # GET /community_challenges/1.json
  def show
    redirect_to edit_community_challenge_path(@community_challenge)
  end

  # GET /community_challenges/new
  def new
    @community_challenge = CommunityChallenge.new
  end

  # GET /community_challenges/1/edit
  def edit
  end

  # POST /community_challenges
  # POST /community_challenges.json
  def create
    @community_challenge = CommunityChallenge.new(community_challenge_params)

    respond_to do |format|
      if @community_challenge.save
        format.html { redirect_to @community_challenge, notice: 'Community challenge was successfully created.' }
        format.json { render :show, status: :created, location: @community_challenge }
      else
        format.html { render :new }
        format.json { render json: @community_challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /community_challenges/1
  # PATCH/PUT /community_challenges/1.json
  def update
    respond_to do |format|
      if @community_challenge.update(community_challenge_params)
        format.html { redirect_to @community_challenge, notice: 'Community challenge was successfully updated.' }
        format.json { render :show, status: :ok, location: @community_challenge }
      else
        format.html { render :edit }
        format.json { render json: @community_challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /community_challenges/1
  # DELETE /community_challenges/1.json
  def destroy
    @community_challenge.destroy
    respond_to do |format|
      format.html { redirect_to community_challenges_url, notice: 'Community challenge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community_challenge
      @community_challenge = CommunityChallenge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def community_challenge_params
      params.require(:community_challenge).permit(:processo_fk)
    end
end

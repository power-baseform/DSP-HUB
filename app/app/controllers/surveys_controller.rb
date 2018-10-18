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


class SurveysController < Admin::UsersController
  before_action :set_challenge

  def edit
    @survey = Survey.find(params[:id])
    @currentTab = "surveys"
  end

  def new
    @survey = Survey.new
  end

  def update
    @survey = Survey.find(params[:id])
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to edit_survey_challenge_path(challenge: @challenge, survey: @survey), notice: 'Survey was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def create
    @survey = Survey.new(survey_params)
    @survey.challenge = @challenge
    @survey.survey_type = SurveyType.first
    @survey.repetivel = false

    respond_to do |format|
      if @survey.save
        format.html { redirect_to edit_challenge_path(@challenge, tab: "surveys"), notice: 'Survey was successfully created.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @survey = Survey.find(params[:id])
    respond_to do |format|
      if @survey.destroy
        format.html { redirect_to edit_challenge_path(@challenge, tab: 'surveys'), notice: 'Survey was successfully destroyed.' }
      else
        format.html { render :index }
      end
    end
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def survey_params
    params.require(:survey).permit(:data_abertura, :data_fim, :nome, :info_introdutoria, :observacoes)
  end

end

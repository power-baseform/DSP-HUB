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


class AnswersController < Admin::UsersController
  before_action :set_challenge, :set_survey, :set_answer, :set_current_tab

  def show

  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_current_tab
    @currentTab = "surveys"
  end

end

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


class ItemsController < Admin::UsersController
  before_action :set_challenge, :set_survey, :set_current_tab

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to edit_challenge_survey_item_path(@challenge, @survey, @item), notice: "Item was successfully created" }
      else
        format.html { render :edit }
      end
    end
  end

  def create
    @item = Item.new(item_params)
    @item.survey = @survey

    respond_to do |format|
      if @item.save
        format.html { redirect_to edit_challenge_survey_item_path(@challenge, @survey, @item), notice: "Item was successfully created" }
      else
        format.html { render :new, alert: @item.errors }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      respond_to do |format|
        format.html { redirect_to edit_challenge_survey_path(@challenge, @survey), notice: 'Item was successfully destroyed.'}
      end
    end
  end

  private

  def set_current_tab
    @currentTab = "surveys"
  end

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def set_survey
    @survey = @challenge.surveys.find(params[:survey_id])
  end


  def item_params
    params.require(:item).permit(:codigo, :nome, :info, :fk_tipo, :opcoes)
  end

end

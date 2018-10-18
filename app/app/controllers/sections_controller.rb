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


class SectionsController < Admin::UsersController
  before_action :set_challenge, :set_current_tab
  skip_before_filter :verify_authenticity_token, only: :handle_upload

  def edit
    @section = Section.find(params[:id])
  end

  def new
    redirect_to :back, alert: "Too many sections" if @challenge.sections.size >= 8 || (@challenge.system.is_best_practice && @challenge.sections.size >= 6)
    @section = Section.new
  end

  def destroy
    @section = Section.find(params[:id])
    respond_to do |format|
      if @section.destroy
        format.html { redirect_to edit_challenge_path(@challenge, tab: "sections"), notice: 'Section was successfully deleted.' }
        format.json { render :index, status: :created, location: @challenge }
      else
        format.html { render :index }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @section = Section.new(section_params)
    @section.challenge = @challenge

    respond_to do |format|
      if @section.save
        format.html { redirect_to edit_challenge_path(@challenge, tab: "sections"), notice: 'Section was successfully created.' }
        format.json { render :edit, status: :created, location: @challenge }
      else
        format.html { render :edit_section }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @section = Section.find(params[:id])
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to edit_challenge_section_path(challenge: @challenge, section: @section), notice: 'Section was successfully updated.' }
        format.json { render :edit_section  , status: :ok, location: @section }
      else
        format.html { render :edit_section }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end


  def handle_upload
    doc = Document.new
    doc.tipo = 2
    doc.document = params[:file]
    doc.data = Date.today
    doc.designacao = ''
    doc.challenge = @challenge

    return render json: { location: public_document_path(id: doc.id)}, :status => 200 if doc.save
    render json: {}, :status => 400
  end


  private

  def set_current_tab
    @currentTab = "sections"
  end

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def section_params
    params.require(:section).permit(:titulo, :indice, :corpo)
  end

end

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


class DocumentsController < Admin::UsersController
  before_action :set_challenge

  def edit
    @document = Document.find(params[:id])
    @currentTab = "docs"
  end

  def new
    @document = Document.new
  end

  def update
    @document = Document.find(params[:id])
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to edit_challenge_document_path(challenge: @challenge, document: @document), notice: 'Document was successfully updated.' }
        format.json { render :edit_document  , status: :ok, location: @document }
      else
        format.html { render :edit_document }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @document = Document.new(document_params)
    @document.challenge = @challenge
    @document.tipo = 1

    respond_to do |format|
      if @document.save
        format.html { redirect_to edit_challenge_document_path(challenge: @challenge, id: @document), notice: 'Document was successfully created.' }
        format.json { render :edit_document, status: :created, location: @challenge }
      else
        format.html { render :edit_document }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @document = Document.find(params[:id])
    respond_to do |format|
      if @document.destroy
        format.html { redirect_to edit_challenge_path(@challenge, tab: 'docs'), notice: 'Document was successfully destroyed.' }
        format.json { render :index  , status: :ok, location: @document }
      else
        format.html { render :index }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def document_params
    params.require(:document).permit(:data, :designacao, :file_type, :document)
  end
end

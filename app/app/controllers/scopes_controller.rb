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


class ScopesController < Admin::UsersController
  before_action :set_scope, only: [:show, :edit, :update, :destroy]

  # GET /scopes
  # GET /scopes.json
  def index
    @scopes = Scope.all.page params[:page]
  end

  # GET /scopes/1
  # GET /scopes/1.json
  def show
    redirect_to edit_scope_path(@scope)
  end

  # GET /scopes/new
  def new
    @scope = Scope.new
  end

  # GET /scopes/1/edit
  def edit
  end

  # POST /scopes
  # POST /scopes.json
  def create
    @scope = Scope.new(scope_params)

    respond_to do |format|
      if @scope.save
        format.html { redirect_to @scope, notice: 'Scope was successfully created.' }
        format.json { render :edit, status: :created, location: @scope }
      else
        format.html { render :new }
        format.json { render json: @scope.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scopes/1
  # PATCH/PUT /scopes/1.json
  def update
    respond_to do |format|
      if save_tags
        format.html { redirect_to @scope, notice: 'Scope was successfully updated.' }
        format.json { render :edit, status: :ok, location: @scope }
      else
        format.html { render :edit }
        format.json { render json: @scope.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scopes/1
  # DELETE /scopes/1.json
  def destroy
    @scope.destroy
    respond_to do |format|
      format.html { redirect_to scopes_url, notice: 'Scope was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def save_tags
      tag_ids = params[:scope][:tag_ids].reject(&:empty?)

      removed_ids = @scope.tag_ids - tag_ids
      @scope.scope_tags.where(tag_id: removed_ids).delete_all
      new_ids = tag_ids - @scope.tag_ids
      new_ids.each do |t|
        ScopeTag.create(tag_id: t, scope: @scope)
      end

      @scope.save
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_scope
      @scope = Scope.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scope_params
      params.require(:scope).permit()
    end
end

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


class UsersController < Admin::UsersController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :ensure_any_system

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @users = @users.search_for(params[:search]) if params[:search].present?
    @users = @users.page params[:page]
  end

  # GET /users/1
  # GET /users/1.json
  def show
    redirect_to edit_user_path(@user)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def import
    sheet = Roo::Spreadsheet.open(params[:file], extension: Rack::Mime::MIME_TYPES.invert[params[:file].content_type])
    headers = {}
    sheet.row(1).each_with_index do |h, i|
      headers[h] = i
    end

    c = User.count

    output = ""

    ActiveRecord::Base.transaction do
      (sheet.first_row + 1..sheet.last_row).each do |idx|
        row = sheet.row(idx)

        u = User.new
        u.email = row[headers["email"]]

        next if User.find_by(email: u.email).present? || u.email.size == 0

        u.name = row[headers["name"]]

        roles = row[headers["groups"]]

        if u.email.include? "eipcm.org"
          u.roles << Role.all
        else
          u.roles << Role.where(code: "Power City")
          roles.split(";").each do |role|
            r = Role.find_by(code: role)
            u.roles << r if r && u.roles.where(code: role).empty?
          end
        end

        password = (0...8).map { (65 + rand(26)).chr }.join

        u.password = password
        u.password_confirmation = password

        output += "#{u.email} | #{password} "

        u.save(validate: false)
      end
    end

    c = User.count - c

    logger.info output
    redirect_to users_path, notice: "Import Successfull : #{c} new users."
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.email = params[:user][:email]

    respond_to do |format|
      if @user.save && save_roles
        format.html { redirect_to edit_user_path(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_to new_user_path, alert: @user.errors }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    up = user_params
    respond_to do |format|
      up.delete(:password) && up.delete(:password_confirmation) if up[:password].size == 0
      if @user.update(up) && save_roles
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to @user }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def save_roles
      role_ids = params[:user][:role_ids].reject(&:empty?)

      removed_ids = @user.role_ids - role_ids
      @user.user_roles.where(role_id: removed_ids).delete_all
      new_ids = role_ids - @user.role_ids

      new_ids.each do |t|
        UserRole.create(role_id: t, user: @user)
      end

      @user.save
    end

    def is_admin?
      return redirect_to root_path, alert: 'Not enough permissions' unless current_user.admin?
      true
    end

    def is_current?
      redirect_to root_path, alert: 'Not enough permissions' unless current_user.admin? || current_user == @user
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end

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


class Admin::UsersController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :ensure_any_system, except: [:no_system]

  def index

  end

  def change_locale
    session[:locale] = params[:locale]
    respond_to :js
  end

  def change_system
    if current_user.can_see(System.find(params[:system]))
      session[:system_id] = params[:system]
    end

    return render status: :ok, json: {}
  end

  def no_system
    redirect_to root_path if current_system.present?
  end

  private

  def ensure_any_system
    redirect_to no_system_path, alert: 'Not enough permissions' if current_system.nil? && current_user.present?
  end
end

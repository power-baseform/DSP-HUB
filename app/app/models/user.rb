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


class User < ActiveRecord::Base
  include PgSearch
  paginates_per 20
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :timeoutable, :timeout_in => 30.minutes

  pg_search_scope :search_for, against: [:email]

  has_many :user_roles, foreign_key: :user_id
  has_many :roles, through: :user_roles

  def display_name
    name.present? ? name : email
  end

  def admin?
    roles.where(code: "Admin").present?
  end

  def roles_to_string
      roles.order(:code).pluck(:code).join(", ")
  end

  def can_see(sys)
    roles.pluck(:code).include? sys.name
  end

  def can_see_any sys
    sys.pluck(:name).any? { |sys| roles.pluck(:code).include? sys }
  end

  def initials
    if display_name.split(" ").size > 1
      names = display_name.split(" ")
      return "#{names[0].first}#{names[1].first}".upcase
    else
      return display_name.first(2).upcase
    end
  end

  def systems
    System.where(name: roles.pluck(:code))
  end

  def online!
    self.online = true
    self.save
  end

  def offline!
    self.online = false
    self.save
  end

  def is_online?
    return true if !timedout?(last_action) && last_action.present? && online
    return false if update(online: false)
  end
end

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


class System < ActiveRecord::Base
  has_many :challenges, foreign_key: :sistema
  has_many :about_sections, foreign_key: :sistema

  has_many :participant_systems, foreign_key: :fksistema
  has_many :participants, -> { uniq }, through: :participant_systems

  has_many :surveys, through: :challenges
  has_many :answers, through: :surveys

  has_many :comments, through: :challenges

  def has_code code
    return "" unless code.present?
    return "" unless challenges.find_by(pkid: code).present?
    code
  end

  def self.for_user(user)
    where(name: user.roles.pluck(:code))
  end

  def is_best_practice
    self.name == "Best Practices"
  end
end

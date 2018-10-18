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


class Participant < ActiveRecord::Base
  include PgSearch
  paginates_per 20

  pg_search_scope :search_for, against: %i(nome email)

  self.table_name = "participantes.participante"
  self.inheritance_column = :_type_disabled

  has_many :participant_challenges, foreign_key: :fkparticipante
  has_many :challenges, through: :participant_challenges

  has_one :user_avatar, foreign_key: :fkparticipante
  has_many :logs, foreign_key: :username, primary_key: :email

  has_many :participant_events, foreign_key: :fkparticipante
  has_many :events, through: :participant_events

  has_many :participant_systems, foreign_key: :fkparticipante

  def toggle
    self.activo = !self.activo
  end

  def systems
    System.where(id: participant_systems.pluck(:fksistema))
  end

  def reset_gamification curr_sys
    return true unless self.gamification.present?

    game = JSON.parse(self.gamification)
    game[curr_sys.id] = {}
    self.gamification = game.to_json
    self.save
  end
end

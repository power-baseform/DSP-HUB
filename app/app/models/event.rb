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


class Event < ActiveRecord::Base
  include SequencePrimaryKey
  paginates_per 20
  before_create :set_primary_key

  self.table_name = "processos.evento"
  self.inheritance_column = :_type_disabled

  belongs_to :challenge, foreign_key: :fkprocesso

  has_many :participant_events, foreign_key: :fkevento, dependent: :delete_all
  has_many :participants, through: :participant_events

  validates_length_of :designacao, maximum: 200 
end

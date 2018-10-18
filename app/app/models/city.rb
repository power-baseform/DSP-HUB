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


class City < ActiveRecord::Base
  include SequencePrimaryKey
  include PgSearch
  before_create :set_primary_key

  paginates_per 20
  pg_search_scope :search_for, against: %i(name country)

  self.table_name = "processos.city"
  self.inheritance_column = :_type_disabled

  has_many :challenges, foreign_key: :fk_city
end

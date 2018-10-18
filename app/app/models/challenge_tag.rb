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


class ChallengeTag < ActiveRecord::Base
  include SequencePrimaryKey
  before_create :set_primary_key
  self.inheritance_column = :_type_disabled
  self.table_name = "processos.processo_tags"

  belongs_to :tag, foreign_key: :tag_fk
  belongs_to :challenge, foreign_key: :processo_fk
end

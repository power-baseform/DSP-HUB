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


class Tag < ActiveRecord::Base
  paginates_per 40

  self.table_name = "processos.tag"
  self.inheritance_column = :_type_disabled

  has_many :scope_tags, foreign_key: :tag_id
  has_many :scopes, through: :scope_tags, foreign_key: :scope_id

  has_many :challenge_tags, foreign_key: :tag_fk
  has_many :challenges, through: :challenge_tags, foreign_key: :processo_fk

  has_many :community_challenge_tags, foreign_key: :tag_id
  has_many :community_challenges, through: :community_challenge_tags, foreign_key: :community_processo_id
end

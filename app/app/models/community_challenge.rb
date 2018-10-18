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


class CommunityChallenge < ActiveRecord::Base
  paginates_per 20

  self.table_name = "processos.community_processo"
  self.inheritance_column = :_type_disabled

  belongs_to :participant, foreign_key: :participante_fk
  belongs_to :challenge, foreign_key: :processo_fk
  belongs_to :scope, foreign_key: :scope_fk
  belongs_to :city, foreign_key: :city_fk

  has_many :community_challenge_tags, foreign_key: :community_processo_id
  has_many :tags, through: :community_challenge_tags

  has_many :community_challenge_images, foreign_key: :community_processo_fk
  has_many :images, through: :community_challenge_images, source: :thumbnail, class_name: 'TemporaryThumbnail'

  has_many :documents, foreign_key: :community_processo_fk, class_name: 'CommunityDocument'

  belongs_to :thumbnail, foreign_key: :temp_thumb_fk, class_name: 'TemporaryThumbnail'
end

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


class Survey < ActiveRecord::Base
  include SequencePrimaryKey
  paginates_per 20
  before_create :set_primary_key

  self.table_name = "basedados.formulario"
  self.inheritance_column = :_type_disabled

  has_many :answers, foreign_key: :fk_formulario, dependent: :destroy
  has_many :items, foreign_key: :fk_formulario, dependent: :destroy
  belongs_to :challenge, foreign_key: :fkprocesso
  belongs_to :survey_type, foreign_key: :fk_base_dados
end

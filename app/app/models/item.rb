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


class Item < ActiveRecord::Base
  include SequencePrimaryKey
  before_create :set_primary_key, :fill
  paginates_per 20

  self.table_name = "basedados.item"
  self.inheritance_column = :_type_disabled

  belongs_to :survey, foreign_key: :fk_formulario
  belongs_to :item_type, foreign_key: :fk_tipo

  has_many :item_answer, foreign_key: :fk_item, dependent: :destroy

  def fill
    self.is_obrigatorio = false
    self.inline = false
    self.editable = false
    self.end_inline = false

    true
  end
end

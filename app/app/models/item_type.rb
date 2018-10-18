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


class ItemType < ActiveRecord::Base
  paginates_per 20
  enum kinds: {text: 1, textarea: 2, select_tag: 3, checkbox: 4, radio: 5, label: 6}

  self.table_name = "basedados.t_tipo_item"
  self.inheritance_column = :_type_disabled

  def translated_name
    return "Radio button single Selection" if nome == "alternative"
    I18n.t(nome)
  end

  def has_options
    [3,4,5].include? id
  end
end

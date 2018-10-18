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


class Scope < ActiveRecord::Base
  paginates_per 20

  self.table_name = "processos.scope"
  self.inheritance_column = :_type_disabled

  has_many :scope_tags, foreign_key: :scope_id
  has_many :tags, through: :scope_tags, foreign_key: :tag_id
  has_many :challenges, foreign_key: :fkscope

  def translated_code
    return code unless localization.present?
    begin
      json = JSON.parse(localization)
    rescue
      json = nil
    end
    return code unless json.present?
    json["en"]
  end

  def translated_description
    return description unless description.present?
    json = JSON.parse(description)
    return description unless json.present?
    json["en"]
  end
end

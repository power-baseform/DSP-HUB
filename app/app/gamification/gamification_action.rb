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


class GamificationAction
  class_attribute :name, :points

  def initialize(name, points)
    @name = name
    @points = points
  end

  def total(editor, id = nil)
    total = 0
    editor.dimensions.each do |dim|
      editor.categories.each do |cat|
        total += editor.current_values[editor.build(dim, cat, self, id)] || 0
      end
    end

    return total
  end
end

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


class PropertiesEditor < PropertiesBase
  attr_accessor :current_values, :form

  def initialize(properties, locale)
    @current_values = properties.nil? ? {} : JSON.parse(properties)
    super()
    @form = PropertiesForm.new(self, locale)
  end

  def slider_image
    @current_values["slider_img"]
  end

  def checkbox_value prop
    return true if @current_values[prop].nil?
    @current_values[prop] == "true"
  end
end

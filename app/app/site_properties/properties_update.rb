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


class PropertiesUpdate < PropertiesBase
  attr_accessor :params

  def initialize(params)
    super()
    @params = params
  end

  def safe_params
    hash = {}

    text_properties.each do |prop|
      hash[prop] = params[prop]
    end

    html_properties.keys.each do |prop|
      hash[prop] = params[prop]
    end

    hash
  end

  def safe_params_no_locale
    hash = {}

    non_localized_properties.each do |prop|
      hash[prop] = params[prop]
    end

    init_non_localized_properties_no_text.each do |prop|
      hash[prop] = params[prop]
    end

    hash
  end
end

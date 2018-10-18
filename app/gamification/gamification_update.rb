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


class GamificationUpdate < GamificationBase
  attr_accessor :challenge, :form_params, :possible_params

  def initialize(challenge, params)
    super()
    @challenge = challenge
    @form_params = params
    @possible_params = possible_params_for challenge
  end

  def safe_params
    return from_file if form_params[:file].present?

    hsh = {}

    form_params.each do |key, val|
      hsh[key] = val.to_i if possible_params.include?(key)
    end

    hsh
  end

  private

  def from_file
    hsh = {}

    sheet = Roo::Spreadsheet.open(form_params[:file], extension: Rack::Mime::MIME_TYPES.invert[form_params[:file].content_type])

    headers = {}
    sheet.row(1).each_with_index do |h, i|
      headers[h] = i
    end

    (sheet.first_row + 1..sheet.last_row).each do |idx|
      row = sheet.row(idx)
      dimensions.each do |dim|
        categories.each do |cat|
          action = GamificationAction.new(row[headers["action"]].split(";;")[0], true)
          str = build(dim, cat, action)
          hsh[str] = row[headers[build(dim, cat)]] if possible_params.include? str
        end
      end
    end

    hsh
  end
end

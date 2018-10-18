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


class SiteProp < ActiveRecord::Base
  self.table_name = "processos.site_props"
  self.inheritance_column = :_type_disabled

  belongs_to :system, foreign_key: :sistema

  def self.image_url(sys, thumbId = nil)
    "#{Rails.application.config.base_dir}sliders/#{sys}/#{thumbId}"
  end

  def save_image(image)
    thumb = Thumbnail.new
    thumb.nome = image.original_filename
    thumb.mime = image.content_type

    if thumb.save
      json = JSON.parse(self.properties)
      json["slider_img"] = thumb.id
      self.properties = json.to_json
      self.save
      IO.copy_stream(image.tempfile, self.class.image_url(sistema, thumb.id))
    end
  end
end

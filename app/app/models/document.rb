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


class Document < ActiveRecord::Base
  include SequencePrimaryKey
  paginates_per 20
  before_create :set_primary_key
  after_create :create_doc

  self.table_name = "processos.documento"
  self.inheritance_column = :_type_disabled

  attr_accessor :temp_doc

  scope :from_challenge, -> { where(tipo: 1) }
  scope :from_site, -> { where(tipo: 2) }

  belongs_to :challenge, foreign_key: :fkprocesso

  def self.image_url(challenge, id = nil, site_tab = nil)
    folder_id = challenge.present? ? challenge.id : site_tab;
    "#{Rails.application.config.base_dir}#{folder_id}/doc/#{id}"
  end

  def document= document
    self.nomeficheiro = document.original_filename
    self.temp_doc = document.tempfile
    self.mime = document.content_type
    self.imagem = false
    self.size = document.tempfile.size

    create_doc if self.persisted?
  end

  private

  def create_doc
    Dir.mkdir("#{challenge.challenge_dir}/doc") unless File.exists?("#{challenge.challenge_dir}/doc")

    IO.copy_stream(self.temp_doc, self.class.image_url(challenge, id))
  end
end

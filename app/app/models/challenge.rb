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


class Challenge < ActiveRecord::Base
  include SequencePrimaryKey
  include PgSearch
  before_create :set_primary_key
  after_create :create_dir
  after_create :create_image

  paginates_per 20
  self.inheritance_column = :_type_disabled
  self.table_name = "processos.processo"

  attr_accessor :temp_image

  scope :with_locale, -> (locale) { where(locale: locale) }
  scope :with_system, -> (sys) { where(sistema: sys) }
  pg_search_scope :search_for, against: %i(titulo codigo)

  has_many :challenge_tags, foreign_key: :processo_fk, dependent: :delete_all
  has_many :tags, through: :challenge_tags, foreign_key: :tag_id

  has_many :participant_challenges, foreign_key: :fkprocesso, dependent: :delete_all
  has_many :participants, through: :participant_challenges

  has_many :sections, :foreign_key => :fkprocesso, dependent: :delete_all
  has_many :documents, :foreign_key => :fkprocesso, dependent: :delete_all
  has_many :events, :foreign_key => :fkprocesso, dependent: :delete_all
  has_many :surveys, :foreign_key => :fkprocesso, dependent: :delete_all

  has_many :comments, foreign_key: :fkprocesso, dependent: :destroy

  belongs_to :city, :foreign_key => :fk_city
  belongs_to :scope, :foreign_key => :fkscope
  belongs_to :system, :foreign_key => :sistema

  validates :codigo, presence: true, uniqueness: { scope: [:locale], message: "code already in use for this language" }
  validates :data_fim, presence: true
  validates :data_inicio, presence: true
  validates :descricao, presence: true
  validates :locale, presence: true
  validates :sistema, presence: true
  validates :titulo, presence: true
  validates :type, presence: true

  def links
    links = []
    sections.each do |sec|
      sec_html = Nokogiri::HTML.parse(sec.corpo)
      links += sec_html.search("a").map do |a| a.attributes["href"].value end
    end

    links
  end

  def challenge_dir
    "#{Rails.application.config.base_dir}#{self.pkid}"
  end

  def self.image_url(challenge, thumbId = nil)
    "#{Rails.application.config.base_dir}#{challenge.pkid}/thumb/#{thumbId}"
  end

  def code_name
    "#{codigo} - #{titulo}"
  end

  def image
    fkthumbnail
  end

  def image= image
    thumb = Thumbnail.new
    thumb.nome = image.original_filename
    thumb.mime = image.content_type

    if thumb.save
      self.fkthumbnail = thumb.id
      self.temp_image = image.tempfile

      create_image if self.persisted?
    end
  end

  private

  def create_dir
    dir = "#{Rails.application.config.base_dir}#{self.pkid}";
    Dir.mkdir(dir) unless File.exists?(dir)
    FileUtils.chown_R 'www-data', 'www-data', dir
  end

  def create_image
    Dir.mkdir("#{self.challenge_dir}/thumb") unless File.exists?("#{self.challenge_dir}/thumb")

    if self.fkthumbnail.present?
      thumb = Thumbnail.find(self.fkthumbnail)

      IO.copy_stream(self.temp_image, self.class.image_url(self, thumb.id))

      abs_path = File.expand_path(self.class.image_url(self, thumb.id))

      MiniMagick::Tool::Convert.new do |convert|
        convert << abs_path
        convert.merge! ["-resize", "1600x", "-quality", "100"]
        convert << "#{abs_path}_med"
      end
      MiniMagick::Tool::Convert.new do |convert|
        convert << abs_path
        convert.merge! ["-resize", "x250", "-quality", "100"]
        convert << "#{abs_path}_small"
      end
    end
  end
end

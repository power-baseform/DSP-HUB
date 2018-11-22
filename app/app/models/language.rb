class Language < ApplicationRecord
  include SequencePrimaryKey
  before_create :set_primary_key

  self.inheritance_column = :_type_disabled
  self.table_name = "processos.languages"

  has_many :system_languages
  has_many :systems, through: :system_languages
end

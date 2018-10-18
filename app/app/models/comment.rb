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


class Comment < ActiveRecord::Base
  paginates_per 20

  self.table_name = "participantes.r_participante_comentario"
  self.inheritance_column = :_type_disabled

  enum status: {removed: 30, pending: 10, approved: 20}

  default_scope { where(status: statuses.values) }
  scope :original, -> { where(fkresponseto: nil) }
  scope :replies, -> { where.not(fkresponseto: nil) }
  scope :approved, -> { where(status: statuses[:approved]) }
  scope :removed, -> { where(status: statuses[:removed]) }
  scope :pending, -> { where(status: statuses[:pending]) }

  belongs_to :participant, foreign_key: :fkparticipante
  belongs_to :challenge, foreign_key: :fkprocesso
  has_many :replies, foreign_key: :fkresponseto, class_name: 'Comment'
  belongs_to :parent, foreign_key: :fkresponseto, class_name: 'Comment'
  has_one :comment_attachment, foreign_key: :fkcomentario, dependent: :destroy

  def original
    parent.nil?
  end

  def toggle_status st
    if st == "toggle"
      removed? ? self.approved! : self.removed!
    else
      st == "approve" ? self.approved! : self.removed!
    end
  end

  def reverse_status
    return "approve" if removed?
    return "remove" if approved?
  end

  def reverse_status_label
    return "success" if removed?
    return "danger" if approved?
  end
end

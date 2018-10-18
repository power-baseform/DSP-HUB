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


class SurveyBuilder
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  delegate :url_helpers, to: 'Rails.application.routes'

  attr_accessor :survey, :kinds, :answer

  def initialize survey
    @survey = survey
    @kinds = ItemType.kinds
  end

  def with_answer answer
    @answer = answer
  end

  def markup
    markup = "<ul class='survey_items'>"
    survey.items.each do |item|
      markup += "<li class='survey_item'>"
      markup += "<div class='title'>"
      markup += "<b>[#{item.codigo}]</b>: #{item.nome}"
      markup += link_to 'Edit', url_helpers.edit_challenge_survey_item_path(item.survey.challenge, item.survey, item), class: 'btn btn-success right' unless answer.present?
      markup += "<span>#{item.info}</span>"
      markup += "</div>"
      markup += handle_item_type item
      markup += "</li>"
    end
    markup += "</ul>"
    markup
  end

  private

  def handle_item_type item
    markup = ""

    case item.item_type.id
      when kinds[:text]
        markup = text_field_tag("i#{item.id}", handle_value(item), html_options)
      when kinds[:textarea]
        markup = text_area_tag("i#{item.id}", handle_value(item), html_options)
      when kinds[:select_tag]
        markup = select_tag("i#{item.id}", options_for_select(item.opcoes.split(";"), handle_value(item)), html_options)
      when kinds[:checkbox]
        value = handle_value(item)
        item.opcoes.split(";").each do |opt|
          markup += check_box_tag("i#{item.id}", opt, value.try(:include?, opt), html_options(item))
          markup += label_tag opt
          markup += "<br/>"
        end
      when kinds[:radio]
        value = handle_value(item)
        item.opcoes.split(";").each do |opt|
          markup += radio_button_tag("i#{item.id}", opt, value == opt, html_options(item))
          markup += label_tag opt
          markup += "<br/>"
        end
      when kinds[:label]
    end

    markup
  end

  def handle_value(item)
    return nil unless answer.present?

    item_answer = answer.item_answer.find_by(item: item)
    return nil unless item_answer.present?

    case item.item_type.id
      when kinds[:text], kinds[:textarea], kinds[:select_tag], kinds[:radio]
        value = item_answer.valor
      when kinds[:checkbox]
        value = item_answer.valor.split(";")
      when kinds[:label]
    end

    value
  end

  def html_options item = nil
    ret = {}

    ret[:class] = "form-control" unless item.present? && [kinds[:checkbox], kinds[:radio]].include?(item.item_type.id)
    ret[:readonly] = true if answer.present?
    ret[:style] = "pointer-events: none;" if item.present? && answer.present? && [kinds[:checkbox], kinds[:radio]].include?(item.item_type.id)

    ret
  end

end

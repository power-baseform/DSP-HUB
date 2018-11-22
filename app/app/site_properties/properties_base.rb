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


class PropertiesBase
  class_attribute :text_properties, :html_properties, :non_localized_properties, :non_localized_properties_no_text, :current_values

  def initialize
    init_text_properties
    init_html_properties
    init_non_localized_properties
    init_non_localized_properties_no_text
  end

  private

  def init_text_properties
    @text_properties ||= ["title",
      "title_for_user_gamification_chart",
      "title_for_overall_gamification_chart",
      "get_involved_description",
      "gamification_table_description",
      "phrase_for_bronze",
      "phrase_for_silver",
      "phrase_for_gold",
      "get_involved_text"
    ]
  end

  def init_html_properties
    @html_properties ||= {
      "issue_list_description": 300,
      "profile_free_text": 1000,
      "terms_of_service_description": -1,
      "privacy_policy_description": -1,
      "registration_form_overwrite": -1,
      "home_chart_overwrite": -1,
      "community_score_overwrite": -1,
      "my_gamification_progress_overwrite": -1
    }
  end

  def init_non_localized_properties
    @non_localized_properties ||= [
      "ceil_for_bronze",
      "ceil_for_silver",
      "ceil_for_gamification"
    ]
  end

  def init_non_localized_properties_no_text
    @non_localized_properties_no_text ||= [
      "show_registration_form",
      "confirmation_email"
    ]
  end

end

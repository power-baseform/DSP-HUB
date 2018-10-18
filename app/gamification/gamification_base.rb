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


class GamificationBase
  PERSONAL = "PERSONAL"
  SOCIAL = "SOCIAL"
  POLITICAL = "POLITICAL"
  class_attribute :categories, :dimensions, :actions, :current_values

  def initialize
    init_dimensions
    init_categories
    init_actions
  end

  def must_skip(key, action)
    return true if skip_labels.include? key.to_s
    return !action.points
  end

  def build(dimension, category, action = nil, id = nil)
    return build_action_with_id(dimension, category, action, id) if id.present?
    return build_action(dimension, category, action) if action.present?
    basic_build(dimension, category)
  end

  private

  def build_action_with_id(dimension, category, action,id)
    return [build(dimension, category), action.name, id].join(".")
  end

  def build_action(dimension, category, action)
    return [build(dimension, category), action.name].join(".")
  end

  def basic_build(dimension, category)
    return "cat.#{dimension.downcase}.#{category}"
  end

  def init_dimensions
    @dimensions ||= ["PERSONAL", "SOCIAL", "POLITICAL"]
  end

  def init_categories
    @categories ||= ["problem.awareness", "practical.knowledge", "ready.for.action"]
  end

  def init_actions
    @actions ||= {
      "COMMENT": GamificationAction.new("action.comment",true),
      "TIP": GamificationAction.new("action.tip", true),
      "TAKE_SURVEY": GamificationAction.new("action.take.survey",true),
      "CLICK_LINK": GamificationAction.new("action.click.link",true),
      "GOT_IT_SECTION": GamificationAction.new("action.got.it.section",true),
      "ATTEND_MEETING": GamificationAction.new("action.attend.meeting",true),
      "DOWNLOAD_DOCUMENT": GamificationAction.new("action.download.document",true),
      "LIKE": GamificationAction.new("action.like", true),
      "DISLIKE": GamificationAction.new("action.dislike", true),
      "SHARE_ISSUE_TWITTER": GamificationAction.new("action.share.issue.twitter",true),
      "SHARE_ISSUE_FACEBOOK": GamificationAction.new("action.share.issue.facebook",true),
      "SHARE_ISSUE_GOOGLE": GamificationAction.new("action.share.issue.google",true),
      "SHARE_ISSUE_EMAIL": GamificationAction.new("action.share.issue.email",true),
      "FOLLOW_ISSUE": GamificationAction.new("action.follow.issue",true),
      "VIEW_ISSUE": GamificationAction.new("action.view.issue", false),
      "SEARCH_MAP": GamificationAction.new("action.search.map",false),
      "RESPOND": GamificationAction.new("action.respond",false),
      "SAVE_SURVEY": GamificationAction.new("action.save.survey",false),
      "START_SURVEY": GamificationAction.new("action.start.survey",false),
      "REOPEN_SURVEY": GamificationAction.new("action.reopen.survey",false),
      "GOTO_EVENT": GamificationAction.new("action.goto.event",false),
      "REMOVE_LIKE": GamificationAction.new("action.remove.like", false),
      "REMOVE_DISLIKE": GamificationAction.new("action.remove.dislike", false)
    }
  end

  def possible_params_for challenge
    arr = []

    actions.each do |key, action|
      next if must_skip(key, action)
      dimensions.each do |dim|
        categories.each do |cat|
          arr << build(dim, cat, action)
        end
      end
    end

    action = actions[:TAKE_SURVEY]
    challenge.surveys.order(:data_abertura).each do |survey|
      dimensions.each do |dim|
        categories.each do |cat|
          arr << build(dim, cat, action, survey.id)
        end
      end
    end

    action = actions[:ATTEND_MEETING]
    challenge.events.order(:data).each do |event|
      dimensions.each do |dim|
        categories.each do |cat|
          arr << build(dim, cat, action, event.id)
        end
      end
    end

    action = actions[:GOT_IT_SECTION]
    challenge.sections.order(:indice).each do |section|
      dimensions.each do |dim|
        categories.each do |cat|
          arr << build(dim, cat, action, section.id)
        end
      end
    end

    action = actions[:CLICK_LINK]
    challenge.links.each do |link|
      dimensions.each do |dim|
        categories.each do |cat|
          arr << build(dim, cat, action, link)
        end
      end
    end

    action = actions[:DOWNLOAD_DOCUMENT]
    challenge.documents.from_challenge.each do |document|
      dimensions.each do |dim|
        categories.each do |cat|
          arr << build(dim, cat, action, document.id)
        end
      end
    end

    arr
  end

  def skip_labels
    @labels ||= ["CLICK_LINK", "GOT_IT_SECTION", "DOWNLOAD_DOCUMENT", "ATTEND_MEETING", "TAKE_SURVEY"]
  end
end

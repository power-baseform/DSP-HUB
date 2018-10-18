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


class SettingsController < Admin::UsersController

  def settings
    @props = SiteProp.find_by(system: current_system)
  end

  def summary
    @challenges = current_system.challenges
    @participants = current_system.participants
    @answers = current_system.answers
    @comments = current_system.comments.original
    @replies = current_system.comments.replies
  end

  def export_summary
    io = StringIO.new
    workbook = WriteXLSX.new(io)
    comments_sheet = workbook.add_worksheet('comments')

    row = 0
    col = 0
    comments_sheet.write(row, col, "Challenge")
    comments_sheet.write(row, col += 1, "Title")
    comments_sheet.write(row, col += 1, "Comment")
    comments_sheet.write(row, col += 1, "User")
    comments_sheet.write(row, col += 1, "Likes")
    comments_sheet.write(row, col += 1, "Dislikes")
    comments_sheet.write(row, col += 1, "Date")
    comments_sheet.write(row, col += 1, "Status")

    current_system.comments.each do |comment|
      col = 0
      row += 1
      comments_sheet.write(row, col, comment.challenge.titulo)
      comments_sheet.write(row, col += 1, comment.title)
      comments_sheet.write(row, col += 1, comment.comentario)
      comments_sheet.write(row, col += 1, comment.participant.nome)
      comments_sheet.write(row, col += 1, comment.likes)
      comments_sheet.write(row, col += 1, comment.dislikes)
      comments_sheet.write(row, col += 1, comment.data)
      comments_sheet.write(row, col += 1, comment.status)
    end

    surveys_sheet = workbook.add_worksheet('surveys')

    row = 0
    col = 0
    surveys_sheet.write(row, col, "Challenge")
    surveys_sheet.write(row, col += 1, "Survey")
    surveys_sheet.write(row, col += 1, "User")
    surveys_sheet.write(row, col += 1, "Submission Date")
    surveys_sheet.write(row, col += 1, "Item")
    surveys_sheet.write(row, col += 1, "Response")

    current_system.answers.each do |answer|
      answer.item_answer.each do |item_answer|
        col = 0
        row += 1
        surveys_sheet.write(row, col, answer.survey.challenge.titulo)
        surveys_sheet.write(row, col += 1, answer.survey.nome)
        surveys_sheet.write(row, col += 1, answer.participant.nome)
        surveys_sheet.write(row, col += 1, answer.data_submissao)
        surveys_sheet.write(row, col += 1, item_answer.item.nome)
        surveys_sheet.write(row, col += 1, item_answer.valor)
      end
    end

    workbook.close
    io.close

    send_data io.string, filename: "#{current_system.name}.xlsx", disposition: 'attachment'
  end

  def export_gamification
    io = StringIO.new
    workbook = WriteXLSX.new(io)
    comments_sheet = workbook.add_worksheet('gamification')

    reader = GamificationReader.new current_system

    row = 0
    col = 0
    comments_sheet.write(row, col, "Name")
    comments_sheet.write(row, col += 1, "Email")

    reader.dimensions.each do |dim|
      reader.categories.each do |cat|
        comments_sheet.write(row, col += 1, reader.build(dim, cat))
      end
    end

    current_system.participants.each do |participant|
      col = 0
      row += 1
      comments_sheet.write(row, col, participant.nome)
      comments_sheet.write(row, col += 1, participant.email)

      reader.calculate_gamification_total participant

      reader.dimensions.each do |dim|
        reader.categories.each do |cat|
          comments_sheet.write(row, col += 1,reader.total_for_category(dim, cat))
        end
      end
    end

    workbook.close
    io.close

    send_data io.string, filename: "gamification_#{current_system.name}.xlsx", disposition: 'attachment'
  end

  def properties
    @props = SiteProp.find_by(system: current_system)
  end

  def save_properties
    props = SiteProp.find_by(system: current_system)
    props_update = PropertiesUpdate.new(params[:properties_form])

    safe_params = props_update.safe_params

    prop_json = JSON.parse(props.properties)
    prop_json[current_locale] = safe_params

    props.properties = prop_json.to_json

    respond_to do |format|
      if props.save
        format.html { redirect_to properties_path, notice: 'Properties were successfully updated.' }
      else
        format.html { redirect_to properties_path, alert: 'Something went wrong' }
      end
    end
  end

  def save_properties_no_locale
    props = SiteProp.find_by(system: current_system)
    props_update = PropertiesUpdate.new(params[:properties_form])

    if params["image"].present?
      props.save_image params["image"]
    else
      safe_params = props_update.safe_params_no_locale
      prop_json = JSON.parse(props.properties)
      safe_params.each do |key, val|
        prop_json[key] = val
      end

      props.properties = prop_json.to_json
    end

    respond_to do |format|
      if props.save
        format.html { redirect_to settings_path, notice: 'Properties were successfully updated.' }
      else
        format.html { redirect_to settings_path, alert: 'Something went wrong' }
      end
    end
  end
end

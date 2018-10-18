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


class AboutSectionController < Admin::UsersController
  def index
    @sections = current_system.about_sections.where(locale: current_locale).order(:code)
  end

  def edit
    @section = AboutSection.find(params[:id])
  end

  def new
    @section = AboutSection.new
  end

  def update
    section = AboutSection.find(params[:id])

    respond_to do |format|
      if section.update(section_params)
        format.html { redirect_to edit_about_section_path(section), notice: 'Section was successfully updated.' }
      else
        format.html { redirect_to edit_about_section_path(section), alert: 'Something went wrong.' }
      end
    end
  end

  def create
    section = AboutSection.new(section)

    respond_to do |format|
      if section.update(section_params)
        format.html { redirect_to edit_about_section_path(section), notice: 'Section was successfully created.' }
      else
        format.html { redirect_to edit_about_section_path(section), alert: 'Something went wrong.' }
      end
    end
  end

  def destroy
    section = AboutSection.find(params[:id])
    respond_to do |format|
      if section.destroy
        format.html { redirect_to about_section_index_path, notice: 'Section was successfully destroyed.' }
      else
        format.html { redirect_to edit_about_section_path(section), alert: 'Something went wrong.' }
      end
    end
  end

  private

  def section_params
    params.require(:about_section).permit(:title, :code, :locale, :sistema, :online, :body)
  end
end

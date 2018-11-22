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


class GamificationReader < GamificationBase
  attr_accessor :current_system, :totals, :user_count

  def initialize(sys)
    @current_system = sys
    @totals = {}
    @user_count = 0
    super()
    fill_totals
  end

  def export challenge
    io = StringIO.new
    workbook = WriteXLSX.new(io)
    worksheet = workbook.add_worksheet

    row = 0
    col = 0
    worksheet.write(row, col, "action")

    headers = ["action"]
    dimensions.each do |dim|
      categories.each do |cat|
        worksheet.write(row, col += 1, build(dim, cat))
      end
    end

    gamification = JSON.parse(challenge.gamification)
    inits = categories.reduce([]) { |arr, cat| arr << cat.split(".")[0] }

    position_map = {}
    possible_params_for(challenge).each do |param|
      str = param.split("cat.")[1]
      dim = str.split(".")[0]
      cat = inits.find_index(str.split(".")[1])

      colStr = build(dim, categories[cat])
      action = param.split(colStr + ".")[1]

      next if gamification[param].nil?

      currRow = position_map.keys.include?(action) ? position_map[action] : row += 1

      if !position_map.keys.include?(action)
        worksheet.write(currRow, 0, action)
        position_map[action] = currRow
      end

      dimension_index = dimensions.find_index(dim.upcase)

      currCol = dimension_index * dimensions.size + cat + 1
      worksheet.write(currRow, currCol, gamification[param])
    end

    workbook.close
    io.close

    io.string
  end

  def calculate_gamification_total part = nil
    fill_totals
    @user_count = 0

    current_system.participants.each do |participant|
      next if part.present? && participant != part
      if participant.gamification.present?
        gamification = JSON.parse(participant.gamification)
        gamification = gamification.try(:[], current_system.id.to_s)
        if gamification.present?
          @user_count += 1

          dimensions.each do |dim|
            categories.each do |cat|
              totals[dim][cat] += gamification[build(dim, cat)] || 0
            end
          end
        end
      end
    end
  end

  def calculate_gamification_total_for_challenge challenge
    fill_totals
    return if challenge.gamification.nil?
    gamification = JSON.parse(challenge.gamification)
    inits = categories.reduce([]) { |arr, cat| arr << cat.split(".")[0] }

    gamification.each do |key, val|
      str = key.split("cat.")[1]
      dim = str.split(".")[0]
      cat = inits.find_index(str.split(".")[1])

      totals[dim.upcase][categories[cat]] += val || 0
    end

    @user_count = 1
  end

  def get_phrase locale
    prop = SiteProp.find_by(system: current_system)
    json_prop = JSON.parse(prop.properties)
    bronze = json_prop["ceil_for_bronze"].to_i
    silver = json_prop["ceil_for_silver"].to_i

    p_total = total
    return json_prop[locale.to_s]["phrase_for_gold"] if (p_total > silver)
    return json_prop[locale.to_s]["phrase_for_silver"] if (p_total > bronze)
    return json_prop[locale.to_s]["phrase_for_bronze"]
  end

  def metal
    prop = SiteProp.find_by(system: current_system)
    json_prop = JSON.parse(prop.properties)
    bronze = json_prop["ceil_for_bronze"].to_i
    silver = json_prop["ceil_for_silver"].to_i

    p_total = total
    return "gold" if (p_total > silver)
    return "silver" if (p_total > bronze)
    return "bronze";
  end

  def total
    total = 0

    totals.each do |key, val|
      val.each do |k, v|
        total += v;
      end
    end

    return total
  end

  def total_for_dimension(dimension)
    total = 0

    totals[dimension].each do |key, val|
      total += val;
    end

    return total
  end

  def total_for_category(dimension, category)
    totals[dimension][category] || 0
  end

  private

  def fill_totals
    dimensions.each do |dim|
      totals[dim] = {}
      categories.each do |cat|
        totals[dim][cat] = 0
      end
    end
  end
end

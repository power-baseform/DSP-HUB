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


u = User.new({:email => "miguel.rebola@baseform.com", :password => "password", :password_confirmation => "password" })
admin = User.new({:email => "baseform", :password => "password", :password_confirmation => "password" })

System.create(name: 'Leicester').update_column(:id, 220)
System.create(name: 'Milton Keynes').update_column(:id, 241)
System.create(name: 'Sabadell').update_column(:id, 242)
System.create(name: 'Jerusalem').update_column(:id, 240)
System.create(name: 'Best Practices').update_column(:id, 280)
System.create(name: 'Power City').update_column(:id, 260)

Role.create(code: 'Leicester')
Role.create(code: 'Milton Keynes')
Role.create(code: 'Sabadell')
Role.create(code: 'Jerusalem')
Role.create(code: 'Best Practices')
Role.create(code: 'Power City')
Role.create(code: 'Admin')

u.roles << Role.all
admin.roles << Role.all

u.save
admin.save(validate: false)

Language.create(locale: "en")
Language.create(locale: "es")
Language.create(locale: "cat")
Language.create(locale: "ar")
Language.create(locale: "iw")

System.all.each do |s|
  s.languages = Language.all
  s.save
end

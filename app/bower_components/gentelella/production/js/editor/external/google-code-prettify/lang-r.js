/*## Baseform
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
## along with this program.  If not, see <https://www.gnu.org/licenses/>.*/


PR.registerLangHandler(PR.createSimpleLexer([["pln",/^[\t\n\r \xa0]+/,null,"\t\n\r \u00a0"],["str",/^"(?:[^"\\]|\\[\S\s])*(?:"|$)/,null,'"'],["str",/^'(?:[^'\\]|\\[\S\s])*(?:'|$)/,null,"'"]],[["com",/^#.*/],["kwd",/^(?:if|else|for|while|repeat|in|next|break|return|switch|function)(?![\w.])/],["lit",/^0[Xx][\dA-Fa-f]+([Pp]\d+)?[Li]?/],["lit",/^[+-]?(\d+(\.\d+)?|\.\d+)([Ee][+-]?\d+)?[Li]?/],["lit",/^(?:NULL|NA(?:_(?:integer|real|complex|character)_)?|Inf|TRUE|FALSE|NaN|\.\.(?:\.|\d+))(?![\w.])/],
["pun",/^(?:<<?-|->>?|-|==|<=|>=|<|>|&&?|!=|\|\|?|[!*+/^]|%.*?%|[$=@~]|:{1,3}|[(),;?[\]{}])/],["pln",/^(?:[A-Za-z]+[\w.]*|\.[^\W\d][\w.]*)(?![\w.])/],["str",/^`.+`/]]),["r","s","R","S","Splus"]);

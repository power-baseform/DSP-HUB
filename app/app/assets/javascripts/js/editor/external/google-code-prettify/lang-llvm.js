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


PR.registerLangHandler(PR.createSimpleLexer([["pln",/^[\t\n\r \xa0]+/,null,"\t\n\r \u00a0"],["str",/^!?"(?:[^"\\]|\\[\S\s])*(?:"|$)/,null,'"'],["com",/^;[^\n\r]*/,null,";"]],[["pln",/^[!%@](?:[$\-.A-Z_a-z][\w$\-.]*|\d+)/],["kwd",/^[^\W\d]\w*/,null],["lit",/^\d+\.\d+/],["lit",/^(?:\d+|0[Xx][\dA-Fa-f]+)/],["pun",/^[(-*,:<->[\]{}]|\.\.\.$/]]),["llvm","ll"]);

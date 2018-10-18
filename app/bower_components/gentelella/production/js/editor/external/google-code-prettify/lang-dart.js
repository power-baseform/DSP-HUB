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


PR.registerLangHandler(PR.createSimpleLexer([["pln",/^[\t\n\r \xa0]+/,null,"\t\n\r \u00a0"]],[["com",/^#!.*/],["kwd",/^\b(?:import|library|part of|part|as|show|hide)\b/i],["com",/^\/\/.*/],["com",/^\/\*[^*]*\*+(?:[^*/][^*]*\*+)*\//],["kwd",/^\b(?:class|interface)\b/i],["kwd",/^\b(?:assert|break|case|catch|continue|default|do|else|finally|for|if|in|is|new|return|super|switch|this|throw|try|while)\b/i],["kwd",/^\b(?:abstract|const|extends|factory|final|get|implements|native|operator|set|static|typedef|var)\b/i],
["typ",/^\b(?:bool|double|dynamic|int|num|object|string|void)\b/i],["kwd",/^\b(?:false|null|true)\b/i],["str",/^r?'''[\S\s]*?[^\\]'''/],["str",/^r?"""[\S\s]*?[^\\]"""/],["str",/^r?'('|[^\n\f\r]*?[^\\]')/],["str",/^r?"("|[^\n\f\r]*?[^\\]")/],["pln",/^[$_a-z]\w*/i],["pun",/^[!%&*+/:<-?^|~-]/],["lit",/^\b0x[\da-f]+/i],["lit",/^\b\d+(?:\.\d*)?(?:e[+-]?\d+)?/i],["lit",/^\b\.\d+(?:e[+-]?\d+)?/i],["pun",/^[(),.;[\]{}]/]]),
["dart"]);

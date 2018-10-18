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


var a=null;
PR.registerLangHandler(PR.createSimpleLexer([["str",/^'(?:[^\n\r'\\]|\\.)*(?:'|$)/,a,"'"],["pln",/^\s+/,a," \r\n\t\u00a0"]],[["com",/^\(\*[\S\s]*?(?:\*\)|$)|^{[\S\s]*?(?:}|$)/,a],["kwd",/^(?:absolute|and|array|asm|assembler|begin|case|const|constructor|destructor|div|do|downto|else|end|external|for|forward|function|goto|if|implementation|in|inline|interface|interrupt|label|mod|not|object|of|or|packed|procedure|program|record|repeat|set|shl|shr|then|to|type|unit|until|uses|var|virtual|while|with|xor)\b/i,a],
["lit",/^(?:true|false|self|nil)/i,a],["pln",/^[a-z][^\W_]*/i,a],["lit",/^(?:\$[\da-f]+|(?:\d+(?:\.\d*)?|\.\d+)(?:e[+-]?\d+)?)/i,a,"0123456789"],["pun",/^.[^\s\w$'./@]*/,a]]),["pascal"]);

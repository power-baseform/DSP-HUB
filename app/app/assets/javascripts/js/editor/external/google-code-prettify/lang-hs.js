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


PR.registerLangHandler(PR.createSimpleLexer([["pln",/^[\t-\r ]+/,null,"\t\n\u000b\u000c\r "],["str",/^"(?:[^\n\f\r"\\]|\\[\S\s])*(?:"|$)/,null,'"'],["str",/^'(?:[^\n\f\r'\\]|\\[^&])'?/,null,"'"],["lit",/^(?:0o[0-7]+|0x[\da-f]+|\d+(?:\.\d+)?(?:e[+-]?\d+)?)/i,null,"0123456789"]],[["com",/^(?:--+[^\n\f\r]*|{-(?:[^-]|-+[^}-])*-})/],["kwd",/^(?:case|class|data|default|deriving|do|else|if|import|in|infix|infixl|infixr|instance|let|module|newtype|of|then|type|where|_)(?=[^\d'A-Za-z]|$)/,
null],["pln",/^(?:[A-Z][\w']*\.)*[A-Za-z][\w']*/],["pun",/^[^\d\t-\r "'A-Za-z]+/]]),["hs"]);

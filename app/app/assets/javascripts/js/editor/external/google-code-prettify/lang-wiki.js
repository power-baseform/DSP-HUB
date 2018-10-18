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


PR.registerLangHandler(PR.createSimpleLexer([["pln",/^[\d\t a-gi-z\xa0]+/,null,"\t \u00a0abcdefgijklmnopqrstuvwxyz0123456789"],["pun",/^[*=[\]^~]+/,null,"=*~^[]"]],[["lang-wiki.meta",/(?:^^|\r\n?|\n)(#[a-z]+)\b/],["lit",/^[A-Z][a-z][\da-z]+[A-Z][a-z][^\W_]+\b/],["lang-",/^{{{([\S\s]+?)}}}/],["lang-",/^`([^\n\r`]+)`/],["str",/^https?:\/\/[^\s#/?]*(?:\/[^\s#?]*)?(?:\?[^\s#]*)?(?:#\S*)?/i],["pln",/^(?:\r\n|[\S\s])[^\n\r#*=A-[^`h{~]*/]]),["wiki"]);
PR.registerLangHandler(PR.createSimpleLexer([["kwd",/^#[a-z]+/i,null,"#"]],[]),["wiki.meta"]);

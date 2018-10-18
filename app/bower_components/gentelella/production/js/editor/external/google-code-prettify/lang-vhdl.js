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


PR.registerLangHandler(PR.createSimpleLexer([["pln",/^[\t\n\r \xa0]+/,null,"\t\n\r \u00a0"]],[["str",/^(?:[box]?"(?:[^"]|"")*"|'.')/i],["com",/^--[^\n\r]*/],["kwd",/^(?:abs|access|after|alias|all|and|architecture|array|assert|attribute|begin|block|body|buffer|bus|case|component|configuration|constant|disconnect|downto|else|elsif|end|entity|exit|file|for|function|generate|generic|group|guarded|if|impure|in|inertial|inout|is|label|library|linkage|literal|loop|map|mod|nand|new|next|nor|not|null|of|on|open|or|others|out|package|port|postponed|procedure|process|pure|range|record|register|reject|rem|report|return|rol|ror|select|severity|shared|signal|sla|sll|sra|srl|subtype|then|to|transport|type|unaffected|units|until|use|variable|wait|when|while|with|xnor|xor)(?=[^\w-]|$)/i,
null],["typ",/^(?:bit|bit_vector|character|boolean|integer|real|time|string|severity_level|positive|natural|signed|unsigned|line|text|std_u?logic(?:_vector)?)(?=[^\w-]|$)/i,null],["typ",/^'(?:active|ascending|base|delayed|driving|driving_value|event|high|image|instance_name|last_active|last_event|last_value|left|leftof|length|low|path_name|pos|pred|quiet|range|reverse_range|right|rightof|simple_name|stable|succ|transaction|val|value)(?=[^\w-]|$)/i,null],["lit",/^\d+(?:_\d+)*(?:#[\w.\\]+#(?:[+-]?\d+(?:_\d+)*)?|(?:\.\d+(?:_\d+)*)?(?:e[+-]?\d+(?:_\d+)*)?)/i],
["pln",/^(?:[a-z]\w*|\\[^\\]*\\)/i],["pun",/^[^\w\t\n\r "'\xa0][^\w\t\n\r "'\xa0-]*/]]),["vhdl","vhd"]);

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


var opts = {
    lines: 12, // The number of lines to draw
    angle: 0, // The length of each line
    lineWidth: 0.4, // The line thickness
    pointer: {
        length: 0.75, // The radius of the inner circle
        strokeWidth: 0.042, // The rotation offset
        color: '#1D212A' // Fill color
    },
    limitMax: 'false', // If true, the pointer will not go past the end of the gauge
    colorStart: '#1ABC9C', // Colors
    colorStop: '#1ABC9C', // just experiment with them
    strokeColor: '#F0F3F3', // to see which ones work best for you
    generateGradient: true
};
var target = document.getElementById('foo'); // your canvas element
var gauge = new Gauge(target).setOptions(opts); // create sexy gauge!
gauge.maxValue = 6000; // set max gauge value
gauge.animationSpeed = 32; // set animation speed (32 is default value)
gauge.set(3200); // set actual value
gauge.setTextField(document.getElementById("gauge-text"));

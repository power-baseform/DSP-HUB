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


window.native_url = URL; // lame
$(window).on("load", function() {
  URL.createObjectURL = native_url.createObjectURL; // lame
  URL.revokeObjectURL = native_url.revokeObjectURL; // lame

  tinyMCE.init({
    selector: '.tinymce',
    plugins: 'lists link image table code',
    toolbar: 'bold italic | bullist numlist | align outdent indent | link | image | table',
    font_formats: "Montserrat=montserrat",
    extended_valid_elements: "*[*]",
    image_title: true,
    automatic_uploads: true,
    images_upload_url: $("#uploadURL").text(),
    file_picker_types: 'image',
    file_picker_callback: function(cb, value, meta) {
      var input = document.createElement('input');
      input.setAttribute('type', 'file');
      input.setAttribute('accept', 'image/*');
      input.onchange = function() {
        var file = this.files[0];
        var reader = new FileReader();

        reader.onload = function () {
          var id = 'blobid' + (new Date()).getTime();
          var blobCache =  tinymce.activeEditor.editorUpload.blobCache;
          var base64 = reader.result.split(',')[1];
          var blobInfo = blobCache.create(id, file, base64);
          blobCache.add(blobInfo);
          cb(blobInfo.blobUri(), { title: file.name });
        };

        reader.readAsDataURL(file);
      };

      input.click();
    }
  });
});

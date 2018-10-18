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


class FileController < Admin::UsersController

  def avatar
    participant = Participant.find(params[:id])
    return unless participant.present?

    file_path = "#{Rails.application.config.base_dir}user_avatars/#{participant.pkid}"
    return render_file(file_path, participant.user_avatar.try(:mime) || "image/png", Rails.root.join("public", "default_user.png"))
  end

  def home_image
    thumb = Thumbnail.find(params[:id])
    return unless thumb.present?

    file_path = SiteProp.image_url(current_system.id, thumb.id)
    return render_file(file_path, thumb.mime)
  end

  def challenge_image
    challenge = Challenge.find(params[:id])
    thumb = Thumbnail.find(challenge.image)
    return unless thumb.present?

    file_path = Challenge.image_url(challenge, thumb.id)
    final_path = params[:size].present? ? "#{file_path}_#{params[:size].to_s}" : file_path
    return render_file(final_path, thumb.mime, file_path)
  end

  def document
    doc = Document.find(params[:id])
    return unless doc.present?

    file_path = Document.image_url(doc.challenge, doc.id, doc.fksite_tab)
    return render_file(file_path, doc.mime)
  end


  def community_challenge_thumb
    thumb = TemporaryThumbnail.find(params[:id])
    return unless thumb.present?

    file_path = "#{Rails.application.config.base_dir}#{thumb.challenge.id}/community_processos_thumbnail/#{thumb.id}"
    return render_file(file_path, thumb.mime)
  end

  def community_challenge_image
    thumb_rel = CommunityChallengeImage.find(params[:id])
    return unless thumb_rel.present?

    thumb = thumb_rel.thumbnail
    return unless thumb.present?

    file_path = "#{Rails.application.config.base_dir}#{thumb_rel.challenge.id}/community_processos_thumbnail/#{thumb.id}"
    return render_file(file_path, thumb.mime)
  end

  def community_document
    doc = CommunityDocument.find(params[:id])
    return unless doc.present?

    file_path = "#{Rails.application.config.base_dir}#{doc.challenge.id}/community_processos_documents/#{doc.id}"
    return render_file(file_path, doc.mime)
  end

  def comment_attachment
    att = CommentAttachment.find(params[:id])
    return unless att.present?

    file_path = "#{Rails.application.config.base_dir}#{att.comment.challenge.id}/comment/#{att.id}"
    return render_file(file_path, att.mime)
  end

  private

  def render_file(file_path, mime, fallback = nil)
    if File.exists? file_path
      file = File.open(file_path)
      return render text: file.read, content_type: mime
    elsif fallback.present? && File.exists?(fallback)
      file = File.open(fallback)
      return render text: file.read, content_type: mime
    end

    render :nothing => true, :status => 200
  end

end

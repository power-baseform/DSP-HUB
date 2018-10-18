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


class CommentsController < Admin::UsersController
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :status]
  helper_method :sort_column, :sort_direction

  # GET /comments
  # GET /comments.json
  def index
    @comments = current_system.comments.original
    @comments = current_system.comments.replies if params[:kind].present? && params[:kind] == "replies"
    @comments = @comments.where(status: params[:status]) if params[:status].present?
    @comments = @comments.where(fkprocesso: params[:challenge][:code]) if params[:challenge].present? && params[:challenge][:code].present?

    @comments = @comments.order(sort_column + " " + sort_direction).page params[:page]
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @replies = @comment.replies.page params[:page]
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  def status
    @comment.toggle_status params[:status]
    @comment.save
    redirect_to :back, notice: "Status changed."
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def sort_column
      Comment.column_names.include?(params[:sort]) ? params[:sort] : "comentario"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.fetch(:comment, {})
    end
end

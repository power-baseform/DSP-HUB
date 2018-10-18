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


Rails.application.routes.draw do
  root to: 'challenges#index'

  # authentication
  devise_for :users, controllers: {sessions: "sessions"}

  # actions
  get :no_system, to: "admin/users#no_system", as: :no_system
  get :change_system, to: "admin/users#change_system", as: :change_system
  get :change_locale, to: "admin/users#change_locale", as: :change_locale

  # challenges
  resources :challenges do
    resources :sections do
      match "upload_from_editor", to: "sections#handle_upload", via: [:post, :get]
      get "doc", to: "file#document", as: :public_document_section
    end
    resources :documents
    resources :events
    resources :surveys do
      resources :items
      resources :answers, only: :show
    end
    get :download_gamification, to:"challenges#download_gamification", as: :download_gamification, on: :member
    patch :gamification, to:"challenges#gamification", as: :gamification, on: :member
  end

  resources :participants do
    get 'reset_gamification', to: "participants#reset_gamification", as: :reset_gamification, on: :member
  end
  resources :scopes
  resources :tags
  resources :community_challenges
  resources :about_section
  resources :cities

  # users
  resources :users do
    post :import, to: "users#import", on: :collection
  end

  # participations
  get :summary, to: "settings#summary", as: :summary
  get :export_summary, to: "settings#export_summary", as: :export_summary
  get :export_gamification, to: "settings#export_gamification", as: :export_gamification
  resources :comments do
    get :status, to:"comments#status", as: :status,  on: :member
  end


  # admin
  get :properties, to: "settings#properties", as: :properties
  patch :properties, to: "settings#save_properties", as: :save_properties
  patch :properties_no_locale, to: "settings#save_properties_no_locale", as: :save_properties_no_locale
  get :settings, to: "settings#settings", as: :settings


  # servlets
  get "user_avatar/:id", to: "file#avatar", as: :user_avatar
  get "home_image/:id", to: "file#home_image", as: :home_image
  get "challenge_image/:id", to: "file#challenge_image", as: :challenge_image
  get "doc", to: "file#document", as: :public_document
  get "document/:id", to: "file#document", as: :document
  get "community_challenge_thumb/:id", to: "file#community_challenge_thumb", as: :community_challenge_thumb
  get "community_challenge_image/:id", to: "file#community_challenge_image", as: :community_challenge_image
  get "community_document/:id", to: "file#community_document", as: :community_document
  get "comment_attachment/:id", to: "file#comment_attachment", as: :comment_attachment
end

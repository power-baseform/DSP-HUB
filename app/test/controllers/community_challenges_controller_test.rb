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


require 'test_helper'

class CommunityChallengesControllerTest < ActionController::TestCase
  setup do
    @community_challenge = community_challenges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:community_challenges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create community_challenge" do
    assert_difference('CommunityChallenge.count') do
      post :create, community_challenge: {  }
    end

    assert_redirected_to community_challenge_path(assigns(:community_challenge))
  end

  test "should show community_challenge" do
    get :show, id: @community_challenge
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @community_challenge
    assert_response :success
  end

  test "should update community_challenge" do
    patch :update, id: @community_challenge, community_challenge: {  }
    assert_redirected_to community_challenge_path(assigns(:community_challenge))
  end

  test "should destroy community_challenge" do
    assert_difference('CommunityChallenge.count', -1) do
      delete :destroy, id: @community_challenge
    end

    assert_redirected_to community_challenges_path
  end
end

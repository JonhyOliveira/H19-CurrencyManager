# frozen_string_literal: true
class UserSettingsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    # TODO use an interactor
  end
end
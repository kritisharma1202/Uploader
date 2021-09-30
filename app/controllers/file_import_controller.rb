class FileImportController < ApplicationController

  def create
  end

  def new
    @user=User.new
  end

  def show
    @file = params[:user][:ImportExcel]
    @row_count, @new_count, @error_count, @error_msgs = User.import(@file)
    @user=User.all
  end

end

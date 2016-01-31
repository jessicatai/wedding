class RsvpController < ApplicationController
  def index
    @code = params[:code]
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end

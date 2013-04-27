class UpdaterepoController < ApplicationController
 def new
    @updaterepo = Updaterepo.new
  end

  def create
    @updaterepo = Updaterepo.new(params[:updaterepo])
    if @updaterepo.save
      redirect_to root_url, notice: "Imported boys successfully."
    else
      render :new
    end
  end

end

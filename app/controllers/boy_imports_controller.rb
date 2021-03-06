class BoyImportsController < ApplicationController
  def new
    @boy_import = BoyImport.new
  end

  def create
    @boy_import = BoyImport.new(params[:boy_import])
    if @boy_import.save
      redirect_to repository_index_path, notice: "Imported boys successfully."
    else
      render :new
    end
  end
end
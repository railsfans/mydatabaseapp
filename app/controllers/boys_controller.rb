class BoysController < ApplicationController
  # GET /boys
  # GET /boys.json
  def index
    @boys = Boy.all	  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boys }
      format.csv { render text: @boys.to_csv }
#     format.xls { send_data @boys.to_csv(col_sep: "\t") }
      format.xls
    end
  end
  
  

	def import
#	  if params[:search].empty?
	  @a=[]
	  Boy.import(params[:file], params[:search])
	  @a=Boy.cal
	  @b=Boy.calu
	redirect_to root_url, notice: params[:search].empty? ?  "repository can make up #{@a.max}" : params[:search].to_i<=0 ? "enter wrong number, number must greater than 0" : "#{@b}" 
#	  else 
#	  @a=params[:search]
#	  end
	end
	



  # GET /boys/1
  # GET /boys/1.json
  def show
    @boy = Boy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @boy }
    end
  end

  # GET /boys/new
  # GET /boys/new.json
  def new
    @boy = Boy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @boy }
    end
  end

  # GET /boys/1/edit
  def edit
    @boy = Boy.find(params[:id])
  end

  # POST /boys
  # POST /boys.json
  def create
    @boy = Boy.new(params[:boy])

    respond_to do |format|
      if @boy.save
        format.html { redirect_to @boy, notice: 'Boy was successfully created.' }
        format.json { render json: @boy, status: :created, location: @boy }
      else
        format.html { render action: "new" }
        format.json { render json: @boy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /boys/1
  # PUT /boys/1.json
  def update
    @boy = Boy.find(params[:id])

    respond_to do |format|
      if @boy.update_attributes(params[:boy])
        format.html { redirect_to @boy, notice: 'Boy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @boy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boys/1
  # DELETE /boys/1.json
  def destroy
    @boy = Boy.find(params[:id])
    @boy.destroy

    respond_to do |format|
      format.html { redirect_to boys_url }
      format.json { head :no_content }
    end
  end
end

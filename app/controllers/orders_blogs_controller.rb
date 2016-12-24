class OrdersBlogsController < ApplicationController
  before_action :set_orders_blog, only: [:show, :edit, :update, :destroy]

  # GET /orders_blogs
  # GET /orders_blogs.json
  def index
    @orders_blogs = OrdersBlog.all
  end

  # GET /orders_blogs/1
  # GET /orders_blogs/1.json
  def show
  end

  # GET /orders_blogs/new
  def new
    if current_dispatcher.present?
      @orders_blog = OrdersBlog.new
    else
      redirect_to orders_path
    end
  end

  # GET /orders_blogs/1/edit
  def edit
  end

  # POST /orders_blogs
  # POST /orders_blogs.json
  def create
    if current_dispatcher.present?
      @orders_blog = OrdersBlog.new(orders_blog_params)

      respond_to do |format|
        if @orders_blog.save
          format.html { redirect_to @orders_blog, notice: 'Orders blog was successfully created.' }
          format.json { render :show, status: :created, location: @orders_blog }
        else
          format.html { render :new }
          format.json { render json: @orders_blog.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to orders_path
    end
  end

  # PATCH/PUT /orders_blogs/1
  # PATCH/PUT /orders_blogs/1.json
  def update
    respond_to do |format|
      if @orders_blog.update(orders_blog_params)
        format.html { redirect_to @orders_blog, notice: 'Orders blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @orders_blog }
      else
        format.html { render :edit }
        format.json { render json: @orders_blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders_blogs/1
  # DELETE /orders_blogs/1.json
  def destroy
    @orders_blog.destroy
    respond_to do |format|
      format.html { redirect_to orders_blogs_url, notice: 'Orders blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_orders_blog
    @orders_blog = OrdersBlog.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def orders_blog_params
    params.require(:orders_blog).permit(:action, :dispatcher_id)
  end
end

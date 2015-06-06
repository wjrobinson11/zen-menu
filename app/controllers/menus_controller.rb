class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  # GET /menus
  # GET /menus.json
  def index
    @menus = Menu.all
    @menu_data = @menus.map do |menu|
      {
        id: menu.id,
        start: menu.serve_date,
        title: "#{menu.format_breakfast_time} Breakfast (#{menu.breakfast_recipe_ids.count} recipes)\n#{menu.format_lunch_time} Lunch (#{menu.lunch_recipe_ids.count} recipes)\n#{menu.format_dinner_time} Dinner (#{menu.dinner_recipe_ids.count} recipes)"
      }
    end.to_json
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
  end

  # GET /menus/new
  def new
    @menu = Menu.new
    @recipes = Recipe.all
  end

  # GET /menus/1/edit
  def edit
    @recipes = Recipe.all
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(menu_params)
    respond_to do |format|
      if @menu.save
        format.html { redirect_to @menu, notice: 'Menu was successfully created.' }
        format.json { render :show, status: :created, location: @menu }
      else
        format.html { render :new }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
        format.json { render :show, status: :ok, location: @menu }
      else
        format.html { render :edit }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to menus_url, notice: 'Menu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      format_recipe_ids
      params.require(:menu).permit(
        :serve_date,
        :breakfast_time,
        :lunch_time,
        :dinner_time,
        :breakfast_head_count,
        :lunch_head_count,
        :dinner_head_count,
        {:breakfast_recipe_ids => []},
        {:dinner_recipe_ids => []},
        {:lunch_recipe_ids => []}
      )
    end

    def format_recipe_ids
      params[:menu][:breakfast_recipe_ids] = [params[:menu][:breakfast_recipe_1], params[:menu][:breakfast_recipe_2]].compact
      params[:menu][:lunch_recipe_ids]     = [params[:menu][:lunch_recipe_1], params[:menu][:lunch_recipe_2], params[:menu][:lunch_recipe_3]].compact
      params[:menu][:dinner_recipe_ids]    = [params[:menu][:dinner_recipe_1], params[:menu][:dinner_recipe_2], params[:menu][:dinner_recipe_3]].compact
    end
end

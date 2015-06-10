require 'bigdecimal'
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
        breakfast_title: "#{menu.format_breakfast_time} Breakfast (#{menu.breakfast_head_count} people)",
        breakfast_recipes: menu.breakfast_recipes.compact.map{|rec| "-#{rec.name}"},
        lunch_title: "#{menu.format_lunch_time} Lunch (#{menu.lunch_head_count} people)",
        lunch_recipes: menu.lunch_recipes.compact.map{|rec| "-#{rec.name}"},
        dinner_title: "#{menu.format_dinner_time} Dinner (#{menu.dinner_head_count} people)",
        dinner_recipes: menu.dinner_recipes.compact.map{|rec| "-#{rec.name}"},
        eventColor: 'black'
      } # working here
    end.to_json
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
  end

  # GET /menus/new
  def new
    @menu = Menu.new(serve_date: params[:serve_date])
    @recipes = Recipe.order('lower(name)')
  end

  # GET /menus/1/edit
  def edit
    @recipes = Recipe.order('lower(name)')
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(menu_params)
    respond_to do |format|
      if @menu.save
        format.html { redirect_to menus_url, notice: 'Menu was successfully created.' }
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
        format.html { redirect_to menus_url, notice: 'Menu was successfully updated.' }
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


  def shopping_list
    menu_ids = params[:menu_ids].split(',')
    @menus            = Menu.where('id in (?)', menu_ids)
    @ingredients_data = {
      'Fruits'        => {},
      'Vegetables'    => {},
      'Cereals'       => {},
      'Milk Products' => {},
      'Groceries'     => {},
      'Proteins'      => {},
      'Others'        => {}
    }
    @menus.each do |menu|
      menu.breakfast_recipes.each do |recipe|
        recipe.recipe_line_items.each do |rli|
          ing = rli.ingredient
          next if ing.category.nil?
          current_ingredient_quantity = @ingredients_data[ing.category]["#{ing.name}|#{ing.unit_of_measurement}"]
          added_ingredient_quantity   = (BigDecimal.new((rli.quantity || 0).to_s) * menu.breakfast_head_count).to_s("F")
          if current_ingredient_quantity.nil?
            @ingredients_data[ing.category]["#{ing.name}|#{ing.unit_of_measurement}"] = added_ingredient_quantity
          else
            new_ingredient_quantity = (BigDecimal.new(current_ingredient_quantity.to_s) + BigDecimal.new(added_ingredient_quantity.to_s)).to_s("F")
            @ingredients_data[ing.category]["#{ing.name}|#{ing.unit_of_measurement}"] = new_ingredient_quantity
          end
        end
      end
      menu.lunch_recipes.each do |recipe|
        recipe.recipe_line_items.each do |rli|
          ing = rli.ingredient
          next if ing.category.nil?
          current_ingredient_quantity = @ingredients_data[ing.category]["#{ing.name}|#{ing.unit_of_measurement}"]
          added_ingredient_quantity   = (BigDecimal.new((rli.quantity || 0).to_s) * menu.lunch_head_count).to_s("F")
          if current_ingredient_quantity.nil?
            @ingredients_data[ing.category]["#{ing.name}|#{ing.unit_of_measurement}"] = added_ingredient_quantity
          else
            new_ingredient_quantity = (BigDecimal.new(current_ingredient_quantity.to_s) + BigDecimal.new(added_ingredient_quantity.to_s)).to_s("F")
            @ingredients_data[ing.category]["#{ing.name}|#{ing.unit_of_measurement}"] = new_ingredient_quantity
          end
        end
      end
      menu.dinner_recipes.each do |recipe|
        recipe.recipe_line_items.each do |rli|
          ing = rli.ingredient
          next if ing.category.nil?
          current_ingredient_quantity = @ingredients_data[ing.category]["#{ing.name}|#{ing.unit_of_measurement}"]
          added_ingredient_quantity   = (BigDecimal.new((rli.quantity || 0).to_s) * menu.dinner_head_count).to_s("F")
          if current_ingredient_quantity.nil?
            @ingredients_data[ing.category]["#{ing.name}|#{ing.unit_of_measurement}"] = added_ingredient_quantity
          else
            new_ingredient_quantity = (BigDecimal.new(current_ingredient_quantity.to_s) + BigDecimal.new(added_ingredient_quantity.to_s)).to_s("F")
            @ingredients_data[ing.category]["#{ing.name}|#{ing.unit_of_measurement}"] = new_ingredient_quantity
          end
        end
      end
    end
  end

  def print_sheet
    menu_ids = params[:menu_ids].split(',')
    @menus   = Menu.where('id in (?)', menu_ids).order('serve_date')
    render layout: false
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

    def format_menu_content(menu)
      "#{menu.format_breakfast_time} Breakfast (#{menu.breakfast_head_count} people)"\
      "\n#{menu.breakfast_recipes.compact.map{|rec| "-#{rec.try(:name)}"}.join("\n")}"\
      "\n#{menu.format_lunch_time} Lunch (#{menu.lunch_head_count} people)"\
      "\n#{menu.lunch_recipes.compact.map{|rec| "-#{rec.try(:name)}"}.join("\n")}"\
      "\n#{menu.format_dinner_time} Dinner (#{menu.dinner_head_count} people)"\
      "\n#{menu.dinner_recipes.compact.map{|rec| "-#{rec.try(:name)}"}.join("\n")}"\
    end

    def format_recipe_ids
      params[:menu][:breakfast_recipe_ids] = [params[:menu][:breakfast_recipe_1], params[:menu][:breakfast_recipe_2]].compact
      params[:menu][:lunch_recipe_ids]     = [params[:menu][:lunch_recipe_1], params[:menu][:lunch_recipe_2], params[:menu][:lunch_recipe_3]].compact
      params[:menu][:dinner_recipe_ids]    = [params[:menu][:dinner_recipe_1], params[:menu][:dinner_recipe_2], params[:menu][:dinner_recipe_3]].compact
    end
end

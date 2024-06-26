class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
  end
  def show
    @pokemon = Pokemon.find(params[:id])
  end


  def search
    @pokemons = Pokemon.all

    if params[:search].present?
      @pokemons = @pokemons.where("name LIKE ?", "%#{params[:search]}%")
    end

    @pokemons = @pokemons.distinct.order(:name)

    # Render the same index view to display search results
    render :index
  end

  def filter_by_type
    if params[:type_id].present?
      @type = Type.find_by(id: params[:type_id])
      if @type
        @pokemons = @type.pokemons
      else
        @pokemons = Pokemon.none
      end
    else
      @pokemons = Pokemon.all
    end

    # Optionally, you can order the results
    @pokemons = @pokemons.order(:name)

    # Render the same index view to display filtered results
    render :index
  end

  def filter_by_ability
    @pokemons = Pokemon.all

    if params[:ability_id].present?
      @pokemons = @pokemons.joins(:abilities).where(abilities: { id: params[:ability_id] })
    end

    @pokemons = @pokemons.distinct.order(:name)

    render :index
  end


end

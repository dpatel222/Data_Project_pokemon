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



  
    render :index
  end

  def filter_by_type
    if params[:type_id].present?
      @type = Type.find_by(id: params[:type_id])
      if @type
        @pokemons = @type.pokemons
      end
    else
      @pokemons = Pokemon.all
    end
    render :index
  end

  def filter_by_ability
    @pokemons = Pokemon.all

    if params[:ability_id].present?
      @pokemons = @pokemons.joins(:abilities).where(abilities: { id: params[:ability_id] })
    end



    render :index
  end


end

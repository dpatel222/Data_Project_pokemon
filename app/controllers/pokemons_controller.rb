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


end

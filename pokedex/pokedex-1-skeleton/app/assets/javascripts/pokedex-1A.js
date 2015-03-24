Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  $('<li>')
    .text(pokemon.escape("name") + " - " + pokemon.escape("poke_type"))
    .addClass('poke-list-item')
    .data("id", pokemon.id)
    .appendTo(this.$pokeList);
};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  this.$pokeList.html("")
  this.pokes.fetch({
    success: function (pokes) {
      pokes.each(this.addPokemonToList.bind(this))
    }.bind(this)
  });
};

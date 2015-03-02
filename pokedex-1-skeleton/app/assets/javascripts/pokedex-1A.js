Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $li = $('<li>');

  $li.text(pokemon.escape("name") + " - " + pokemon.escape("poke_type")).addClass('poke-list-item');
  this.$pokeList.append($li);
};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  if(!callback) {
    callback = this.addPokemonToList.bind(this);
  }

  this.pokes.fetch({
    success: function (pokes) {
      pokes.each(callback)
    }
  });
};

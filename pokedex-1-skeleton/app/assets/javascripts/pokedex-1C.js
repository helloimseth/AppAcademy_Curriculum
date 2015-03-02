Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var newPokemon = new Pokedex.Models.Pokemon(attrs);

  newPokemon.save({
    success: (function () {
      this.addPokemonToList.bind(this, newPokemon);
      this.refreshPokemon.bind(this);
    })
  });
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
};

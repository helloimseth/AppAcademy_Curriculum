Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  this.pokes.create(attrs, {
    wait: true,
    success: function (newPokemon) {
      callback(newPokemon);
      this.refreshPokemon();
    }.bind(this)
  });
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var newPokemon = $(event.currentTarget).serializeJSON();
  this.createPokemon(newPokemon.pokemon, this.renderPokemonDetail.bind(this));;
};

Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var newPokemon = new Pokedex.Models.Pokemon(attrs);

  newPokemon.save({}, {
    success: function () {
        console.log(newPokemon);
        this.pokes.add(newPokemon)
        this.addPokemonToList.bind(this, newPokemon)
    }.bind(this)
  });

  this.refreshPokemon();
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var newPokemon = $(event.currentTarget).serializeJSON();
  this.createPokemon(newPokemon.pokemon);
};

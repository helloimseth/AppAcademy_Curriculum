Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $ulPokemon = $("<ul>");

  var attrs = ["name", "poke_type", "attack", "defense", "moves", "id"]
  attrs.forEach(function (attr) {
    $ulPokemon.append("<li>" + attr + " - " + pokemon.escape(attr) + "</li>");
  });

  var $ulToys = $("<ul>").addClass("toys");

  this.$pokeDetail.html(
    $('<article>')
    .addClass('detail')
    .append('<img src=' + pokemon.escape("image_url") + '>')
    .append($("<button>Destroy</button>").addClass('destroy').data("id", pokemon.id))
    .append($ulPokemon)
    .append($ulToys)

  );

  this.renderToysList(pokemon.toys())
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var $target = $(event.currentTarget);
  var pokemon = this.pokes.get($target.data("id"));
  pokemon.fetch({
    success: this.renderPokemonDetail.bind(this)
  });
};

Pokedex.RootView.prototype.removePokemon = function (event) {
  var $target = $(event.currentTarget);
  var pokemon = this.pokes.get($target.data("id"));
  this.pokes.remove(pokemon)
  pokemon.destroy({
    success: function () {
      this.$pokeDetail.html("");
      alert(pokemon.escape("name") + " has fainted.");
      this.refreshPokemon();
    }.bind(this)
  });
}

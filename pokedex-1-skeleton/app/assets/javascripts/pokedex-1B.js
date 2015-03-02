Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $ul = $("<ul>");

  var attrs = ["name", "poke_type", "attack", "defense", "moves", "id"]
  attrs.forEach(function (attr) {
    $ul.append("<li>" + attr + " - " + pokemon.escape(attr) + "</li>");
  });

  this.$pokeDetail.html(
    $('<article>')
    .addClass('detail')
    .append('<img src=' + pokemon.escape("image_url") + '>')
    .append($ul)
  )

};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var $target = $(event.currentTarget);
  var pokemon = new Pokedex.Models.Pokemon({id: $target.data("id")});
  pokemon.fetch({
    success: this.renderPokemonDetail.bind(this)
  });
};

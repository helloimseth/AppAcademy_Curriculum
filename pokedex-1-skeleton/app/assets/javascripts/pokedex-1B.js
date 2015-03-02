Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $ulPokemon = $("<ul>");

  var attrs = ["name", "poke_type", "attack", "defense", "moves", "id"]
  attrs.forEach(function (attr) {
    $ulPokemon.append("<li>" + attr + " - " + pokemon.escape(attr) + "</li>");
  });

  var $ulToys = $("<ul>").addClass("toys");

  pokemon.fetch({
    success: function(){
      pokemon.toys().forEach(this.addToyToList.bind(this))
    }.bind(this)
  })


  this.$pokeDetail.html(
    $('<article>')
    .addClass('detail')
    .append('<img src=' + pokemon.escape("image_url") + '>')
    .append($ulPokemon)
    .append($ulToys)
  )

};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var $target = $(event.currentTarget);
  var pokemon = new Pokedex.Models.Pokemon({id: $target.data("id")});
  pokemon.fetch({
    success: this.renderPokemonDetail.bind(this)
  });
};

Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $article = $('<article>').addClass('detail');
  $article.append('<img src=' + pokemon.escape("image_url") + '>')
  console.log(pokemon.attributes);
  $ul = $("<ul>");
  _.each(pokemon.attributes, function (val, key) {
    if (key !== "image_url") {
      $ul.append("<li>" + key + " - " + val + "</li>");
    }
  })
  $article.append($ul);
  this.$pokeDetail.append($article);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
};
//
//
// { "id":1,
//   "attack":125,
//   "defense":100,
//   "image_url":"/assets/pokemon_snaps/127.png",
//   "moves":["vicegrip"],
//   "name":"Pinsir",
//   "poke_type":"bug" }

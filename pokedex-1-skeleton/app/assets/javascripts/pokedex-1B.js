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
  this.$pokeDetail.html($article);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var $target = $(event.currentTarget);
  var pokemon = new Pokedex.Models.Pokemon({id: $target.data("id")});
  pokemon.fetch({
    success: this.renderPokemonDetail.bind(this)
  });
};

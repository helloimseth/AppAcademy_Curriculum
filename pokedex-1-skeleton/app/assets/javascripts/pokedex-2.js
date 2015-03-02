Pokedex.RootView.prototype.addToyToList = function (toy) {
  $('<li>')
    .append("Name" + " - " + toy.escape("name") + "<br>")
    .append("Happiness" + " - " + toy.escape("happiness") + "<br>")
    .append("Price" + " - " + toy.escape("price") + "<br>")
    .data("id", toy.id)
    .data("pokemon_id", toy.escape("pokemon_id"))
    .appendTo(this.$pokeDetail.find('.toys'));
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  var $ul = $("<ul>");

  var attrs = ["name", "price", "happiness"]
  attrs.forEach(function (attr) {
    $ul.append("<li>" + attr + " - " + toy.escape(attr) + "</li>");
  });

  this.$toyDetail.html(
    $('<article>')
    .addClass('detail')
    .append('<img src=' + toy.escape("image_url") + '>')
    .append($ul)
  )

};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var $target = $(event.currentTarget);
  var pokemon = new Pokedex.Models.Pokemon({
    id: $target.data("pokemon_id")
  });

  pokemon.fetch({
    success: function () {
      var toy = pokemon.toys().where({id: $target.data("id")})[0];
      this.renderToyDetail.call(this, toy);
    }.bind(this)
  })

};

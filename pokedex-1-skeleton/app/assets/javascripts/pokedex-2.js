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

  var $ownerSelect = $("<select>")
                      .data("pokemon_id", toy.escape("pokemon_id"))
                      .data("toy_id", toy.id)
                      .addClass("owner-selector")

  this.pokes.each(function (poke) {
    var $option = $("<option>")
                    .text(poke.escape("name"))
                    .val(poke.id)

    if (poke.id == $ownerSelect.data("pokemon_id")) {
      $option.prop("selected", true);
    }

    $ownerSelect.append($option)
  })

  this.$toyDetail.html(
    $('<article>')
    .addClass('detail')
    .append('<img src=' + toy.escape("image_url") + '>')
    .append($ul)
    .append($ownerSelect)
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

Pokedex.RootView.prototype.reassignToy = function (event) {
  var newOwnerId = $(event.currentTarget).val()
  var initialOwnerId = $(event.currentTarget).data("pokemon_id")
  var toyId = $(event.currentTarget).data("toy_id")
  var toy = new Pokedex.Models.Toy({id: toyId, pokemon_id: newOwnerId});
  toy.save({}, {
    success: function () {
      var poke1 = new Pokedex.Models.Pokemon({id: initialOwnerId});
      poke1.fetch({
        success: function () {
          poke1.toys().remove(toy);
          this.renderPokemonDetail(poke1);
        }.bind(this)
      });
      
      this.$toyDetail.html("")
    }.bind(this)
  });

}

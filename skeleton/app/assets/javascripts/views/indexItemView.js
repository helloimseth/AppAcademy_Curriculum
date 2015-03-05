NewsReader.Views.IndexItemViews = Backbone.View.extend({

  template: JST['indexItem'],

  tagName: "li",

  events: {
    "click #delete-feed": "deleteFeed"
  },

  render: function () {
    var template = this.template({
      feed: this.model
    });
    this.$el.html(template);
    return this;
  },

  deleteFeed: function (event) {
    event.preventDefault();

    this.model.destroy();
  }

});

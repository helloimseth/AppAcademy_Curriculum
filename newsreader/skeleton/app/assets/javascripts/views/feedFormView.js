NewsReader.Views.FeedFormView = Backbone.View.extend({

  tagName: "form",

  template: JST['newFeedForm'],

  events: {
    "submit": "submitForm"
  },

  render: function () {
    var template = this.template();
    this.$el.html(template);

    return this;
  },

  submitForm: function (event) {
    event.preventDefault();

    var attrs = $(event.currentTarget).serializeJSON();
    this.collection.create(attrs['feed']);

    Backbone.history.navigate("", {
      trigger: true
    });
  }

});

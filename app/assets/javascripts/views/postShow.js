Journails.Views.PostShow = Backbone.View.extend({
  tagName: 'article',

  template: JST['postShow'],

  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var template = this.template({ post: this.model });

    this.$el.html(template);

    return this;
  }

});

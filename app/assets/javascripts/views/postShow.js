Journails.Views.PostShow = Backbone.View.extend({
  tagName: 'article',

  template: JST['postShow'],

  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click .edit-post": "renderPostEdit"
  },

  render: function () {
    var template = this.template({ post: this.model });

    this.$el.html(template);

    return this;
  },

  renderPostEdit: function(){
    Backbone.history.navigate(
      '/posts/' + this.model.id + '/edit',
      { "trigger": true }
    )
  }
});

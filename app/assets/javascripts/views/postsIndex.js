Journails.Views.PostsIndex = Backbone.View.extend({
  template: JST['postsIndex'],

  tagName: 'article',

  initialize: function (options) {
    this.posts = options.posts

  },

  render: function () {
    var template = this.template({ posts: this.posts });

    this.$el.html(template);

    return this;
  }
});

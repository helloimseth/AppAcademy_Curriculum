Journails.Views.PostsIndexItem = Backbone.View.extend({
  template: JST['postsIndexItem'],

  tagName: 'li',

  events: {
    'click .delete': 'deletePostItem'
  },

  initialize: function (options) {
    this.post = options.post;
  },

  render: function () {
    var template = this.template({ post: this.post });

    this.$el.html(template);

    return this;
  },

  deletePostItem: function () {
    this.post.destroy({wait: true});
  }
});

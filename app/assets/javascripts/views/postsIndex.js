Journails.Views.PostsIndex = Backbone.View.extend({
  tagName: 'ul',

  initialize: function (options) {
    this.posts = options.posts
    this.listenTo(this.posts, "remove sync", this.render)
  },

  render: function () {
    this.$el.empty();

    this.posts.each(function (post) {
      var postIndexItem = new Journails.Views.PostsIndexItem({ post: post });

      this.$el.append(postIndexItem.render().$el);
    }.bind(this));

    return this;
  }
});

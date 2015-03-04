Journails.Views.PostsIndex = Backbone.View.extend({
  tagName: 'section',

  template: JST['postsIndex'],

  initialize: function (options) {
    this.posts = options.posts
    this.listenTo(this.posts, "remove sync", this.render)
  },

  events: {
    "click .new-post": "renderPostNew"
  },

  render: function () {
    var template = this.template();
    this.$el.html(template);

    this.posts.each(function (post) {
      var postIndexItem = new Journails.Views.PostsIndexItem({ post: post });

      this.$el.find('.post-list').append(postIndexItem.render().$el);
    }.bind(this));


    return this;
  },

  renderPostNew: function(){
    Backbone.history.navigate(
      '/posts/new',
      { "trigger": true }
    )
  }
});

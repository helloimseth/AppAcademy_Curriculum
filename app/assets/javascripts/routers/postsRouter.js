Journails.Routers.PostsRouter = Backbone.Router.extend({
  routes: {
    "": "renderPostsIndex",
    "posts/:id": "renderPostShow"
  },

  initialize: function (options) {
    this.$el = options.$el;
    this._posts = options.posts;
  },

  renderPostsIndex: function () {
    var postsIndex = new Journails.Views.PostsIndex({ posts: this._posts });

    this._swapView(postsIndex);
  },

  renderPostShow: function (id) {
    var post = this._posts.getOrFetch(id);

    var postShow = new Journails.Views.PostShow({ model: post });

    this._swapView(postShow);
  },

  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$el.html(view.render().$el)
  }
});

Journails.Routers.PostsRouter = Backbone.Router.extend({
  routes: {
    "": "renderPostsIndex",
    "posts/new": "renderPostNew",
    "posts/:id": "renderPostShow",
    // "posts/:id/edit": "renderPostEdit"
  },

  initialize: function (options) {
    this.$el = options.$el;
    this.$elSidebar = this.$el.find('.sidebar');
    this.$elContent = this.$el.find('.content');
    this._posts = options.posts;

    this.renderPostsIndex();
  },

  renderPostsIndex: function () {
    var postsIndex = new Journails.Views.PostsIndex({ posts: this._posts });
    this.$elContent.empty();
    this.$elSidebar.html(postsIndex.$el);
  },

  renderPostShow: function (id) {
    var post = this._posts.getOrFetch(id);
    var postShow = new Journails.Views.PostShow({ model: post });

    this._swapView(postShow);
  },

  // renderPostEdit: function (id) {
  //   var post = this._posts.getOrFetch(id);
  //
  //   var postEdit = new Journails.Views.PostForm({ model: post });
  //
  //   this._swapView(postEdit);
  // },

  renderPostNew: function () {
    var post = new Journails.Models.Post({});

    var postNew = new Journails.Views.PostForm({
      model: post,
      collection: this._posts
    });

    this._swapView(postNew);
  },

  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$elContent.html(view.render().$el);
  }
});

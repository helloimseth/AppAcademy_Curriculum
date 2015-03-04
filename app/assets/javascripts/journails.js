window.Journails = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function () {
    var posts = new Journails.Collections.Posts();
    posts.fetch();

    this.router = new Journails.Routers.PostsRouter({
      posts: posts,
      $el: $('.container')
    });

    Backbone.history.start();
  }
};

$(document).ready(function () {
  Journails.initialize();
});

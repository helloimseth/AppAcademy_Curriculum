Journails.Collections.Posts = Backbone.Collection.extend({
  url: "posts",

  model: Journails.Models.Post,

  getOrFetch: function (id) {
    var success,
        post = this.get(id);

    if (!post) {
      post = new Journails.Models.Post({ id: id });

      success = function () {
        this.add(post);
      }.bind(this)
    }

    post.fetch({
      success: success
    });

    return post;
  }
});

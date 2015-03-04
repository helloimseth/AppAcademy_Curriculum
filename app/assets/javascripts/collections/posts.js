Journails.Collections.Posts = Backbone.Collection.extend({
  url: "posts",

  model: Journails.Models.Post,

  getOrFetch: function (id) {
    if (this.find(id) === 'undefined') {
      var post = new Journails.Models.Post({ id: id });

      post.fetch({
        success: function (){
          this.add(post);
          return post;
        }
      }.bind(this));
    } else {
      return this.get(id)
    }
  }
});

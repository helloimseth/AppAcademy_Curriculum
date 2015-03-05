NewsReader.Collections.Feeds = Backbone.Collection.extend({
  url: "/api/feeds",

  comparator: function (model) {
    return model.get('title').length;
  },

  model: NewsReader.Models.Feed,

  getOrFetch: function (id) {
    var feed = this.get(id);
    if (!feed){
      feed = new NewsReader.Models.Feed({
        id: id
      });
      this.add(feed);
    }
    feed.fetch();
    return feed;
  }
});

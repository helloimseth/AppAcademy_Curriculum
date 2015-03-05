window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var feeds = new NewsReader.Collections.Feeds();
    feeds.fetch();
    var router = new NewsReader.Routers.NewsReaderRouter({
      collection: feeds,
      $el: $('#content')
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});

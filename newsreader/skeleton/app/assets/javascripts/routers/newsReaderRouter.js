NewsReader.Routers.NewsReaderRouter = Backbone.Router.extend({
  routes: {
    "": "index",
    "feeds/new": "feedNew",
    "feeds/:id": "feedShow"
  },

  initialize: function (options) {
    this.collection = options.collection;
    this.$rootEl = options.$el;
  },

  index: function () {
    var indexView = new NewsReader.Views.IndexView({
      collection: this.collection
    })

    this._swapView(indexView);
  },

  feedShow: function (id) {
    var feed = this.collection.getOrFetch(id);
    var feedShowView = new NewsReader.Views.FeedShowView({
      model: feed
    });
    this._swapView(feedShowView);
  },

  feedNew: function () {
    var feedNewView = new NewsReader.Views.FeedFormView({
      collection: this.collection
    });
    this._swapView(feedNewView);
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }

});

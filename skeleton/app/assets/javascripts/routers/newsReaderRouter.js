NewsReader.Routers.NewsReaderRouter = Backbone.Router.extend({
  routes: {
    "": "index"
  },

  initialize: function (options) {
    this.collection = options.collection;
    this.$rootEl = options.$el;
  },

  index: function () {
    this.collection.fetch();
    var indexView = new NewsReader.Views.IndexView({
      collection: this.collection
    })

    this._swapView(indexView);
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});

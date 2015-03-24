NewsReader.Views.IndexView = Backbone.View.extend({

  initialize: function () {
    this._subViews = [];
    this.listenTo(this.collection, "sync remove add", this.render);
  },

  tagName: "section",

  template: JST['index'],

  events: {
    "click #new-feed": "visitNew"
  },

  render: function () {
    this.$el.empty();
    this.$el.html(this.template());
    this.$ul = this.$el.find('#feed-list');

    this.collection.sort().each(function(feed){
      var indexItemView = new NewsReader.Views.IndexItemViews({
        model: feed
      });

      this._subViews.push(indexItemView);

      this.$ul.append(indexItemView.render().$el);
    }.bind(this));

    return this;
  },

  visitNew: function(){
    Backbone.history.navigate( "feeds/new", {trigger:true})
  },

  remove: function () {
    Backbone.View.prototype.remove.call(this);
    this._subViews.forEach(function (subView){
      subView.remove();
    });

    this._subviews = [];
  }
});

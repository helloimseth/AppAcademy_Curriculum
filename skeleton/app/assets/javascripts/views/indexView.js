NewsReader.Views.IndexView = Backbone.View.extend({

  initialize: function () {
    this._subViews = [];
    this.$el.append($('<ul>'));
    this.$ul = this.$el.find('ul');

    this.listenTo(this.collection, "sync remove", this.render);
  },

  tagName: "section",

  render: function () {
    this.$ul.empty();

    this.collection.each(function(feed){
      var indexItemView = new NewsReader.Views.IndexItemViews({
        model: feed
      });

      this._subViews.push(indexItemView);

      this.$ul.append(indexItemView.render().$el);
    }.bind(this));

    return this;
  },

  remove: function () {
    Backbone.View.prototype.remove.call(this);
    this._subViews.forEach(function (subView){
      subView.remove();
    });

    this._subviews = [];
  }

});

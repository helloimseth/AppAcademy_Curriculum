NewsReader.Views.FeedShowView = Backbone.View.extend({
  template: JST['feedShow'],

  tagName: 'article',

  initialize: function () {
    this._subViews = [];
    this.listenTo(this.model, "sync destroy", this.render);
  },

  render: function () {
    this.$el.empty();

    var template = this.template({
      feed: this.model
    });
    this.$el.append(template);

    renderEntries();

    return this;
  },

  renderEntries: function () {
    var $ul = this.$el.find("#feed-entries");

    this.model.entries().each(function(entry){
      var subView = new NewsReader.Views.EntryItemView({
        model: entry
      });

      $ul.append(subView.render().$el);

      this._subViews.push(subView);
    }.bind(this));  
  },

  remove: function () {
    Backbone.View.prototype.remove.call(this);
    this._subViews.forEach(function(subview){
      subview.remove();
    });
    this._subViews = [];
  }
});

NewsReader.Views.IndexItemViews = Backbone.View.extend({

  template: JST['indexItem'],

  tagName: "li",

  render: function () {
    var template = this.template({
      feed: this.model
    });
    this.$el.html(template);
    return this;
  }

});

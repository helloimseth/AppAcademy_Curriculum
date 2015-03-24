NewsReader.Views.EntryItemView = Backbone.View.extend({
  template: JST['entryItem'],

  tagName: 'li',

  render: function () {
    var template = this.template({
      entry: this.model
    });

    this.$el.append(template);
    return this;
  }
});

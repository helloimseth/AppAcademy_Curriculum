Journails.Views.PostForm = Backbone.View.extend({
  tagName: 'form',

  template: JST['postForm'],

  events: {
    "submit": "saveOrUpdate"
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render.bind(this, this.model, null));
  },

  render: function (post, errors) {
    console.log(errors);
    var template = this.template({ post: (post || this.model), errors: errors });
    this.$el.html(template);
    return this;
  },

  saveOrUpdate: function (event) {
    event.preventDefault();

    var attrs = this.$el.serializeJSON()['post'];

    this.model.save(attrs, {
      success: function () {
        this.collection && this.collection.add(this.model, { merge: true });
        Backbone.history.navigate('' ,{ 'trigger': true } )
      }.bind(this),
      error: function (model, response) {
        this.render(model, JSON.parse(response.responseText));
      }.bind(this)
    });

  }

});

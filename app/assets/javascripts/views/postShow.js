Journails.Views.PostShow = Backbone.View.extend({
  tagName: 'article',

  template: JST['postShow'],

  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    // "click .edit-post": "renderPostEdit",
    "dblclick h1, p": "renderEditField",
    "blur input, textarea": "saveField"
  },

  render: function () {
    var template = this.template({ post: this.model });

    this.$el.html(template);

    return this;
  },

  renderEditField: function (event) {
    event.preventDefault();

    var $editField;
    this.$target = $(event.currentTarget);

    $editField = this.$target.data("column") === 'title' ? $('<input>') : $('<textarea>');

    $editField.val(this.$target.text()).data("column",this.$target.data('column'))
    this.$target.replaceWith($editField);
  },

  saveField: function (event) {
    var $target = $(event.currentTarget);

    this.model.set($target.data("column"), $target.val());

    this.model.save({}, {
      success: function () {
        this.$target.text($target.val());
        $target.replaceWith(this.$target);
      }.bind(this),
      error: function (model, response) {
        // var errors = JSON.parse(response.responseText);

        $target.replaceWith(this.$target);
      }.bind(this)
    });


  }
});

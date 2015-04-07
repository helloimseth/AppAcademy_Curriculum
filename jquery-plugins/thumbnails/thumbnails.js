$.Thumbnails = function (el) {
  this.$el = $(el);
  this.$active = this.$el.find(".active");
  this.$gutterImages = this.$el.find(".gutter-images");
  this.activate($(this.$gutterImages.children()[0]))

  this.$el.on("click", ".gutter-images img", function (event){
    this.activate($(event.target));
    this.$activeImage = this.$active.find("img");
  }.bind(this))

  this.$gutterImages.find("img").mouseenter(function(event) {
    this.$activeImage = this.$active.find("img");
    this.activate($(event.target));
  }.bind(this))

  this.$gutterImages.find("img").mouseleave(function(event) {
    this.activate($(this.$activeImage));
  }.bind(this))
};
// this.handleMouse(event)
// $.Thumbnails.prototype.handleMouse(event){
//
// };

$.Thumbnails.prototype.activate = function($img){
  this.$active.html("");
  var html = $img.clone()[0];
  // console.log(html);
  this.$active.append(html);

};

$.fn.thumbnails = function () {
  return this.each(function () {
    new $.Thumbnails(this);
  });
};

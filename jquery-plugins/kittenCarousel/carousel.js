$.Carousel = function (el) {
  this.$el = $(el);
  this.activeIndex = 0;
  this.$items = this.$el.find(".items");
  this.$el.on("click", "button", this.slide.bind(this));
  this.$indicators = this.$el.find(".indicator");
}

$.Carousel.prototype.slide = function (event) {

  var $prevActive = this.$items.children().eq(this.activeIndex);
  var $prevIndicator = this.$indicators.children().eq(this.activeIndex);

  if ($(event.currentTarget).hasClass("slide-left") ){
    if (this.activeIndex === 3){
      return;
    }
    this.activeIndex +=  1;
    var className = "right";
  } else {
    if (this.activeIndex === 0){
      return;
    }
    this.activeIndex -= 1;
    var className = "left";
  }

  var prevClass = className === "left" ? "right" : "left";

  $prevActive.addClass(prevClass);
  $prevIndicator.removeClass();

  $prevActive.one("transitionend", function(event){
    $prevActive.removeClass();
  });

  var $curActive = this.$items.children().eq(this.activeIndex)
  $curActive.addClass("active " + className );

  setTimeout(function() {
    $curActive.removeClass(className);
  }, 0);

  this.$indicators.children().eq(this.activeIndex).addClass("active");
}

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};

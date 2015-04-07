$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.attr("data-content-tabs"));
  this.$activeTab = this.$contentTabs.find(".active");

  this.$el.on("click", "a", this.clickTab.bind(this))
};

$.Tabs.prototype.clickTab = function (event) {
  event.preventDefault();

  this.$el.find(".active").removeClass("active");
  var $currentActive = $(event.currentTarget)
  $currentActive.addClass("active");

  this.$activeTab.addClass("transitioning");

  this.$activeTab.one("transitionend", function(event){

    this.$activeTab.removeClass("active");
    this.$activeTab.removeClass("transitioning");

    this.$activeTab = this.$contentTabs.find($currentActive.attr("href"));
    this.$activeTab.addClass("active transitioning");

    window.setTimeout(function(){
      this.$activeTab.removeClass("transitioning");
    }.bind(this), 0)

  }.bind(this))
}

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};

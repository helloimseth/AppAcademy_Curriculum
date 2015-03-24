(function () {
  if (typeof Asteroids == "undefined") {
    Asteroids = {}
  }

  Ateroids.Util = {};

  Asteroids.Util.inherits = function (child, parent) {
    function Surrogate () {};
    Surrogate.prototype = parent.prototype;
    child.prototype = new Surrogate();
  })
})();

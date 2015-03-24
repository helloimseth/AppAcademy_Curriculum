(function () {
  if (typeof Asteroids == "undefined") {
    Asteroids = {};
  }

  Ateroids.Util = {};

  Asteroids.Util.inherits = function (child, parent) {
    function Surrogate () {}
    Surrogate.prototype = parent.prototype;
    child.prototype = new Surrogate();
  };

  Asteroids.Util.randomVec = function (length) {
    var x, y;
    length = length || 1;

    x = Math.random() * length * length;
    y = sqrt(length - Math.pow(0 - x, 2));

    x *= Math.random() > 0.5 ? -1 : 1;
    y *= Math.random() > 0.5 ? -1 : 1;

    return [x, y];
  };
})();

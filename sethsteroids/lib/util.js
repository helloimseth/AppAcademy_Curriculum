(function () {
  if (typeof Asteroids == "undefined") {
    Asteroids = {};
  }

  Asteroids.Util = {};

  Asteroids.Util.inherits = function (child, parent) {
    function Surrogate () {}
    Surrogate.prototype = parent.prototype;
    child.prototype = new Surrogate();
  };

  Asteroids.Util.distance = function (pos1, pos2) {
    return Math.sqrt(Math.pow(pos1[0] - pos2[0], 2) +
                     Math.pow(pos1[1] - pos2[1], 2));
  };

  Asteroids.Util.norm = function (pos) {
    return Asteroids.Util.distance([0,0], pos);
  };

  Asteroids.Util.randomVec = function (length) {
    var x, y;

    x = Math.random() * length * length;
    y = Math.sqrt(length - Math.pow(0 - x, 2));

    x *= Math.random() > 0.5 ? -1 : 1;
    y *= Math.random() > 0.5 ? -1 : 1;

    return [x, y];
  };
})();

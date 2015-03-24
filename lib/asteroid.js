(function () {
  if (typeof window.Asteroids === "undefined" ) {
    window.Asteroids = {};
  }

  Asteroid.COLOR = Asteroids.Asteroid.COLOR = "#1b33d1";
  Asteroid.RADIUS = Asteroids.Asteroid.RADIUS = 10;

  var Asteroid = Asteroids.Asteroid = function (options) {
    this.pos = options.pos;
    this.vel = Asteroids.Util.randomVec(options.length);

    Asteroids.MovingObject.call(this, {
      color: Asteroid.COLOR,
      radius: Asteroid.RADIUS
    });
  };

  Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject);
})();

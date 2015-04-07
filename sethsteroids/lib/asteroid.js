(function () {
  if (typeof window.Asteroids === "undefined" ) {
    window.Asteroids = {};
  }

  var Asteroid = Asteroids.Asteroid = function (options) {
    this.game = options.game;
    this.heading = Asteroids.Util.randomVec(1);
    this.speed = options.length;

    Asteroids.MovingObject.call(this, {
      pos: options.pos,
      color: Asteroid.COLOR,
      radius: Asteroid.RADIUS
    });
  };

  Asteroid.COLOR = Asteroids.Asteroid.COLOR = "#1b33d1";
  Asteroid.RADIUS = Asteroids.Asteroid.RADIUS = 20;

  Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject);

  Asteroid.prototype.collideWith = function (otherObject) {
    if (otherObject instanceof Asteroids.Ship) {
      otherObject.relocate();
    }
  };
})();

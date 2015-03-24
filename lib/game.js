(function () {
  if (typeof window.Asteroids === "undefined" ) {
    window.Asteroids = {};
  }

  var Game = Asteroids.Game = function () {
    this.asteroids = [];
    this.addAsteroids();
  };

  Game.DIM_X = 500;
  Game.DIM_Y = 500;
  Game.NUM_ASTEROIDS = 50;

  Game.prototype.draw = function (ctx) {
    ctx.clearRect();

    this.asteroids.forEach(function (asteroid) {
      asteroid.draw(ctx);
    });
  };

  Game.prototype.moveObjects = function () {
    this.asteroids.forEach(function (asteroid) {
      asteroid.move();
    });
  };

  Game.prototype.addAsteroids = function () {
    for (var i = 0; i < Game.NUM_ASTEROIDS; i++) {
      Game.asteroids.push(new Asteroids.Asteroid({
        pos: Game.randomPosition
      }));
    }
  };

  Game.prototype.randomPosition = function () {
    return [Math.random() * Game.DIM_X, Math.random() * Game.DIM_Y];
  };
})();

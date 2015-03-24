(function () {
  if (typeof window.Asteroids === "undefined" ) {
    window.Asteroids = {};
  }

  var Game = Asteroids.Game = function (options) {
    this.NUM_ASTEROIDS = options.num_asteroids;
    this.DIM_X = options.dim_x;
    this.DIM_Y = options.dim_y;
    this.asteroids = [];
    this.addAsteroids();
  };



  Game.prototype.draw = function (ctx) {
    ctx.clearRect(0, 0, canvas.width, canvas.height);

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
    for (var i = 0; i < this.NUM_ASTEROIDS; i++) {
      this.asteroids.push(new Asteroids.Asteroid({
        game: this,
        pos: this.randomPosition(),
        length: Math.random() * Game.NUM_ASTEROIDS/5
      }));
    }
  };

  Game.prototype.randomPosition = function () {
    return [Math.random() * this.DIM_X, Math.random() * this.DIM_Y];
  };

  Game.prototype.wrap = function (pos) {
    if (pos[0] > this.DIM_X) {
      pos[0] -= this.DIM_X;
    } else if (pos[0] < 0) {
      pos[0] += this.DIM_X;
    }

    if (pos[1] > this.DIM_Y) {
      pos[1] -= this.DIM_Y;
    } else if (pos[1] < 0) {
      pos[1] += this.DIM_Y;
    }

    // var x = pos[0] > this.DIM_X ? pos[0] - this.DIM_X : pos[0];
    // pos[0] += pos[0] < 0 ? this.DIM_X : 0;
    //
    // pos[1] -= pos[0] > this.DIM_Y ? this.DIM_Y : 0;
    // pos[1] += pos[1] < 0 ? this.DIM_Y : 0;
    //
    // return pos;
  };
})();

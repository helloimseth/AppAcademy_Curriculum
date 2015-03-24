(function () {
  if (typeof window.Asteroids === "undefined" ) {
    window.Asteroids = {};
  }

  var Game = Asteroids.Game = function (options) {
    this.NUM_ASTEROIDS = options.num_asteroids;
    this.DIM_X = options.dim_x;
    this.DIM_Y = options.dim_y;

    this.ship = new Asteroids.Ship({
      pos: this.randomPosition(),
      game: this
    });

    this.asteroids = [];
    this.addAsteroids();
  };

  Game.prototype.allObjects = function () {
    if (!this._allObjects) {
      this._allObjects = this.asteroids.concat([this.ship]);
    }
    return this._allObjects;
  };

  Game.prototype.draw = function (ctx) {
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    this.allObjects().forEach(function (obj) {
      obj.draw(ctx);
    });
  };

  Game.prototype.moveObjects = function () {
    this.allObjects().forEach(function (obj) {
      obj.move();
    });
  };

  Game.prototype.addAsteroids = function () {
    for (var i = 0; i < this.NUM_ASTEROIDS; i++) {
      var options = {
        game: this,
        pos: this.randomPosition(),
        length: Math.floor(Math.random() * this.NUM_ASTEROIDS/5)
      }

      var asteroid = new Asteroids.Asteroid(options)

      this.asteroids.push(asteroid);
    }
  };

  Game.prototype.step = function () {
    this.moveObjects();
    this.checkCollisions();
  };

  Game.prototype.randomPosition = function () {
    return [ Math.floor(Math.random() * this.DIM_X),
             Math.floor(Math.random() * this.DIM_Y) ];
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
  };

  Game.prototype.checkCollisions = function () {
    for(var i = 0; i < this.allObjects().length; i++ ) {
      for(var j = i + 1; j < this.allObjects().length; j++ ) {
        if (this.allObjects()[i].isCollidedWith(this.allObjects()[j])){
          this.allObjects()[i].collideWith(this.allObjects()[j]);
        }
      }
    }
  };

  Game.prototype.remove = function (asteroid) {
    this.asteroids.pop(asteroid);
  };
})();

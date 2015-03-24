(function () {
  if (typeof window.Asteroids === "undefined" ) {
    window.Asteroids = {};
  }

  var GameView = Asteroids.GameView = function (options) {
    this.game = options.game;
    this.ctx = options.ctx;
    this.bindKeyHandlers();
  };

  GameView.prototype.start = function () {
    setInterval(function () {
      this.game.step();
      this.game.draw(this.ctx);
    }.bind(this), 20);
  };

  GameView.prototype.bindKeyHandlers = function () {
    // if (key.up) console.log("hello"); this.game.ship.power(1);
    //
    // if (key.down) this.game.ship.power(-1);

    key('up', function () { this.game.ship.power(-1); }.bind(this));
    key('down', function () { this.game.ship.power(1); }.bind(this));


  };

})();

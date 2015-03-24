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
    key('up', function () { this.game.ship.power(-2); }.bind(this));
    key('down', function () { this.game.ship.power(2); }.bind(this));
    key('right', function () { this.game.ship.turn(20); }.bind(this));
    key('left', function () { this.game.ship.turn(-20); }.bind(this));
  };

})();

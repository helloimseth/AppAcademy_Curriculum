(function () {
  if (typeof window.Asteroids === "undefined" ) {
    window.Asteroids = {};
  }

  var Ship = Asteroids.Ship = function (options) {
    this.game = options.game;

    Asteroids.MovingObject.call(this, {
      pos: options.pos,
      vel: [0, 0],
      color: Ship.COLOR,
      radius: Ship.RADIUS
    });

    this.speed = Asteroids.Util.norm(this.vel);
  };

  Ship.COLOR = Asteroids.Ship.COLOR = "#d1b91b";
  Ship.RADIUS = Asteroids.Ship.RADIUS = 10;

  Asteroids.Util.inherits(Ship, Asteroids.MovingObject);

  Ship.prototype.relocate = function () {
    this.pos = this.game.randomPosition();
  };

  Ship.prototype.power = function (impulse) {
    this.speed += impulse;

    var foreOrBack = this.speed > 0 ? 1 : -1 ;

    this.vel[1] = Math.sqrt(
      Math.pow(this.speed, 2) -
      Math.pow(this.vel[0], 2)
    ) * foreOrBack;
  };

})();

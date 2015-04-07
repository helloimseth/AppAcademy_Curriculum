(function () {
  if (typeof window.Asteroids === "undefined" ) {
    window.Asteroids = {};
  }

  var Ship = Asteroids.Ship = function (options) {
    this.game = options.game;

    Asteroids.MovingObject.call(this, {
      pos: options.pos,
      color: Ship.COLOR,
      radius: Ship.RADIUS
    });

    this.speed = 0;
    this.heading = [0, -1];

  };

  Ship.COLOR = Asteroids.Ship.COLOR = "#d1b91b";
  Ship.RADIUS = Asteroids.Ship.RADIUS = 10;

  Asteroids.Util.inherits(Ship, Asteroids.MovingObject);

  Ship.prototype.relocate = function () {
    this.pos = this.game.randomPosition();
  };

  Ship.prototype.power = function (impulse) {
    this.speed += impulse;

    // var foreOrBack = this.speed > 0 ? 1 : -1 ;
    //
    // var headingInRadians = Asteroids.Util.norm(this.vel)/Math.PI * 180;
    //
    // this.vel[0] += -impulse * Math.sin(headingInRadians);
    //
    // this.vel[1] += -impulse * Math.cos(headingInRadians);

    // this.vel[1] = Math.sqrt(
    //   Math.pow(this.speed, 2) -
    //   Math.pow(this.vel[0], 2)
    // ) * foreOrBack;
  };

  Ship.prototype.turn = function (dir) {
    dir = (dir / 180) * Math.PI;

    this.heading[0] = this.heading[0] * Math.cos(dir) -
                      this.heading[1] * Math.sin(dir);

    this.heading[1] = this.heading[0] * Math.sin(dir) +
                      this.heading[1] * Math.cos(dir);
  };

})();

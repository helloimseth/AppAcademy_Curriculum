(function (){

  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var MovingObject = Asteroids.MovingObject = function (optionsHash){
    this.pos = optionsHash["pos"];
    this.vel = optionsHash["vel"];
    this.radius = optionsHash["radius"];
    this.color = optionsHash["color"];
    this.game = optionsHash["game"];
    this.isWrappable = optionsHash["isWrappable"];
  }

  MovingObject.prototype.draw = function(ctx){

    ctx.fillStyle = this.color;
    ctx.beginPath();

    ctx.arc(
      this.pos[0],
      this.pos[1],
      this.radius,
      0,
      2 * Math.PI,
      false
    );

    ctx.fill();
  }

  MovingObject.prototype.move = function(){
    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];

    if (this.game.isOutOfBounds(this.pos) && !this.isWrappable) {
      this.game.remove(this)
    }  else {
      this.game.wrap(this.pos);
    }
  }

  MovingObject.prototype.isCollidedWith = function (otherObject) {

    dist = Math.sqrt(Math.pow(this.pos[0] - otherObject.pos[0], 2) +
                     Math.pow(this.pos[1] - otherObject.pos[1], 2));

    if (dist < (this.radius + otherObject.radius)) {
      return true;
    } else {
      return false;
    }
  };

  MovingObject.prototype.collidedWith = function (otherObject) {

  };

})();

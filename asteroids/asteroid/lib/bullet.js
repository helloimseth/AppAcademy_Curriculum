(function (){

  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Bullet = Asteroids.Bullet = function(optionsHash){
      optionsHash["color"] = "#AAEFCC";
      optionsHash["radius"] = 5;
      optionsHash["isWrappable"] = false;
      Asteroids.MovingObject.call(this, optionsHash);
  }

  Asteroids.Util.inherits(Asteroids.Bullet, Asteroids.MovingObject);

  Bullet.prototype.collidedWith = function(otherObject){

    if( otherObject instanceof Asteroids.Asteroid){
        this.game.remove(otherObject);
        this.game.remove(this);
    }
  };



})();

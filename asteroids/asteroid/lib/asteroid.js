(function (){

  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Asteroid = Asteroids.Asteroid = function(optionsHash){
      optionsHash["color"] = "#E4E4E4";
      optionsHash["radius"] = 20;
      optionsHash["vel"] = Asteroids.Util.randomVec(4);
      optionsHash["isWrappable"] = true;
      Asteroids.MovingObject.call(this, optionsHash);
  }

  Asteroids.Util.inherits(Asteroids.Asteroid, Asteroids.MovingObject);

  Asteroid.prototype.collidedWith = function(otherObject){

    if( otherObject instanceof Asteroids.Ship){
        otherObject.relocate();
    }
  };



})();

(function (){

  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Ship = Asteroids.Ship = function(optionsHash){
      optionsHash["color"] = "#E4ABDC";
      optionsHash["radius"] = 10;
      optionsHash["vel"] = Asteroids.Util.randomVec(0);
      optionsHash["isWrappable"] = true;
      Asteroids.MovingObject.call(this, optionsHash);
  }

  Asteroids.Util.inherits(Asteroids.Ship, Asteroids.MovingObject);

  Ship.prototype.relocate = function(){
    this.pos = this.game.randomPosition();
  }

  Ship.prototype.power = function(impulse){
        this.vel[0] += impulse[0];

        if(this.vel[0] > 1.5){
          this.vel[0] = 1.5;
        } else if (this.vel[0] < -1.5){
          this.vel[0] = -1.5;
        }

        this.vel[1] += impulse[1];

        if(this.vel[1] > 1.5){
          this.vel[1] = 1.5;
        } else if (this.vel[1] < -1.5){
          this.vel[1] = -1.5;
        }
  }

  Ship.prototype.fireBullet = function(){

    var newVel = this.vel.slice().map(function(el){
          if(el > 0)  {
            return el + 2;
          } else {
            return el - 2;
          }
    })


    var bullet = new Asteroids.Bullet({
        pos:this.pos.slice(), game:this.game, vel: newVel});
    this.game.bullets.push(bullet);
  }
  

})();

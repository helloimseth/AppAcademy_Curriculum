(function (){

  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Game = Asteroids.Game = function (canvasWidth, canvasHeight) {
    this.DIM_X = canvasWidth;
    this.DIM_Y = canvasHeight;
    this.NUM_ASTEROIDS = 10;
    this.asteroids = [];
    this.addAsteroids();
    this.ship = new Asteroids.Ship({pos:this.randomPosition(), game: this});
    this.bullets = [];
  };

  Game.prototype.draw = function(ctx) {

      ctx.clearRect(0,0, this.DIM_X, this.DIM_Y);

      for(var i = 0; i < this.allObjects().length; i += 1)
      {
          this.allObjects()[i].draw(ctx);
      }
  };

  Game.prototype.randomPosition = function() {
    return [Math.floor(this.DIM_X * Math.random()),
            Math.floor(this.DIM_Y * Math.random())];
  }

  Game.prototype.addAsteroids = function() {
     for (var i = 0; i < this.NUM_ASTEROIDS; i++){
       var asteroid = new Asteroids.Asteroid({pos:this.randomPosition(), game: this})
       this.asteroids.push(asteroid);
     };
  };

  Game.prototype.allObjects = function(){
      return this.asteroids.concat([this.ship]).concat(this.bullets);
  }

  Game.prototype.moveObjects = function(){

    for(var i = 0; i < this.allObjects().length; i += 1)
    {
        this.allObjects()[i].move();
    }

    this.checkCollisions();

  };

  Game.prototype.wrap = function(pos) {

    if (pos[0] > 800) {
      pos[0] -= 800;
    } else if (pos[0] < 0) {
      pos[0] += 800;
    }

    if (pos[1] > 600) {
      pos[1] -= 600;
    } else if (pos[1] < 0) {
      pos[1] += 600;
    }
  };

  Game.prototype.isOutOfBounds = function(pos){

    if (pos[0] > 800 || pos[0] < 0 || pos[1] > 600 || pos[1] < 0) {
        return true;
    } else {
        return false;
    }

  }


  Game.prototype.checkCollisions = function() {
    var that = this;

    that.allObjects().forEach(function(obj1, idx1){
        that.allObjects().forEach(function(obj2, idx2){

          if(obj1.isCollidedWith(obj2) && idx1 !== idx2){

            obj1.collidedWith(obj2);
          }
        })
    })
  };

  Game.prototype.step = function(){
    this.moveObjects();
    this.checkCollisions();
  };

  Game.prototype.remove = function (object) {
    if (object instanceof Asteroids.Asteroid) {
      var idx = this.asteroids.indexOf(object);
      this.asteroids.splice(idx, 1);
    } else if (object instanceof Asteroids.Bullet) {
      var idx = this.bullets.indexOf(object);
      this.bullets.splice(idx, 1);
    }

  };

})();

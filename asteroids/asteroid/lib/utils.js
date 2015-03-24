(function (){

  if (typeof Asteroid === "undefined") {
    window.Asteroids = {};
  }

  Asteroids.Util = {}

  Asteroids.Util.inherits = function (ChildClass, ParentClass){
    function Surrogate () {};
    Surrogate.prototype = ParentClass.prototype;
    ChildClass.prototype = new Surrogate();
  };

  Asteroids.Util.randomVec = function (length){

    var x = Math.random()
    if(x < .5)
    {
      x = -1;
    }
    else
    {
      x = 1;
    }

    var y = Math.random()
    if(y < .5)
    {
      y = -1;
    }
    else
    {
      y = 1;
    }

    return [length * Math.random() * x, length * Math.random() * y];

  };
})();

'use strict';

Function.prototype.inherits = function(obj){

    function Surrogate(){};
    Surrogate.prototype = obj.prototype;
    this.prototype = new Surrogate();
};


function MovingObject () {};

MovingObject.prototype.location = function () {
  return "Location";
};

MovingObject.prototype.partyTime = function () {
  return "It's Party Time. Excellent.";
};

function Ship () {};
Ship.inherits(MovingObject);

Ship.prototype.shipping = function (){
  return "I'm a ship."
};

function Asteroid () {};
Asteroid.inherits(MovingObject);

Asteroid.prototype.shout = function () {
  return "I'm a fucking asteroid";
};

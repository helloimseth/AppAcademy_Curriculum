'use strict';


var sum = function(){
  var accum = 0

  for (var i =0; i < arguments.length; i++) {
    accum += arguments[i];
  }

  return accum;
};

// sum(1,2,3,4,5);


Function.prototype.myBind = function(){
  var that = this;
  var argArr = Array.prototype.slice.call(arguments);
  var obj = argArr.shift();

  return function () {
    that.apply(obj, argArr);
  }
};

var obj = {
  name: "Earl Watts"
};

function greet(msg1, msg2) {
  console.log(msg1 + ": " + this.name);
  console.log(msg2 + ": " + this.name);
}

greet.myBind(obj, "sports", "potato chips")();


var curriedSum = function(numArgs){

  var nums = [];

  var _curriedSum = function(num)
  {
      nums.push(num);

      if(nums.length === numArgs){
          var accum = 0;
          nums.forEach(function(el) { accum += el });
          return accum;
      } else {
          return _curriedSum;
      }

  };
      return _curriedSum;
};

var sum = curriedSum(4);
sum(5)(30)(20)(1);




Function.prototype.curry = function(numArgs) {

    var that = this;
    var nums = [];

    var _curriedSum = function(num)
    {
        nums.push(num);

        if(nums.length === numArgs){
            return that.apply(this, nums);
        } else {
            return _curriedSum;
        }

    };
        return _curriedSum;
};

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

sumThree.curry(3)(4)(20)(6);

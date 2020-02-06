/*
  Write a function titleize that takes an array of names and a function
  (callback). titleize should use Array.prototype.map to create a new array
  full of titleized versions of each name - titleize meaning "Roger" should 
  be made to read "Mx. Roger Jingleheimer Schmidt". Then pass this new array
  of names to the callback, which should use Array.prototype.forEach to
  print out each titleized name.
*/

function titleize(arr, cb) {
  let mapped = arr.map(function(el){
    return (`Mx. ${el} Jingleheimer Schmidt`);
  })

  cb(mapped);
}

printCb = function callback(names) {
  names.forEach(function (name) {
    console.log(name);
  });
}

titleize(["Mary", "Brian", "Leo"], printCb);


//Constructor Function - Almost like a class in Ruby

function Elephant(name, height, tricks) {
  this.name = name;
  this.height = height;
  this.tricks = tricks;

}

//Prototype Functions that are availabel to any elephant that is created

Elephant.prototype.trumpet = function () {
  console.log(`${this.name} the elephant goes 'phrRRRRRRRRRRR!!!!!!!`);
}

Elephant.prototype.grow = function () {
  this.height = this.height + 12;
}

Elephant.prototype.addTrick = function (trick) {
  this.trick.push(trick);
}

Elephant.prototype.play = function () {
  trickId = Math.floor(Math.random() * this.tricks.length)
  console.log(`${this.name} is ${this.tricks[trickId]}`);
}

//Function Invocation

//Herd of Elephants

let ellie = new Elephant("Ellie", 185, ["giving human friends a ride", "playing hide and seek"]);
let charlie = new Elephant("Charlie", 200, ["painting pictures", "spraying water for a slip and slide"]);
let kate = new Elephant("Kate", 234, ["writing letters", "stealing peanuts"]);
let micah = new Elephant("Micah", 143, ["trotting", "playing tic tac toe", "doing elephant ballet"]);

let herd = [ellie, charlie, kate, micah];

Elephant.paradeHelper = function (elephant) {
  console.log(`${elephant.name} is trotting by!`);
}


function dinerBreakfast() {
  let order = ["cheesy scrambled eggs"];
  console.log(order);
  return addToOrder = function (foodItem) {
    order.push(foodItem);
    console.log(`I'd like ${order.join(" and ")} please`);
  }
}




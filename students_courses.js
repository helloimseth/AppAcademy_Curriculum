Array.prototype.includes = function (val) {
  var returnValue = false;
  this.forEach(function (el, i){
    if (val === el) {
      returnValue = true;
    }
  });
  return returnValue;
};

var Student = function(name){
  this.name = name;
  this.courses = [];
  this.courseLoad = {};
};

Student.prototype.enroll = function(course) {
  if (!this.courses.includes(course)) {
    this.courses.push(course);
    this.courseLoad[course.name] = course.numCredits
    course.add_student(this);
  }
};

var Course = function(name, department, numCredits, day, time) {
  this.name = name;
  this.department = department;
  this.numCredits = numCredits;
  this.day = day;
  this.time = time;
  this.students = [];
};

Course.prototype.add_student = function(student){
  this.students.push(student);
};

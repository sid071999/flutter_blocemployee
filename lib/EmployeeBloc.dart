//TODO: imports

//TODO: List of employees

//TODO: Stream Controller

//TODO: Stream Sink getter

//TODO:Constructor - add data; listen to changes

//TODO: Core functions

//TODO: dispose

import 'dart:async';

import 'package:flutter_blocemployee/EmployeeModel.dart';

class EmployeeBloc {
  // Similar to API call where we invoke the list
  //This time it is Hard Coded.
  List<Employee> _employeeList = [
    Employee(1, "Employee 1", 10000.0),
    Employee(2, "Employee 2", 20000.0),
    Employee(3, "Employee 3", 30000.0),
    Employee(4, "Employee 4", 40000.0),
    Employee(5, "Employee 5", 50000.0)
  ];

  // Sink to add in pipe
  // stream to get data from pipe
  //by pipe i mean data flow

  //Stream controller is needed when we want to create any object or call any function
  final _employeeListStreamController = StreamController<List<Employee>>();

//for increment and decrement

  final _employeeSalaryIncrementController = StreamController<Employee>();
  final _employeeSalaryDecrementController = StreamController<Employee>();

  //getters

  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncrementController.sink;

  StreamSink<Employee> get employeeSalaryDecrement =>
      _employeeSalaryDecrementController.sink;

  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);
    _employeeSalaryIncrementController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementController.stream.listen(_decrementSalary);
  }

  _incrementSalary(Employee employee) {
    double salary = employee.salary;
    double incrementedSalary = salary * 20 / 100;
    _employeeList[employee.id - 1].salary = salary + incrementedSalary;
    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double decrementedSalary = salary * 20 / 100;
    _employeeList[employee.id - 1].salary = salary - decrementedSalary;
    employeeListSink.add(_employeeList);
  }

  void dispose() {
    _employeeSalaryIncrementController.close();
    _employeeSalaryDecrementController.close();
    _employeeListStreamController.close();
  }
}

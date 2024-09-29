import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/employee.dart';

class DatabaseService {
  static const String _employeesKey = 'employees';

  Future<List<Employee>> getEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    final employeesJson = prefs.getString(_employeesKey);
    if (employeesJson != null) {
      final employeesList = jsonDecode(employeesJson) as List;
      return employeesList.map((e) => Employee.fromMap(e)).toList();
    }
    return [];
  }

  Future<bool> createEmployee(Employee employee) async {
    final employees = await getEmployees();
    employee = employee.copyWith(id: employees.isEmpty ? 1 : employees.last.id + 1);
    employees.add(employee);
    return await _saveEmployees(employees);
  }

  Future<bool> updateEmployee(Employee updatedEmployee) async {
    final employees = await getEmployees();
    final index = employees.indexWhere((e) => e.id == updatedEmployee.id);
    if (index != -1) {
      employees[index] = updatedEmployee;
      return await _saveEmployees(employees);
    }
    return false;
  }

  Future<bool> deleteEmployee(int id) async {
    final employees = await getEmployees();
    employees.removeWhere((e) => e.id == id);
    return await _saveEmployees(employees);
  }

  Future<bool> _saveEmployees(List<Employee> employees) async {
    final prefs = await SharedPreferences.getInstance();
    final employeesJson = jsonEncode(employees.map((e) => e.toMap()).toList());
    return await prefs.setString(_employeesKey, employeesJson);
  }
}
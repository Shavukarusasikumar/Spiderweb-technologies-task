import 'package:flutter/material.dart';
import 'package:spiderweb_technologies_task/app.dart';
import 'services/database_service.dart';
import 'models/employee.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _populateInitialData();
  runApp(const MyApp());
}

Future<void> _populateInitialData() async {
  final databaseService = DatabaseService();
  final employees = await databaseService.getEmployees();
  
  if (employees.isEmpty) {
    await databaseService.createEmployee(Employee(
      id: 1,
      name: 'sasikumar',
      department: 'IT',
      project: 'Mobile App',
      salary: 75000,
    ));
    await databaseService.createEmployee(Employee(
      id: 2,
      name: 'Hari',
      department: 'HR',
      project: 'Recruitment',
      salary: 65000,
    ));
  }
}

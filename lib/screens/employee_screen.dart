import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/employee.dart';
import '../widgets/employee_table.dart';
import '../widgets/employee_form.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final DatabaseService _databaseService = DatabaseService();
  List<Employee> _employees = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    setState(() => _isLoading = true);
    final employees = await _databaseService.getEmployees();
    setState(() {
      _employees = employees;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    _buildEmployeeList(),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEmployeeBottomSheet(context),
        tooltip: 'Add New Employee',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmployeeList() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Employee List', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            EmployeeTable(
              employees: _employees,
              onUpdate: (employee) async {
                final success = await _databaseService.updateEmployee(employee);
                if (success) {
                  _loadEmployees();
                }
              },
              onDelete: (employee) async {
                final success = await _databaseService.deleteEmployee(employee.id);
                if (success) {
                  _loadEmployees();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddEmployeeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: EmployeeForm(
              onSubmit: (employee) async {
                final success = await _databaseService.createEmployee(employee);
                if (success) {
                  _loadEmployees();
                  Navigator.pop(context);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
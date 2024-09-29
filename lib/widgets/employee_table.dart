import 'package:flutter/material.dart';
import 'package:spiderweb_technologies_task/widgets/update_employee_form.dart';
import '../models/employee.dart';

class EmployeeTable extends StatelessWidget {
  final List<Employee> employees;
  final Function(Employee) onUpdate;
  final Function(Employee) onDelete;

  const EmployeeTable({
    Key? key,
    required this.employees,
    required this.onUpdate,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20,
          headingRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
            return Theme.of(context).primaryColor.withOpacity(0.1);
          }),
          columns: const [
            DataColumn(label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Department', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Project', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Salary', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: employees.map((employee) => DataRow(
            cells: [
              DataCell(Text(employee.name)),
              DataCell(Text(employee.department)),
              DataCell(Text(employee.project)),
              DataCell(Text('\₹ ${employee.salary.toStringAsFixed(2)}')),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                    onPressed: () => _showUpdateForm(context, employee),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _showDeleteConfirmation(context, employee),
                  ),
                ],
              )),
            ],
          )).toList(),
        ),
      ),
    );
  }

  void _showUpdateForm(BuildContext context, Employee employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Employee'),
        content: UpdateEmployeeForm(
          employee: employee,
          onUpdate: onUpdate,
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Employee employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Employee'),
        content: Text('Are you sure you want to delete ${employee.name}?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              onDelete(employee);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
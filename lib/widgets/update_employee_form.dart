import 'package:flutter/material.dart';
import '../models/employee.dart';

class UpdateEmployeeForm extends StatefulWidget {
  final Employee employee;
  final Function(Employee) onUpdate;

  const UpdateEmployeeForm({
    Key? key,
    required this.employee,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _UpdateEmployeeFormState createState() => _UpdateEmployeeFormState();
}

class _UpdateEmployeeFormState extends State<UpdateEmployeeForm> {
  late TextEditingController _nameController;
  late TextEditingController _departmentController;
  late TextEditingController _projectController;
  late TextEditingController _salaryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee.name);
    _departmentController = TextEditingController(text: widget.employee.department);
    _projectController = TextEditingController(text: widget.employee.project);
    _salaryController = TextEditingController(text: widget.employee.salary.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _departmentController,
            decoration: const InputDecoration(labelText: 'Department'),
          ),
          TextField(
            controller: _projectController,
            decoration: const InputDecoration(labelText: 'Project'),
          ),
          TextField(
            controller: _salaryController,
            decoration: const InputDecoration(labelText: 'Salary'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text('Update'),
            onPressed: () {
              final updatedEmployee = Employee(
                id: widget.employee.id,
                name: _nameController.text,
                department: _departmentController.text,
                project: _projectController.text,
                salary: double.parse(_salaryController.text),
              );
              widget.onUpdate(updatedEmployee);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
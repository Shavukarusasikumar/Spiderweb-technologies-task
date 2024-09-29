import 'package:flutter/material.dart';
import '../models/employee.dart';

class EmployeeForm extends StatefulWidget {
  final Function(Employee) onSubmit;

  const EmployeeForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _departmentController = TextEditingController();
  final _projectController = TextEditingController();
  final _salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextField(
            controller: _nameController,
            label: 'Name',
            validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _departmentController,
            label: 'Department',
            validator: (value) => value!.isEmpty ? 'Please enter a department' : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _projectController,
            label: 'Project',
            validator: (value) => value!.isEmpty ? 'Please enter a project' : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _salaryController,
            label: 'Salary',
            keyboardType: TextInputType.number,
            validator: (value) => value!.isEmpty ? 'Please enter a salary' : null,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Create Employee'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      keyboardType: keyboardType,
      validator: validator,
      textInputAction: TextInputAction.next,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final employee = Employee(
        id: 0,
        name: _nameController.text,
        department: _departmentController.text,
        project: _projectController.text,
        salary: double.parse(_salaryController.text),
      );
      widget.onSubmit(employee);
      
      _nameController.clear();
      _departmentController.clear();
      _projectController.clear();
      _salaryController.clear();
      
      FocusScope.of(context).unfocus();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Employee added successfully')),
      );
    }
  }
}
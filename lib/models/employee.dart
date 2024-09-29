class Employee {
  final int id;
  final String name;
  final String department;
  final String project;
  final double salary;

  Employee({
    required this.id,
    required this.name,
    required this.department,
    required this.project,
    required this.salary,
  });

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      department: map['department'],
      project: map['project'],
      salary: map['salary'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'project': project,
      'salary': salary,
    };
  }

  Employee copyWith({
    int? id,
    String? name,
    String? department,
    String? project,
    double? salary,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      department: department ?? this.department,
      project: project ?? this.project,
      salary: salary ?? this.salary,
    );
  }
}
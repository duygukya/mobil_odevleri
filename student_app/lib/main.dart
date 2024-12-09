import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentListPage(),
    );
  }
}

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final String apiUrl = "http://192.168.1.24:3000/student";
  List students = [];

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      setState(() {
        students = json.decode(response.body);
      });
    }
  }

  Future<void> deleteStudent(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      fetchStudents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Öğrenci Sistemi'),
        backgroundColor: Color(0x009e51).withOpacity(0.8),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://cdn.pixabay.com/photo/2021/10/31/11/17/school-background-6757099_1280.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentDetailPage(
                      student: student,
                      deleteStudent: deleteStudent,
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      student['imageUrl'] ??
                          'https://images.freeimages.com/fic/images/icons/977/rrze/720/user_student.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${student['name']} ${student['surname']}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Dept: ${student['departmentID']}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudentPage()),
          ).then((_) => fetchStudents());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green, // Set the background color here
      ),
    );
  }
}

class StudentDetailPage extends StatefulWidget {
  final Map student;
  final Function(int) deleteStudent;

  StudentDetailPage({required this.student, required this.deleteStudent});

  @override
  _StudentDetailPageState createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController departmentIDController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.student['name']);
    surnameController = TextEditingController(text: widget.student['surname']);
    departmentIDController =
        TextEditingController(text: widget.student['departmentID'].toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    departmentIDController.dispose();
    super.dispose();
  }

  Future<void> updateStudent(int id) async {
    final response = await http.put(
      Uri.parse('http://192.168.1.24:3000/student/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': nameController.text,
        'surname': surnameController.text,
        'departmentID': departmentIDController.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Öğrenci başarıyla güncellendi')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Güncelleme başarısız')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Öğrenci: ${widget.student['name']} ${widget.student['surname']}'),
        backgroundColor: Color(0x009e51).withOpacity(0.5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.student['imageUrl'] ??
                  'https://images.freeimages.com/fic/images/icons/977/rrze/720/user_student.png',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'İsim'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: surnameController,
              decoration: InputDecoration(labelText: 'Soyisim'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: departmentIDController,
              decoration: InputDecoration(labelText: 'Departman Numarası'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateStudent(widget.student['studentID']); // Update student
              },
              child: Text('Öğrenciyi Güncelle'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(
                    255, 13, 114, 4), // Set the button background color here
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.deleteStudent(
                    widget.student['studentID']); // Delete student
                Navigator.pop(context); // Go back to the previous page
              },
              child: Text('Öğrenciyi Sil'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(
                    255, 13, 114, 4), // Set the button background color here
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final String apiUrl = "http://192.168.1.24:3000/student";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController departmentIDController = TextEditingController();

  Future<void> addStudent() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': nameController.text,
        'surname': surnameController.text,
        'departmentID': departmentIDController.text,
      }),
    );
    if (response.statusCode == 200) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Öğrenci Ekle'),
        backgroundColor: Color(0x009e51).withOpacity(0.3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'İsim'),
            ),
            TextField(
              controller: surnameController,
              decoration: InputDecoration(labelText: 'Soyisim'),
            ),
            TextField(
              controller: departmentIDController,
              decoration: InputDecoration(labelText: 'Departman Numarası'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addStudent,
              child: Text('Öğrenci Ekle'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(
                    255, 13, 114, 4), // Set the button background color here
              ),
            ),
          ],
        ),
      ),
    );
  }
}

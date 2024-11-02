import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kullanıcı Formu'),
          backgroundColor: Colors.teal,
        ),
        body: UserForm(),
      ),
    );
  }
}

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';

  String? _validateEmail(String? value) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (value == null || value.isEmpty) {
      return 'E-posta adresi boş olamaz.';
    } else if (!regex.hasMatch(value)) {
      return 'Geçerli bir e-posta adresi girin.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre boş olamaz.';
    } else if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır.';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form başarıyla gönderildi!')),
      );
      print(
          'İsim: $_firstName, Soyisim: $_lastName, E-posta: $_email, Şifre: $_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/arkaplan.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Container(
              width: 400,
              height: 550,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField('İsim', (value) => _firstName = value ?? '',
                      hintText: 'Duygu'),
                  _buildTextField('Soyisim', (value) => _lastName = value ?? '',
                      hintText: 'Kaya'),
                  _buildTextField('E-posta', (value) => _email = value ?? '',
                      hintText: 'ex@ex.com', validator: _validateEmail),
                  _buildTextField('Şifre', (value) => _password = value ?? '',
                      hintText: '******',
                      obscureText: true,
                      validator: _validatePassword),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Gönder'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSaved,
      {bool obscureText = false,
      String? Function(String?)? validator,
      required String hintText}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(),
            ),
            onSaved: onSaved,
            obscureText: obscureText,
            validator: validator ??
                (value) {
                  if (value == null || value.isEmpty) {
                    return '$label boş olamaz.';
                  }
                  return null;
                },
          ),
        ],
      ),
    );
  }
}

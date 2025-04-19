import 'package:flutter/material.dart';
import 'package:projektugas3/pages/homepage.dart';
import '../util/local_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isObscure = true;
  bool _isError = false;

  void login() async {
    if (_username.text.trim() == "123" && _password.text == "123") {
      setState(() {
        _isError = false;
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()));
      await LocalStorage.login(_username.text.trim());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Username atau password salah!")),
      );
      setState(() {
        _isError = true;
      });
    }
  }

  Widget redEye() {
    return InkWell(
      onTap: () {
        setState(() {
          _isObscure = !_isObscure;
        });
      },
      child: Icon(
        _isObscure
            ? Icons.remove_red_eye_outlined
            : Icons.visibility_off_outlined,
        color: _isError ? Colors.pink.shade800 : Colors.pink.shade300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[700],
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Silakan login untuk melanjutkan.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.pink[400],
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _username,
                decoration: InputDecoration(
                  labelText: "Username",
                  labelStyle: TextStyle(color: Colors.pink),
                  prefixIcon: Icon(Icons.person_outline, color: Colors.pink),
                  errorText: _isError ? ' ' : null,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _password,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.pink),
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.pink),
                  suffixIcon: redEye(),
                  errorText: _isError ? ' ' : null,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: width,
                height: 48,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

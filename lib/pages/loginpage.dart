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
        color: _isError ? Colors.red.shade800 : Colors.grey.shade600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Silakan login untuk melanjutkan.",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _username,
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Icons.person_outline),
                  errorText: _isError ? ' ' : null, // hanya untuk merah
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _password,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: redEye(),
                  errorText: _isError ? ' ' : null, // hanya untuk merah
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: width,
                height: 48,
                child: ElevatedButton(
                  onPressed: login,
                  child: Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

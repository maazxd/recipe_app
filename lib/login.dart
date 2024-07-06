import 'package:flutter/material.dart';
import 'package:recipe_app/services/auth_services.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  String? username, password;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          _loginform(),
        ],
      ),
    );
  }

  Widget _title() {
    return const Text(
      "Recipe Book",
      style: TextStyle(fontSize: 45, fontWeight: FontWeight.w300),
    );
  }

  Widget _loginform() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.30,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: "emilys",
              onSaved: (value) {
                setState(() {
                  username = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter a username";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Username",
                hoverColor: Color.fromARGB(255, 15, 184, 35),
              ),
            ),
            TextFormField(
              initialValue: "emilyspass",
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
              validator: (value) {
                if (value == null || value.length < 8) {
                  return "Enter a valid password";
                }
              },
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            _loginbutton(),
          ],
        ),
      ),
    );
  }

  Widget _loginbutton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.90,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (_isHovered) return Colors.blueAccent; // Hover color
                return Color.fromARGB(255, 211, 122, 13); // Normal color
              },
            ),
          ),
          onPressed: () async {
            if (_loginFormKey.currentState?.validate() ?? false) {
              _loginFormKey.currentState?.save();
              bool result = await AuthServices().login(username!, password!);
              if (result) {
                Navigator.pushReplacementNamed(context, "/home");
              } else {
                StatusAlert.show(
                  context,
                  duration: const Duration(
                    seconds: 2,
                  ),
                  title: "login failled",
                  subtitle: "try again",
                  configuration: const IconConfiguration(
                    icon: Icons.error,
                    color: Colors.red,
                    size: 60,
                  ),
                  maxWidth: 260,
                  backgroundColor: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(67)),
                  dismissOnBackgroundTap: true,
                );
              }
            }
          },
          child: const Text("Login"),
        ),
      ),
    );
  }
}

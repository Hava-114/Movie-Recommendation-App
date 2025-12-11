import 'package:flutter/material.dart';
import 'package:movie_app/view/load_data.dart';
import 'package:provider/provider.dart';
import '../view_models/login_view.dart';
import '../view/movie.dart';


class Login extends StatefulWidget {

  

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginView>(context);
    return Scaffold(
      body: Center(child: Container(
       decoration: BoxDecoration(
         color: Colors.purple.withOpacity(0.25),
    borderRadius: BorderRadius.circular(20), // <-- Curve all edges
  ), 
        width: 350,
        height: 450,
       
        child:Padding(
        
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height:100),
              Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: vm.setUsername,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter email';
                  final pattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
                  if (!RegExp(pattern).hasMatch(value)) return 'Enter a valid email';
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: vm.setPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter password';
                  if (value.length < 6) return 'Password must be at least 6 characters';
                  return null;
                },
              ),
              SizedBox(height: 30),
              if (vm.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    vm.errorMessage!,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              ElevatedButton(
                onPressed: vm.isLoading
                    ? null
                    : () async {
                        debugPrint('Login button pressed. Email: ${vm.username}');
                        if (_formKey.currentState!.validate()) {
                          // wait for the async login call to finish
                          await vm.login();

                          if (vm.isLoggedIn) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => Home()),
                            );
                          } else {
                            // show the error from the login provider if available
                            final message = vm.errorMessage ?? 'Invalid credentials';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(message)),
                            );
                          }
                        }
                      },
                child: vm.isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text('Login', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: vm.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          await vm.signup();
                          if (vm.isLoggedIn) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => AddData()),
                            );
                          } else {
                            final message = vm.errorMessage ?? 'Signup failed';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(message)),
                            );
                          }
                        }
                      },
                child: const Text('Create account'),
              ),
            ],
          ),
        ),
      ),
    )));
  }
}
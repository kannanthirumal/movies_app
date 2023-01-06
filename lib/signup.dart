import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _signUpWithEmailAndPassword(BuildContext context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            clipBehavior: Clip.hardEdge,
            title: const Text("Alert Dialog Box"),
            content: const Text("The account already exists for this email."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => MyApp()),
                          (Route<dynamic> route) => false);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(style: BorderStyle.none),
                    color: Color.fromRGBO(220, 220, 220, 1.0),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: const Text("Login Page",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 15.0, top: 20.0),
          child: Text(
            'Signup',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(230, 230, 230, 1.0),
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.network(
                      'https://images.unsplash.com/photo-1611162617474-5b21e879e113?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bmV0ZmxpeHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
                      fit: BoxFit.cover,
                    ),
                    height: 220.0,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(style: BorderStyle.none),
                      color: const Color.fromRGBO(100, 100, 100, 1.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  'Email Address',
                  style: TextStyle(
                    color: Colors.grey.shade200,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(style: BorderStyle.none),
                    // color: Color.fromRGBO(220, 220, 220, 1.0),
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(220, 220, 220, 1.0),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      hintText: 'Enter your email',
                    ),
                    cursorColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  'Password',
                  style: TextStyle(
                    color: Colors.grey.shade200,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(style: BorderStyle.none),
                    // color: Color.fromRGBO(220, 220, 220, 1.0),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(220, 220, 220, 1.0),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      hintText: 'Enter your password',
                    ),
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Builder(builder: (context) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      backgroundColor: const Color.fromRGBO(100, 100, 100, 1.0),
                      minimumSize: Size(double.infinity, 60),
                      maximumSize: Size(double.infinity, 60),
                    ),
                    onPressed: () => _signUpWithEmailAndPassword(context),
                    child: const Text(
                      'Signup',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                  ),
                  SizedBox(width: 10),
                  Builder(
                      builder: (BuildContext context) {
                        return TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => MyApp()));
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Color.fromRGBO(220, 220, 220, 1.0),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

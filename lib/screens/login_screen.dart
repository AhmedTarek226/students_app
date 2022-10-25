import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:students_app/service/user_api.dart';
import '../models/user.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final user = User(UserName: "", Password: "");
  var userApi = UserApi();
  bool isLoading = false;

  Login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState?.save();
      userApi.Login(user).then((value) {
        setState(() {
          isLoading = false;
        });
        if (value.contentLength! <= 74) {
          print("fail");
        } else {
          Navigator.pushReplacementNamed(context, "/home");
          print("success");
        }

        // print(value.headers);
      }).catchError((err) => print(err));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: isLoading
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.deepOrange,
                    size: 30,
                  ),
                )
              : Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListView(
                      children: [
                        Image.asset("assets/images/login.png"),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text("UserName"),
                            prefixIcon: Icon(Icons.person),
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            user.UserName = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field is required";
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text("Password"),
                            prefixIcon: Icon(Icons.password),
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          onChanged: (value) {
                            user.Password = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field is required";
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                Login();
                              });
                            },
                            child: Text("Login"))
                      ],
                    ),
                  ))),
    );
  }
}

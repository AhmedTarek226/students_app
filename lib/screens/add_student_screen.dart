import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:students_app/models/student.dart';
import 'package:students_app/service/student_api.dart';
import 'package:students_app/service/user_api.dart';
import '../models/user.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final student = Student(
      FirstName: "",
      Age: 0,
      Email: "",
      LastName: "",
      Mobile: "",
      NationalID: "");
  var studentApi = StudentApi();
  bool isLoading = false;

  AddStudent() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState?.save();
      studentApi.AddStudent(student).then((value) {
        setState(() {
          isLoading = false;
        });
        if (value.contentLength! <= 74) {
          print("fail");
        } else {
          Navigator.pushNamed(context, "/home");
          print("success");
        }
        print(value);
        // print(value.headers);
      }).catchError((err) => print(err));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              title: Text(
                "Add Student",
                style: TextStyle(fontSize: 17),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      AddStudent();
                    });
                  },
                  icon: Icon(Icons.save),
                ),
              ]),
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
                        Container(
                            height: 200,
                            child:
                                Image.asset("assets/images/add_student.png")),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text("First Name"),
                            prefixIcon: Icon(Icons.person),
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            student.FirstName = value;
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
                            label: Text("Last Name"),
                            prefixIcon: Icon(Icons.person),
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            student.LastName = value;
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
                            label: Text("Mobile"),
                            prefixIcon: Icon(Icons.phone),
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            student.Mobile = value;
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
                            label: Text("Email"),
                            prefixIcon: Icon(Icons.email),
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            student.Email = value;
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
                            label: Text("National ID"),
                            prefixIcon: Icon(Icons.credit_card),
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            student.NationalID = value;
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
                            label: Text("Age"),
                            prefixIcon:
                                Icon(Icons.keyboard_double_arrow_right_rounded),
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            student.Age = int.parse(value);
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
                                AddStudent();
                              });
                            },
                            child: Text("Login"))
                      ],
                    ),
                  ))),
    );
  }
}

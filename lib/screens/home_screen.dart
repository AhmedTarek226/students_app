import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:students_app/models/student.dart';
import 'package:students_app/service/student_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<dynamic> students = [];
  var studentApi = StudentApi();

  @override
  void initState() {
    studentApi.GetStudents().then((value) {
      setState(() {
        students = value;
      });
      print(students[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "add_student");
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
            title: Text(
              "Home Page",
              style: TextStyle(fontSize: 17),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.person),
              ),
            ]),
        body: Container(
          child: ListView.builder(
            itemBuilder: ((context, index) {
              return ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      // border: Border.all(color: Colors.black87),
                      borderRadius: BorderRadius.circular(40)),
                  padding: EdgeInsets.all(15),
                  child: Text(
                    students[index]["ID"].toString(),
                    style: TextStyle(
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                title: Text(students[index]["Name"]),
                subtitle: Text(students[index]["Mobile"]),
              );
            }),
            itemCount: students.length,
          ),
        ),
      ),
    );
  }
}

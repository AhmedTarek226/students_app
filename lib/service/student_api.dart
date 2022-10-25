import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:students_app/models/student.dart';
import 'package:students_app/models/user.dart';

class StudentApi {
  Future<List<dynamic>> GetStudents() async {
    Uri url = Uri.https("api.mohamed-sadek.com", "/Student/Get");
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    var studentsList = data["Data"] as List;
    // print(studentsList[0]);
    return studentsList;
  }

  Future<http.Response> AddStudent(Student student) async {
    Uri url = Uri.https("api.mohamed-sadek.com", "/Student/POST");
    return http.post(url,
        body: jsonEncode(<String, Object>{
          "FirstName": student.FirstName,
          "Email": student.Email,
          "Mobile": student.Mobile,
          "LastName": student.LastName,
          "Age": student.Age,
          "NationalID": student.NationalID,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }
}

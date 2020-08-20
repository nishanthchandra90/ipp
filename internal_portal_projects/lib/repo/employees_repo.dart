import 'dart:convert';
import 'dart:io';

import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/model/project_details.dart';

class EmployeesRepo {
  static HttpClient httpClient = new HttpClient();
  static EmployeesRepo _instance = new EmployeesRepo.internal();
  static String localIp = "192.168.2.104";
  static String port = "8080";

  EmployeesRepo.internal();

  factory EmployeesRepo() => _instance;

  static getAllUsers() async {
    StringBuffer urlStringBuffer = new StringBuffer("http://");
    urlStringBuffer.write(localIp);
    urlStringBuffer.write(":");
    urlStringBuffer.write(port);
    urlStringBuffer.write("/getAllEmployees");
    final request =
        await httpClient.getUrl(Uri.parse(urlStringBuffer.toString()));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    urlStringBuffer.clear();
    return await request.close();
  }

  static updatePWD(String empId, String pwd) async {
    StringBuffer urlStringBuffer = new StringBuffer("http://");
    urlStringBuffer.write(localIp);
    urlStringBuffer.write(":");
    urlStringBuffer.write(port);
    urlStringBuffer.write("/updatePWD");
    final request =
        await httpClient.postUrl(Uri.parse(urlStringBuffer.toString()));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    urlStringBuffer.clear();
    String data = empId + ":" + pwd;
    request.add(utf8.encode(data));
    return await request.close();
  }

  static getUserById(String name) async {
    StringBuffer urlStringBuffer = new StringBuffer("http://");
    urlStringBuffer.write(localIp);
    urlStringBuffer.write(":");
    urlStringBuffer.write(port);
    urlStringBuffer.write("/getEmployeeById");
    urlStringBuffer.write("?empId=" + name);

    final request =
        await httpClient.getUrl(Uri.parse(urlStringBuffer.toString()));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    urlStringBuffer.clear();
    return await request.close();
  }

  static isNewUser(String emailId) async {
    StringBuffer urlStringBuffer = new StringBuffer("http://");
    urlStringBuffer.write(localIp);
    urlStringBuffer.write(":");
    urlStringBuffer.write(port);
    urlStringBuffer.write("/isNewUser");
    urlStringBuffer.write("?email=" + emailId);

    final request =
        await httpClient.getUrl(Uri.parse(urlStringBuffer.toString()));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    urlStringBuffer.clear();
    return await request.close();
  }

  static isRegisteredUser(String emailId) async {
    StringBuffer urlStringBuffer = new StringBuffer("http://");
    urlStringBuffer.write(localIp);
    urlStringBuffer.write(":");
    urlStringBuffer.write(port);
    urlStringBuffer.write("/isRegisteredUser");
    urlStringBuffer.write("?email=" + emailId);

    final request =
        await httpClient.getUrl(Uri.parse(urlStringBuffer.toString()));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    urlStringBuffer.clear();
    return await request.close();
  }

  static newUser(EmployeeDetails employee) async {
    StringBuffer urlStringBuffer = new StringBuffer("http://");
    urlStringBuffer.write(localIp);
    urlStringBuffer.write(":");
    urlStringBuffer.write(port);
    urlStringBuffer.write("/saveEmployee");
    final request =
        await httpClient.postUrl(Uri.parse(urlStringBuffer.toString()));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    urlStringBuffer.clear();
    request.add(utf8.encode(json.encode(employee.toJson())));
    return await request.close();
  }

  updateUser(ProjectDetails project) async {}

  deleteUser(String id) async {}
}

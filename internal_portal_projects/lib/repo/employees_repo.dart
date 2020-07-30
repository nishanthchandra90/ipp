import 'dart:io';

import 'package:internal_portal_projects/model/project_details.dart';

class EmployeesRepo {
  HttpClient httpClient = new HttpClient();
  static EmployeesRepo _instance = new EmployeesRepo.internal();
  String localIp = "192.168.2.104";
  String port = "8080";

  EmployeesRepo.internal();

  factory EmployeesRepo() => _instance;

  getAllUsers() async {
    StringBuffer urlStringBuffer = new StringBuffer("http://");
    urlStringBuffer.write(localIp);
    urlStringBuffer.write(":");
    urlStringBuffer.write(port);
    urlStringBuffer.write("/getAllUsers");
    final request =
        await httpClient.getUrl(Uri.parse(urlStringBuffer.toString()));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    urlStringBuffer.clear();
    return await request.close();
  }

  getUserByEmailName(String emailOrName) async {
    StringBuffer urlStringBuffer = new StringBuffer("http://");
    urlStringBuffer.write(localIp);
    urlStringBuffer.write(":");
    urlStringBuffer.write(port);
    urlStringBuffer.write("/getUserByEmailName");
    urlStringBuffer.write("?emailOrName=" + emailOrName);
    final request =
        await httpClient.getUrl(Uri.parse(urlStringBuffer.toString()));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    urlStringBuffer.clear();
    return await request.close();
  }

  newUser(ProjectDetails newProject) async {}

  updateUser(ProjectDetails project) async {}

  deleteUser(String id) async {}
}

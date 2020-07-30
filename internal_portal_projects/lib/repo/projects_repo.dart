import 'dart:io';

import 'package:internal_portal_projects/model/project_details.dart';

class ProjectsRepo {
  HttpClient httpClient = new HttpClient();
  static ProjectsRepo _instance = new ProjectsRepo.internal();
  String localIp = "192.168.2.104";
  String port = "8080";

  ProjectsRepo.internal();

  factory ProjectsRepo() => _instance;

  getAppliedProjects(String empId) async {
    StringBuffer urlStringBuffer = new StringBuffer("http://");
    urlStringBuffer.write(localIp);
    urlStringBuffer.write(":");
    urlStringBuffer.write(port);
    urlStringBuffer.write("/getAppliedProjects");
    urlStringBuffer.write("?empId=" + empId);
    final request =
        await httpClient.getUrl(Uri.parse(urlStringBuffer.toString()));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    urlStringBuffer.clear();
    return await request.close();
  }

  getMatchedProjects(String empId) async {
    StringBuffer urlStringBuffer = new StringBuffer("http://");
    urlStringBuffer.write(localIp);
    urlStringBuffer.write(":");
    urlStringBuffer.write(port);
    urlStringBuffer.write("/getMatchedProjects");
    urlStringBuffer.write("?empId=" + empId);
    final request =
        await httpClient.getUrl(Uri.parse(urlStringBuffer.toString()));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    urlStringBuffer.clear();
    return await request.close();
  }

  getAllProjects() async {
    StringBuffer urlStringBuffer = new StringBuffer("http://");
    urlStringBuffer.write(localIp);
    urlStringBuffer.write(":");
    urlStringBuffer.write(port);
    urlStringBuffer.write("/getAllProjects");
    final request =
        await httpClient.getUrl(Uri.parse(urlStringBuffer.toString()));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    urlStringBuffer.clear();
    return await request.close();
  }

  newProject(ProjectDetails newProject) async {}

  updateProject(ProjectDetails project) async {}

  deleteProject(String id) async {}
}

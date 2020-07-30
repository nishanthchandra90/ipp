import 'dart:convert';
import 'dart:io';

import 'package:internal_portal_projects/model/project_details.dart';
import 'package:internal_portal_projects/model/project_skills.dart';

class ProjectsRepo {
  HttpClient httpClient = new HttpClient();
  static ProjectsRepo _instance = new ProjectsRepo.internal();
  String localIp = "192.168.2.104";
  String port = "8080";

  ProjectsRepo.internal();

  factory ProjectsRepo() => _instance;

  postMatchRate(String skills) async {
    StringBuffer urlStringBuffer = new StringBuffer("http://");
    urlStringBuffer.write(localIp);
    urlStringBuffer.write(":");
    urlStringBuffer.write(port);
    urlStringBuffer.write("/getMatchedProjects");
    final request =
        await httpClient.postUrl(Uri.parse(urlStringBuffer.toString()));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    var jsonData = json.encode(new ProjectSkill("skills", skills));
    request.add(utf8.encode(jsonData));
    return await request.close();
  }

  getAllProjects() async {
    StringBuffer urlStringBuffer = new StringBuffer("http://");
    urlStringBuffer.write(localIp);
    urlStringBuffer.write(":");
    urlStringBuffer.write(port);
    urlStringBuffer.write("/getAllProjects");
    final request =
        await httpClient.postUrl(Uri.parse(urlStringBuffer.toString()));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    urlStringBuffer.clear();
    return await request.close();
  }

  newProject(ProjectDetails newProject) async {}

  updateProject(ProjectDetails project) async {}

  deleteProject(String id) async {}
}

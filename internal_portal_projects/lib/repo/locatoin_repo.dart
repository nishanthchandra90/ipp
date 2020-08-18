import 'dart:io';

class LocationRepo {
  HttpClient httpClient = new HttpClient();
  static LocationRepo _instance = new LocationRepo.internal();
  String localIp = "192.168.2.104";
  String port = "8080";

  LocationRepo.internal();

  factory LocationRepo() => _instance;

  getCompanyLocations() async {
    StringBuffer urlStringBuffer = new StringBuffer("http://");
    urlStringBuffer.write(localIp);
    urlStringBuffer.write(":");
    urlStringBuffer.write(port);
    urlStringBuffer.write("/getCompanyLocations");
    final request =
        await httpClient.getUrl(Uri.parse(urlStringBuffer.toString()));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    urlStringBuffer.clear();
    return await request.close();
  }

  getCompanyBuildings() async {
    StringBuffer urlStringBuffer = new StringBuffer("http://");
    urlStringBuffer.write(localIp);
    urlStringBuffer.write(":");
    urlStringBuffer.write(port);
    urlStringBuffer.write("/getBuildings");
    final request =
        await httpClient.getUrl(Uri.parse(urlStringBuffer.toString()));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    urlStringBuffer.clear();
    return await request.close();
  }

}

import 'dart:convert';

import 'package:internal_portal_projects/repo/locatoin_repo.dart';

class LocationService {
  static  getAllLocations() async {
    var response = await new LocationRepo().getCompanyLocations();
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      List<String> locationList =
          (jsonDecode(reply) as List<dynamic>).cast<String>();
      return locationList;
    }
    return [];
  }

  static  getAllBuildings() async {
    var response = await new LocationRepo().getCompanyBuildings();
    if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      List<String> buildingList =
          (jsonDecode(reply) as List<dynamic>).cast<String>();
      return buildingList;
    }
    return [];
  }
}

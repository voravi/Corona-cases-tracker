import 'dart:convert';
import 'dart:developer';
import 'package:covid_app/modals/covid_traker.dart';
import 'package:http/http.dart' as http;

class CovidData {

  CovidData._();

  static final CovidData covidData = CovidData._();

  Future<List<Covid>?> fetchWorldData() async {
    http.Response response = await http.get(
      Uri.parse("https://covid-19.dataflowkit.com/v1"),
    );
    if (response.statusCode == 200) {
      List<dynamic> decodedData = jsonDecode(response.body);

      List<Covid>? covidData =
          decodedData.map((e) => Covid.fromMap(data: e)).toList();

      return covidData;
    }
    return null;
  }

  // Future<Map?> fetchCountyData() async {
  //   http.Response response = await http.get(
  //     Uri.parse("https://covid-19.dataflowkit.com/v1/world"),
  //   );
  //   if (response.statusCode == 200) {
  //     Map decodedData = jsonDecode(response.body);
  //
  //     Map covidData = Covid.fromMap(data: decodedData[0]) as Map;
  //
  //     return covidData;
  //   }
  //   return null;
  // }
}

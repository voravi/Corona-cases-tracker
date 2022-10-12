import 'package:covid_app/helpers/covid_api_helper.dart';
import 'package:covid_app/modals/covid_traker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  int? controllerData;

  List choices = ["World", "Country", "State"];
  String dropDownValue = "Country";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid 19 Tracker"),
        actions: [
          DropdownButton(
              value: dropDownValue,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              dropdownColor: Colors.blueAccent,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: choices.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  dropDownValue = val.toString();
                });
              })
        ],
      ),
      body: FutureBuilder(
        future: CovidData.covidData.fetchWorldData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<Covid>? data = snapshot.data;

            return (dropDownValue == "World") ?  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Country: ",
                        style: TextStyle(fontSize: 17),
                      ),
                      TextSpan(
                        text: "${data![0].country}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Total Cases: ${data[0].totalCases}",
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  "Total Deaths: ${data[0].totalDeaths}",
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  "Total Recovers: ${data[0].totalRecover}",
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  "Last Updated: ${data[0].lastUpdated}",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            )  :ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: data!.length,
              itemBuilder: (context, i) {
                return Card(
                  elevation: 3,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 380,
                      padding: const EdgeInsets.all(10),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Country: ",
                                  style: TextStyle(fontSize: 17),
                                ),
                                TextSpan(
                                  text: "${data[i].country}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Total Cases: ${data[i].totalCases}",
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            "Total Deaths: ${data[i].totalDeaths}",
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            "Total Recovers: ${data[i].totalRecover}",
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            "Last Updated: ${data[i].lastUpdated}",
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

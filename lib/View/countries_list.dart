import 'package:covidapp/Services/states_services.dart';
import 'package:covidapp/View/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  StateServices stateServices = StateServices();
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: textEditingController,
                onChanged: (val) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    hintText: "Search with country name",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: stateServices.fetchCountriesList(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 15,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                  title: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ));
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (textEditingController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              name: name,
                                              totalCases: snapshot.data![index]
                                                  ['cases'],
                                              totalDeaths: snapshot.data![index]
                                              ['deaths'],
                                              totalRecovered: snapshot.data![index]
                                              ['recovered'],
                                              active: snapshot.data![index]
                                              ['active'],
                                              critical: snapshot.data![index]
                                              ['critical'],
                                              todayRecovered: snapshot.data![index]
                                              ['todayRecovered'],
                                              test: snapshot.data![index]
                                              ['tests'])));
                                },
                                child: ListTile(
                                  leading: Image.network(
                                    snapshot.data![index]['countryInfo']
                                        ['flag'],
                                    height: 50,
                                    width: 50,
                                  ),
                                  title: Text(
                                    snapshot.data![index]['country'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index]['cases'].toString(),
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else if (name.toLowerCase().contains(
                            textEditingController.text.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                          image: snapshot.data![index]
                                          ['countryInfo']['flag'],
                                          name: name,
                                          totalCases: snapshot.data![index]
                                          ['cases'],
                                          totalDeaths: snapshot.data![index]
                                          ['deaths'],
                                          totalRecovered: snapshot.data![index]
                                          ['recovered'],
                                          active: snapshot.data![index]
                                          ['active'],
                                          critical: snapshot.data![index]
                                          ['critical'],
                                          todayRecovered: snapshot.data![index]
                                          ['todayRecovered'],
                                          test: snapshot.data![index]
                                          ['tests'])));
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Image.network(
                                    snapshot.data![index]['countryInfo']
                                        ['flag'],
                                    height: 50,
                                    width: 50,
                                  ),
                                  title: Text(
                                    snapshot.data![index]['country'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index]['cases'].toString(),
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

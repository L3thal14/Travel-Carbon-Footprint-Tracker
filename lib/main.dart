
/*
Author: Karthik R
Github : https://github.com/L3thal14
Application Name: Travel Carbon Footprint Tracker
API Used: https://triptocarbon.com/documentation
*/
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
void main() => runApp(new MaterialApp(
  debugShowCheckedModeBanner: false,
      home: new HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  Future<void> _showInfoDialog() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          backgroundColor: Colors.blueGrey,
          title: const Text('Travel Carbon Footprint Tracker', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15,fontFamily: 'Baloo',color: Colors.white,fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                new Text(' Developed by Karthik', textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Text(
                    'https://github.com/L3thal14',
                    style: TextStyle(
                      fontSize: 18,fontFamily: 'Poppins',color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () => _launchUrl()
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('OK',style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  final String url = "http://api.triptocarbon.xyz/v1/footprint";
  String dataset;
  String activity;
  String activityType;
  String country;
  String mode;
  String fueltype;
  bool carbonflag;
  var carbon;
  @override
  void initState() {
    super.initState();
    this.getJsonData();
   
  }
 
  Future<String> getJsonData() async {
    var uri = Uri.parse(url);
    uri = uri.replace(queryParameters: <String, String>{
      'activity': activity,
      'activityType': 'miles',
      'country': country,
      'mode': mode,
      'fuelType': fueltype,
      'appTkn': '' // Add the API token here
    });
    print(uri);
    var response = await http.get(uri, headers: {"Accept": "application/json"});

    print(response.body);

    setState(() {
      var toJsonData = json.decode(response.body);
      dataset = toJsonData['carbonFootprint'];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return new Scaffold(
      backgroundColor: Colors.white,
        appBar: new AppBar(
          backgroundColor: Colors.blueGrey,
          title: new Text(
            "Travel Carbon Footprint Tracker",
            style: TextStyle(color: Colors.black, fontFamily: 'Roboto'),
          ),
          centerTitle: true,
          actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          )
        ],
        ),
        body: new ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                  child: new Center(
                      child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Card(
                    elevation: 15,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.shutter_speed,
                            color: Color(0xffca3e47),
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: deviceWidth * 0.2,
                                ),
                                hintText: "Distance in Miles",
                                hintStyle: TextStyle(
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  activity = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Card(
                    elevation: 15,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.local_gas_station,
                            color: Color(0xffca3e47),
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                isDense: true,
                                labelText: 'Fuel Type',
                                labelStyle: TextStyle(fontFamily: 'Roboto'),
                                contentPadding:
                                    EdgeInsets.only(left: deviceWidth * 0.25,top:10),
                              ),
                              items: [
                                DropdownMenuItem<String>(
                                  value: "motorGasoline",
                                  child: Text('Petrol'),
                                ),
                                DropdownMenuItem<String>(
                                  value: "diesel",
                                  child: Text('Diesel'),
                                ),
                                DropdownMenuItem<String>(
                                  value: "aviationGasoline",
                                  child: Text('Aviation Gasoline'),
                                ),
                                DropdownMenuItem<String>(
                                  value: "jetFuel",
                                  child: Text('Jet Fuel'),
                                ),
                              ],
                              onChanged: (valuefuel) {
                                setState(() {
                                  fueltype = valuefuel;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Card(
                    elevation: 15,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.flag,
                            color: Color(0xffca3e47),
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child:Center(
                          child: DropdownButtonFormField(
                            elevation: 15,
                        isExpanded: true,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                            
                              isDense: true,
                              labelText: 'Country',
                              contentPadding:
                                  EdgeInsets.only(left: deviceWidth * 0.25,top:10),
                            ),
                            items: [
                              DropdownMenuItem<String>(
                                value: "usa",
                                child: Text('USA'),
                              ),
                              DropdownMenuItem<String>(
                                value: "gbr",
                                child: Text('UK'),
                              ),
                              DropdownMenuItem<String>(
                                value: "def",
                                child: Text('Others'),
                              ),
                            ],
                            onChanged: (valuecountry) {
                              setState(() {
                                country = valuecountry;
                              });
                            },
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Card(
                    elevation: 15,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.directions_car,
                            color: Color(0xffca3e47),
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              isDense: true,
                              labelText: 'Mode',
                              contentPadding:
                                  EdgeInsets.only(left: deviceWidth * 0.25,top:10),
                            ),
                            items: [
                              DropdownMenuItem<String>(
                                value: "dieselCar",
                                child: Text('Diesel Car'),
                              ),
                              DropdownMenuItem<String>(
                                value: "petrolCar",
                                child: Text('Petrol Car'),
                              ),
                              DropdownMenuItem<String>(
                                value: "taxi",
                                child: Text('Taxi'),
                              ),
                              DropdownMenuItem<String>(
                                value: "motorbike",
                                child: Text('Motorbike'),
                              ),
                              DropdownMenuItem<String>(
                                value: "bus",
                                child: Text('Bus'),
                              ),
                              DropdownMenuItem<String>(
                                value: "transitRail",
                                child: Text('Transit Rail'),
                              ),
                            ],
                            onChanged: (valuemode) {
                              setState(() {
                                mode = valuemode;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RaisedButton(
                      onPressed: () => getJsonData(),
                      child: Text('Calculate Carbon Footprint'),
                      color: Colors.green,
                      ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
                  new Card(
                    color: Colors.blueGrey,
                    child: new Container(
                      child: new Text( '${dataset != 'null' ?  '$dataset' : ''} kg'.replaceAll('null', 'Waiting'),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      padding: const EdgeInsets.all(20),
                    ),
                  ),
  ],
                  ),
                ],
              )));
            }));
  }
}
_launchUrl() async {
  final String url = "https://github.com/L3thal14";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
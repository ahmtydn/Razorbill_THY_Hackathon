import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import '../CustomShapeClipper.dart';
import '../flight/FlightTimeLine.dart';
import '../models/UnitModel/PortListModel.dart';
import '../models/authmodel/TokenModel.dart';

Color firstColor = Color(0xFFEAB707);
Color secondColor = Color(0xFFF6F604);

ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFFF3791A),
);
var kalkisCode = "IST";
var kalkisName = "İstanbul Havalimanı";
var inisCode = "JFK";
var inisName = "JOHN F KENNEDY";

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeSCreenTopPart(),
        ],
      ),
    );
  }
}

const TextStyle dropdawnLabelStyle =
    TextStyle(color: Colors.black, fontSize: 30.0);
const TextStyle dropdawnMenuItemStyle =
    TextStyle(color: Colors.black, fontSize: 18.0);

class HomeSCreenTopPart extends StatefulWidget {
  const HomeSCreenTopPart({Key? key}) : super(key: key);

  @override
  State<HomeSCreenTopPart> createState() => _HomeSCreenTopPartState();
}

var selectedLocationIndex = 0;

class _HomeSCreenTopPartState extends State<HomeSCreenTopPart> {
  @override
  Widget build(BuildContext context) {
    return homeScreen();
  }
}

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  DateTime _dataTime = DateTime(2022, 08, 08);

  List<GetPortsListModel> parsePortResponse(String response) {
    final model = getPortsListModelFromJson(response);
    return model;
  }

  Future<List<GetPortsListModel>> PortListView(TokenModel tokenModel) async {
    final response = await http.get(
        Uri.parse("https://tk1919.herokuapp.com/api/thy/ports"),
        headers: {'Authorization': "Bearer ${tokenModel.accessToken}"});
    return parsePortResponse(response.body);
  }

  Future<List<GetPortsListModel>> PortDataGoster() async {
    var sp = await SharedPreferences.getInstance();
    var token = sp.get("token");
    TokenModel tokenModel = TokenModel(accessToken: token.toString());
    var model = await PortListView(tokenModel);
    return model;
  }

/*
  Future<List<String>> PortSonucGoster() async {
    //var model=await PortDataGoster();
    //var list=model.port;
    var list=<String>["IST","SAW"];
    return list;
  }*/
  var inisController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    inisController.text = "JFK";
    return FutureBuilder<List<GetPortsListModel>>(
        future: PortDataGoster(),
        builder: (context, snapshot) {
          var searchListesi = snapshot.data;
          return searchListesi == null
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    ClipPath(
                        clipper: CustomShapeClipper(),
                        child: Container(
                          height: 300.0,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            firstColor,
                            secondColor,
                          ])),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.flight_takeoff,
                                      color: Colors.black,
                                      size: 56,
                                    ),
                                    SizedBox(
                                      width: 2.0,
                                    ),
                                    PopupMenuButton(
                                      onSelected: (index) {
                                        setState(() {
                                          selectedLocationIndex = index as int;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Text(kalkisName,
                                              style: dropdawnLabelStyle),
                                          GestureDetector(
                                            onTap: () {
                                              showMemberMenu(searchListesi);
                                            },
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,
                                              size: 50,
                                            ),
                                          ),
                                        ],
                                      ),
                                      itemBuilder: (BuildContext context) => [],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.flight_land_sharp,
                                      color: Colors.black,
                                      size: 56,
                                    ),
                                    SizedBox(
                                      width: 2.0,
                                    ),
                                    PopupMenuButton(
                                      onSelected: (index) {
                                        setState(() {
                                          selectedLocationIndex = index as int;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Text(inisName,
                                              style: dropdawnLabelStyle),
                                          GestureDetector(
                                            onTap: () {
                                              showMemberMenu2(searchListesi);
                                            },
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,
                                              size: 50,
                                            ),
                                          ),
                                        ],
                                      ),
                                      itemBuilder: (BuildContext context) => [],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 50.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${_dataTime.day}/${_dataTime.month}/${_dataTime.year}",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black),
                                            textAlign: TextAlign.start,
                                          ),
                                          IconButton(
                                              onPressed: () async {
                                                DateTime? _newDate =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: _dataTime,
                                                  firstDate: DateTime(1800),
                                                  lastDate: DateTime(3000),
                                                );
                                                if (_newDate != null) {
                                                  setState(() {
                                                    _dataTime = _newDate;
                                                  });
                                                }
                                              },
                                              icon: Icon(Icons.date_range)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 60),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          backgroundColor: Colors.black),
                                      onPressed: () {
                                        setState(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FlightTimeLine(
                                                        tarih: _dataTime,
                                                        kalkisNoktasi:
                                                            kalkisCode,
                                                        varisNoktasi: inisCode,
                                                      )));
                                          inisController.text = "";
                                        });
                                      },
                                      child: Text(
                                        "Ara",
                                        style: TextStyle(
                                            fontSize: 14,
                                            letterSpacing: 2.2,
                                            color: Colors.amberAccent),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 330.0, left: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 55,
                            width: 370,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                color: Colors.amberAccent,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 50.0, top: 5),
                                  child: Text(
                                    "Seçili Yolcu Bilgisi",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Column(
                              children: [
                                SizedBox(width: 10 * 2),
                                Container(
                                  height: 10 * 10,
                                  width: 10 * 10,
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 10 * 5,
                                        backgroundImage:
                                        AssetImage('images/avatar.png'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20 * 3),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Ahmet Aydın",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15 * 2,
                                          color: Colors.black),
                                    ),
                                    SizedBox(height: 20 * 0.5),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 60),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(20)),
                                          backgroundColor: Colors.amberAccent),
                                      onPressed: () {},
                                      child: Text(
                                        "Yolcu Seç",
                                        style: TextStyle(
                                            fontSize: 24,
                                            letterSpacing: 2.2,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        });
  }

  void showMemberMenu(List<GetPortsListModel> liste) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(20, 150, 100, 100),
      items: List.generate(
        liste.length,
        (index) => PopupMenuItem(
          onTap: () {
            setState(() {
              kalkisCode = liste[index].code;
              kalkisName = liste[index].name;
            });
          },
          value: 1,
          child: Text(
            liste[index].name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
      elevation: 8.0,
    ).then((value) {
      if (value != null) print(value);
    });
  }

  void showMemberMenu2(List<GetPortsListModel> liste) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(20, 150, 100, 100),
      items: List.generate(
        liste.length,
        (index) => PopupMenuItem(
          onTap: () {
            setState(() {
              inisCode = liste[index].code;
              inisName = liste[index].name;
            });
          },
          value: 1,
          child: Text(
            liste[index].name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
      elevation: 8.0,
    ).then((value) {
      if (value != null) print(value);
    });
  }
}

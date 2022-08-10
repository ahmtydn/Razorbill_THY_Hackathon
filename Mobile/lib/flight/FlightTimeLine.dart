import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../models/UnitModel/DateFlightSearchModel.dart';
import '../models/authmodel/TokenModel.dart';
import 'FlightSearchDetailPage.dart';


const _airplaneSize = 35.0;
const _DotSize = 17.0;
const _cardAnimationDuration = 450;
var tarihh;
var kalkisNoktasii,varisNoktasii;
List<GetFlightModel>?modelFlight;


class FlightTimeLine extends StatefulWidget {
  var tarih;
  var kalkisNoktasi,varisNoktasi;


  FlightTimeLine({this.tarih, this.kalkisNoktasi, this.varisNoktasi});

  @override
  State<FlightTimeLine> createState() => _FlightTimeLineState();
}

class _FlightTimeLineState extends State<FlightTimeLine> {
  bool animated = false;
  bool animateCards = false;

  void initAnimation() async {
    setState(() {
      animated = !animated;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      animateCards = true;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAnimation();
    });
    setState((){
      veriDuzenle();
    });

    super.initState();
  }

  void veriDuzenle(){
    var newtarih=widget.tarih.toString();
    var NewTarih=newtarih.substring(0,4)+newtarih.substring(5,7)+newtarih.substring(8,10);
    tarihh=NewTarih;
    kalkisNoktasii=widget.kalkisNoktasi;
    varisNoktasii=widget.varisNoktasi;
    print(tarihh);
    print(kalkisNoktasii);
    print(varisNoktasii);

  }

  List<GetFlightModel> parseFlightResponse(String response) {
    return getFlightModelFromJson(response);
  }

  Future<List<GetFlightModel>> DateFlightSearchView(TokenModel tokenModel) async {
    final response = await http.post(
        Uri.parse(
            "https://tk1919.herokuapp.com/api/thy/searchFlightByDate"),
        headers: {
          'Authorization': "Bearer ${tokenModel.accessToken}",
          'Content-Type': "application/json"
        },
        body: jsonEncode({
          "date": "${tarihh}",
          "scheduledDepartureAirport": "${kalkisNoktasii}",
          "scheduledArrivalAirport": "${varisNoktasii}"
        }));
    return parseFlightResponse(response.body);
  }

  Future<List<GetFlightModel>> flightSonucGoster() async {

    var sp = await SharedPreferences.getInstance();
    var token = sp.get("token");
    TokenModel tokenModel = TokenModel(accessToken: token.toString());
    
    var model = await DateFlightSearchView(tokenModel);
    await Future.delayed(Duration(seconds: 1));
    modelFlight=model;
    return model;
  }

  @override
  Widget build(BuildContext context) {
    var cardCounter = 0;
    var neredenNereye = "";
    var yolculukSuresi = "";
    var secilenTarih = "";
    var yolculukUcreti = "";
    var saatAraligi = "";

    final size = MediaQuery.of(context).size;
    var count = 7;

    //final centerDot=size.width/2-_DotSize;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text(
          "Arama Sonucu",
          style: TextStyle(color: Colors.amberAccent),
        ),
        backgroundColor: Colors.black,
      ),


      body: FutureBuilder<List<GetFlightModel>>(
          future: flightSonucGoster(),
          builder: (context, snapshot) {
              var searchListesi = snapshot.data;
              return searchListesi==null?Center(child: CircularProgressIndicator()):SingleChildScrollView(
                child: SizedBox(
                  height: count * 100 + 70,
                  width: size.width,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final centerDot = constraints.maxWidth / 2 - 12;
                      var list = List.generate(searchListesi.length, (index) {

                        var search=searchListesi[index];

                        var top = index * 100 + 50;
                        var isLeft = index % 2 == 0;
                        var left = null, right = null;
                        if (isLeft) {
                          left = centerDot;
                        } else {
                          right = centerDot + 7;
                        }
                        return AnimatedPositioned(
                          duration: const Duration(milliseconds: 800),
                          left: left,
                          right: right,
                          top:
                              animated ? top.toDouble() : constraints.maxHeight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FlightSearchDetailPage(
                                            cardId: index,
                                            modelFlight: searchListesi[index],
                                          )));
                            },
                            child: TimeLineDot(
                              selected: true,
                              left: !isLeft,
                              displayCard: animateCards,
                              price: search.price,
                              neredenNereye:search.scheduledDepartureAirport+"+"+search.scheduledArrivalAirport,
                              tarih: search.scheduledLocalDepartureDatetime.substring(0,4)+"-"+search.scheduledLocalDepartureDatetime.substring(4,6)+"-"+search.scheduledLocalDepartureDatetime.substring(6,8),
                              saat: search.scheduledLocalDepartureDatetime.substring(8,10)+":"+search.scheduledLocalDepartureDatetime.substring(10,12)+"-"+search.scheduledLocalArrivalDatetime.substring(8,10)+":"+search.scheduledLocalArrivalDatetime.substring(10,12),
                              delay: const Duration(
                                  milliseconds: _cardAnimationDuration),
                            ),
                          ),
                        );
                      });
                      return Stack(
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 850),
                            left: constraints.maxWidth / 2 - 20,
                            top: animated ? 8 : constraints.maxHeight / 1.1,
                            bottom: 0.0,
                            child: AircraftAndLine(),
                          ),
                          ...list
                        ],
                      );
                    },
                  ),
                ),
              );

          }),
    );
  }
}

class AircraftAndLine extends StatelessWidget {
  const AircraftAndLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _airplaneSize,
      child: Column(
        children: [
          Icon(
            Icons.flight,
            color: Colors.red,
            size: _airplaneSize,
          ),
          Expanded(
              child: Container(
            width: 10,
            color: Colors.grey[300],
          ))
        ],
      ),
    );
  }
}

class TimeLineDot extends StatefulWidget {
  final bool selected;
  final bool displayCard;
  final bool left;
  final Duration delay;
  var neredenNereye;
  var tarih;
  var saat;
  var price;

  TimeLineDot(
      {Key? key,
      this.selected = false,
      this.displayCard = false,
      this.neredenNereye,
      this.tarih,
      this.saat,
        this.price,
      this.delay = const Duration(milliseconds: 10),
      this.left = false})
      : super(key: key);

  @override
  State<TimeLineDot> createState() => _TimeLineDotState();
}

class _TimeLineDotState extends State<TimeLineDot> {
  bool animated = false;
  void _animateWithDelay() async {
    await Future.delayed(Duration(milliseconds: 500));

  }

  @override
  void didUpdateWidget(covariant TimeLineDot oldWidget) {

      _animateWithDelay();

    super.didUpdateWidget(oldWidget);
  }

  Widget _buildCard() => TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1),
      child: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: 140,
            height: 75,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "${widget.neredenNereye}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "${widget.tarih}",
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                    Text(
                      "${widget.price}",
                      style: TextStyle(color: Colors.greenAccent),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "${widget.saat}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      builder: (context, snapshot, child) {
        return Transform.scale(
          scale: snapshot,
          child: child,
          alignment: widget.left ? Alignment.center : Alignment.centerLeft,
        );
      });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          if (!animated && widget.left) ...[
            _buildCard(),
            Container(
              width: 10,
              height: 1,
              color: Colors.black,
            ),
          ],
          Container(
            height: _DotSize,
            width: _DotSize,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: CircleAvatar(
                backgroundColor: widget.selected ? Colors.red : Colors.green,
              ),
            ),
          ),
          if (!animated && !widget.left) ...[
            Container(
              width: 10,
              height: 1,
              color: Colors.black,
            ),
            _buildCard(),
          ],
        ],
      ),
    );
  }
}

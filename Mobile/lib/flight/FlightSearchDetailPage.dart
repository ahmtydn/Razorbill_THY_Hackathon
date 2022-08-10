import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import '../models/UnitModel/DateFlightSearchModel.dart';

class FlightSearchDetailPage extends StatefulWidget {
  var cardId;

  GetFlightModel? modelFlight;
  FlightSearchDetailPage({required this.cardId, this.modelFlight});

  @override
  State<FlightSearchDetailPage> createState() => _FlightSearchDetailPageState();
}

class _FlightSearchDetailPageState extends State<FlightSearchDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            Text("Bilet Detayı", style: TextStyle(color: Colors.amberAccent)),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Positioned(
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    color: Colors.amberAccent,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.grey[50],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            top: 20,
            bottom: 315,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${widget.modelFlight!.scheduledDepartureAirport}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          /* left: 16,
                                          right: 16,
                                          top: 0,
                                          bottom: 0,*/
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: DottedLine(
                                                dashColor: Colors.orange,
                                              )),
                                              Expanded(
                                                  child: Divider(
                                                color: Colors.amberAccent,
                                              )),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                            left: 0,
                                            right: 0,
                                            child: Center(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.amber),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Text(
                                                  "${widget.modelFlight!.flightTime}",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "${widget.modelFlight!.scheduledArrivalAirport}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Türk Hava Yolları"),
                                  Text("İyi Uçuşlar Diler"),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "${widget.modelFlight!.scheduledLocalDepartureDatetime.substring(0, 4) + "-" + widget.modelFlight!.scheduledLocalDepartureDatetime.substring(4, 6) + "-" + widget.modelFlight!.scheduledLocalDepartureDatetime.substring(6, 8)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "${widget.modelFlight!.scheduledLocalArrivalDatetime.substring(0, 4) + "-" + widget.modelFlight!.scheduledLocalArrivalDatetime.substring(4, 6) + "-" + widget.modelFlight!.scheduledLocalArrivalDatetime.substring(6, 8)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0,horizontal: 120),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${widget.modelFlight!.price}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Ücret",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                "Bilet",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 150,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25, left: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16)),
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 35),
                        child: Center(
                          child: Text(
                            "Talep Oluştur",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                                color: Colors.amberAccent
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16)),
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                        child: Center(
                          child: Text(
                            "Favorilere Ekle",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 160,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.amberAccent,
                  ),

                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.amberAccent,
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 400.0, left: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 55,
                  width: 370,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.only(left: 50.0, top: 5),
                        child: Text(
                          "Seçili Yolcu Bilgisi",
                          style: TextStyle(
                              color: Colors.amberAccent,
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
      ),
    );
  }
}

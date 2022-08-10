import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/FlightModel/GetIDFlightModel.dart';
import '../models/PassengerModel/PassengerModel.dart';
import '../models/authmodel/TokenModel.dart';
import 'TicketsDetailPage.dart';

List<TicketsPassenger> liste = [];
List<PassengerModel> listeYolcu = [];
GetIdFlightModel? model;

class TicketsPage extends StatefulWidget {
  const TicketsPage({Key? key}) : super(key: key);

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

var id;
List idFlight=[];
var loading = true;

class _TicketsPageState extends State<TicketsPage> {
  List<PassengerModel> parsePassengerModelResponse(String response) {
    return passengerModelFromJson(response);
  }

  Future<List<PassengerModel>> PasengerRequest(TokenModel tokenModel) async {
    final response = await http.get(
      Uri.parse("https://tk1919.herokuapp.com/api/passengers"),
      headers: {'Authorization': "Bearer ${tokenModel.accessToken}"},
    );
    return parsePassengerModelResponse(response.body);
  }

  Future<List<TicketsPassenger>> getTicketsInfo() async {
    var sp = await SharedPreferences.getInstance();
    var token = sp.get("token");
    TokenModel tokenModel = TokenModel(accessToken: token.toString());
    var model = await PasengerRequest(tokenModel);
    List<TicketsPassenger> list = [];
    List<PassengerModel> listeYolcu2 = [];
    for (var i = 0; i < model.length; i++) {
      var yolcu = model[i];
      listeYolcu2.add(yolcu);
      for (var j = 0; j < model[i].tickets.length; j++) {
        var ticket = model[i].tickets[j];
        list.add(ticket);
        idFlight.add(ticket.airFlightId);
      }
    }
    liste = list;
    listeYolcu = listeYolcu2;
    print("id:${list[0].id}");

    return list;
  }

  GetIdFlightModel parseIDFlightModelResponse(String response) {
    return getIdFlightModelFromJson(response);
  }

  Future<GetIdFlightModel> IDFlightRequest(TokenModel tokenModel,String id) async {
    final response = await http.get(
      Uri.parse("https://tk1919.herokuapp.com/api/air-flights/${id}"),
      headers: {'Authorization': "Bearer ${tokenModel.accessToken}"},
    );
    return parseIDFlightModelResponse(response.body);
  }

  Future<GetIdFlightModel> getFlightInfo(String id) async {
    var sp = await SharedPreferences.getInstance();
    var token = sp.get("token");
    TokenModel tokenModel = TokenModel(accessToken: token.toString());
    var model2 = await IDFlightRequest(tokenModel,id);
    model = model2;
    setState(() {
      loading = false;
    });
    return model2;
  }

  @override
  void initState() {
    getTicketsInfo();
    print("flight length:${idFlight.length}");
    for(var i=0;i<idFlight.length;i++){
      getFlightInfo(idFlight[i].toString());
      print("flight id:${idFlight[i]}");

    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var count = liste.length;
    var padding = 0.0;
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.amberAccent,
        appBar: AppBar(
          title: Text(
            "Biletlerim",
            style: TextStyle(color: Colors.amberAccent),
          ),
          backgroundColor: Colors.black,
        ),
        body: loading == true
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    LayoutBuilder(builder: (context, constraints) {
                      var list = List.generate(count, (index) {
                        if (index == 0) {
                          padding = padding + 10;
                        } else {
                          padding = padding + 240;
                        }
                        return GestureDetector(
                            onTap: () {
                              var ticketid=liste[index].id;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TicketsDetailPage(ticketid)));
                            },
                            child: BuildFavCard(
                              topPadding: padding,
                              kalkis: model!.from,
                              inis: model!.to,
                              isim: listeYolcu[index].firstName,
                              soyisim: listeYolcu[index].lastName,
                              kalkisTarih: "${model!.departure.year}"+"-"+"${model!.departure.month}"+"-"+"${model!.departure.day}",
                              inisTarih: "${model!.arrival.year}"+"-"+"${model!.arrival.month}"+"-"+"${model!.arrival.day}",
                              ucusSuresi: model!.duration,
                            ));
                      });
                      return Stack(
                        children: [...list],
                      );
                    }),
                  ],
                ),
              ));
  }
}

class BuildFavCard extends StatefulWidget {
  var topPadding;
  var kalkis, inis, isim, soyisim, kalkisTarih, inisTarih, ucusSuresi;

  BuildFavCard(
      {this.topPadding,
      this.kalkis,
      this.inis,
      this.isim,
      this.soyisim,
      this.kalkisTarih,
      this.inisTarih,
      this.ucusSuresi});

  @override
  State<BuildFavCard> createState() => _BuildFavCardState();
}

class _BuildFavCardState extends State<BuildFavCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.topPadding),
      child: Card(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${widget.isim}",
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Stack(
                                children: [
                                  Positioned(
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
                                            border:
                                                Border.all(color: Colors.amber),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Text(
                                            "${widget.ucusSuresi}",
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
                            "${widget.soyisim}",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${widget.kalkis}"),
                            Text("${widget.inis}"),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "${widget.kalkisTarih}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "${widget.inisTarih}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

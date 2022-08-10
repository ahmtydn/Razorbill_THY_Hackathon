import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/TicketsModel/IDTicketDetailModel.dart';
import '../models/authmodel/TokenModel.dart';

var loading=true;
GetIdTicketDetailModel? modelTicketDetail;
class TicketsDetailPage extends StatefulWidget {
 var ticketID;



 TicketsDetailPage(this.ticketID);

  @override
  State<TicketsDetailPage> createState() => _TicketsDetailPageState();
}

class _TicketsDetailPageState extends State<TicketsDetailPage> {


  GetIdTicketDetailModel parseIDTicketDetailModelResponse(String response) {
    return getIdTicketDetailModelFromJson(response);
  }

  Future<GetIdTicketDetailModel> IDTicketDetailRequest(TokenModel tokenModel,String id) async {
    final response = await http.get(
      Uri.parse("https://tk1919.herokuapp.com/api/tickets/${widget.ticketID}"),
      headers: {'Authorization': "Bearer ${tokenModel.accessToken}"},
    );
    return parseIDTicketDetailModelResponse(response.body);
  }

  Future<GetIdTicketDetailModel> getTicketDetailInfo(String id) async {
    var sp = await SharedPreferences.getInstance();
    var token = sp.get("token");
    TokenModel tokenModel = TokenModel(accessToken: token.toString());
    var model2 = await IDTicketDetailRequest(tokenModel,id);
    modelTicketDetail=model2;
    setState(() {
      loading = false;
    });
    return model2;
  }
  var koltukTurListesi=["Economy","Business","First"];
 var koltukTur="";

 @override
  void initState() {
    print("detay iddi: ${widget.ticketID}");
    super.initState();
    new Future.delayed(Duration(milliseconds: 500),() {
      getTicketDetailInfo(widget.ticketID);
    });
  }
  @override
  Widget build(BuildContext context) {

    if(modelTicketDetail!.getIdTicketDetailModelClass==0){
      koltukTur=koltukTurListesi[0];
    }else if(modelTicketDetail!.getIdTicketDetailModelClass==1){
      koltukTur=koltukTurListesi[1];
    }
    else{
      koltukTur=koltukTurListesi[2];
    }
    return loading==true?Center(child: CircularProgressIndicator()): Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Bilet Detay",style: TextStyle(color: Colors.amberAccent),),
        backgroundColor: Colors.black,
      ),
      body:loading==true?Center(child: CircularProgressIndicator()):Stack(
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
            bottom: 0,
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
                        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${modelTicketDetail!.airFlight.from}",
                                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.blue),
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
                                              Expanded(child: Divider(
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
                                                  border: Border.all(color: Colors.amber),
                                                  borderRadius:
                                                  BorderRadius.circular(16),
                                                ),
                                                child: Text(
                                                  "${modelTicketDetail!.airFlight.duration}",
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
                                  "${modelTicketDetail!.airFlight.to}",
                                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    Text("${modelTicketDetail!.airFlight.departure.year}"+"-"+"${modelTicketDetail!.airFlight.departure.month}"+"-"+"${modelTicketDetail!.airFlight.departure.day}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                                  ],
                                ), Column(
                                  children: [
                                    Text("${modelTicketDetail!.airFlight.arrival.year}"+"-"+"${modelTicketDetail!.airFlight.arrival.month}"+"-"+"${modelTicketDetail!.airFlight.arrival.day}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 120,),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${modelTicketDetail!.passenger.firstName}"+"${modelTicketDetail!.passenger.lastName}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                      SizedBox(height: 8,),
                                      Text("Yolcu"),
                                    ],
                                  ), Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("${modelTicketDetail!.passenger.identityNumber}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                      SizedBox(height: 8,),
                                      Text("ID Numarası",),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(koltukTur,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),),
                                      SizedBox(height: 8,),
                                      Text("Koltuk Türü"),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("${modelTicketDetail!.seatNumber}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                      SizedBox(height: 8,),
                                      Text("Koltuk Numarası",),
                                    ],
                                  ),
                                ],
                              ),
                            ),Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${modelTicketDetail!.pnr}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),),
                                      SizedBox(height: 8,),
                                      Text("PNR Numarası"),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("${modelTicketDetail!.baggage}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                      SizedBox(height: 8,),
                                      Text("Bagaj",),
                                    ],
                                  ),
                                ],
                              ),
                            ),Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${modelTicketDetail!.meal}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),),
                                      SizedBox(height: 8,),
                                      Text("Servis"),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("${modelTicketDetail!.airFlight.price}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                      SizedBox(height: 8,),
                                      Text("Ücret",),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 1,),
                            Divider(
                              color: Colors.black,
                            ),
                            SizedBox(height: 15,),
                            Text("Detaylı Bilet",style: TextStyle(fontWeight:FontWeight.bold ),)
                          ],
                        ),
                      ),
                    ),
                  ),
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
                  Expanded(
                    child: DottedLine(),
                  ),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.amberAccent,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

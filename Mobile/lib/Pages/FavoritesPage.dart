import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text("Favoriler",style: TextStyle(color: Colors.amberAccent),),
        backgroundColor: Colors.black,
      ),
      body:Stack(
        children: [
          ListView(
            children: [
              buildFavCard(),

            ],
          )

        ],
      ) ,
    );
  }
  Widget buildFavCard(){
    return  Card(
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
                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "SAW",
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
                                          "6s25d",
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
                          "ORY",
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sabiha Gökçen \nUluslararası Havalimanı"),
                          Text("Paris-Orly Havalimanı"),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("09:26",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            SizedBox(height: 8,),
                            Text("05 June 2022",),
                          ],
                        ),
                        IconButton(
                          onPressed: (){

                          },
                          icon:Icon(Icons.favorite),
                          iconSize: 30,
                          color: Colors.red,
                        ),
                        Column(
                          children: [
                            Text("13:43",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            SizedBox(height: 8,),
                            Text("05 June 2022",),
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
    );
  }
}




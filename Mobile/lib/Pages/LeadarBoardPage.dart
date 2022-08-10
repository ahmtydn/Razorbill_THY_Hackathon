import 'package:flutter/material.dart';

import '../models/UnitModel/leaderbordModel.dart';
class LeadarBoardPage extends StatefulWidget {
  const LeadarBoardPage({Key? key}) : super(key: key);

  @override
  State<LeadarBoardPage> createState() => _LeadarBoardPageState();
}

class _LeadarBoardPageState extends State<LeadarBoardPage> {
  List<ledarBoard> liste = [
    ledarBoard("Gürkan", "İlgaz", 4, 1754),
    ledarBoard("Ceyhun", "Kiraz", 5, 1654),
    ledarBoard("Uğur", "Öztürk", 6, 1534),
    ledarBoard("Aslı", "Türk", 7, 1278),
    ledarBoard("Merve", "Öztürk", 8, 754),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text(
          "Liderik Sıralaması",
          style: TextStyle(color: Colors.amberAccent),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
               Stack(
                 children: [
                   SizedBox(height: 15,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       BuildLeaderThree(1),
                     ],
                   ),
                   Positioned(
                     top: 100,
                     left: .0,
                     right: .0,
                     child: Row(
                       children: [
                         Spacer(),
                         BuildLeaderThree(2),
                         Spacer(
                           flex: 2,
                         ),
                         BuildLeaderThree(3),
                         Spacer(),
                       ],
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 210.0),
                     child: Divider(
                       color: Colors.black,
                     ),
                   ),
                 ],
               ),
                Padding(
                  padding: const EdgeInsets.only(top: 230.0),
                  child: ListView.builder(
                      itemCount: liste.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Card(
                            color: Colors.black,
                            child: ListTile(
                                leading: Text(
                                  "${liste[index].sira}",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.amberAccent),
                                ),
                                trailing: Text("${liste[index].puan}",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.amberAccent)),
                                title: Text(
                                    "${liste[index].isim + " " + liste[index].soyisim}",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.amberAccent))),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuildLeaderThree extends StatefulWidget {
  var siraNo;

  BuildLeaderThree(this.siraNo);

  @override
  State<BuildLeaderThree> createState() => _BuildLeaderThreeState();
}

class _BuildLeaderThreeState extends State<BuildLeaderThree> {
  @override
  Widget build(BuildContext context) {
    var IconList = [Icons.looks_one, Icons.looks_two, Icons.looks_3];
    var imageList=[AssetImage('images/avatar.png'),AssetImage('images/reco.jpg'),AssetImage('images/baro.jpeg')];
    var icon;
    var image;
    if (widget.siraNo == 1) {
      icon = IconList[0];
      image=imageList[0];
    } else if (widget.siraNo == 2) {
      icon = IconList[1];
      image=imageList[1];
    } else {
      icon = IconList[2];
      image=imageList[2];
    }
    return Container(
      height: 100,
      width: 100,
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 50,
            child: CircleAvatar(
              radius: 45,
              backgroundImage:image ,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 30.5,
              width: 30.5,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'AssistantPage.dart';
import 'GamificationPage.dart';
import 'HomePageScreen.dart';
import 'ProfilePage.dart';
import 'RequestPage.dart';



class MainPage extends StatefulWidget {
  int index;

  MainPage(this.index);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{

  final screens=[
    HomePageScreen(),
    GamificationPage(),
    RequestPage(),
    AssistantPage(),
    ProfilePage(),
  ];

  final screensName=[
    "Anasayfa",
    "Rezorbill Game",
    "Taleplerim",
    "Yolculuk Asistanı",
    "Profil",
  ];
  @override
  Widget build(BuildContext context) {

    final items=[
      Icon(Icons.home,size: 30,color: Colors.amberAccent,),
      Icon(Icons.videogame_asset,size: 30,color: Colors.amberAccent),
      Icon(Icons.add,size: 30,color: Colors.amberAccent),
      Icon(Icons.map_sharp,size: 30,color: Colors.amberAccent),
      Icon(Icons.person,size: 30,color: Colors.amberAccent),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("${screensName[widget.index]}",style: TextStyle(color: Colors.amberAccent),),
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: widget.index,
        buttonBackgroundColor: Colors.black,
        onTap: (index)=>setState(()=>this.widget.index=index),
        height: 60,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        color: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      body: screens[widget.index] ,
    );
  }

}

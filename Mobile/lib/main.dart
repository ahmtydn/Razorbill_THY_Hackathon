import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/LoginPage.dart';
import 'Pages/MainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  Future<bool> checkSign() async {
    var sp =await SharedPreferences.getInstance();
    String token=sp.getString("token") ?? "";
    if(token==""){
      return false;
    }
    else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: checkSign(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            bool? gecisIzni=snapshot.data;
            return gecisIzni! ? MainPage(0):LoginPage();
          }
          else{
            return Container();
          }
        },
      ),
    );
  }
}

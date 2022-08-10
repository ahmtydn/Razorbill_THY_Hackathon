import 'package:flutter/material.dart';

class RazorbillDetail extends StatefulWidget {
  const RazorbillDetail({Key? key}) : super(key: key);

  @override
  State<RazorbillDetail> createState() => _RazorbillDetailState();
}

class _RazorbillDetailState extends State<RazorbillDetail> {

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Oyun hakkında",style: TextStyle(color: Colors.amberAccent),),
        backgroundColor: Colors.black,
      ),

      body: SizedBox(
          height: size.height,
          width: size.width,
          child: Image.asset("images/decription.jpg")),
    );
  }
}

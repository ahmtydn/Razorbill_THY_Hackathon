import 'dart:math';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  var IconList = [
    Icons.looks_one,
    Icons.looks_two,
    Icons.looks_3,
    Icons.looks_4,
    Icons.looks_5,
    Icons.looks_6
  ];

  @override
  Widget build(BuildContext context) {
    var count = 6;
    var padding = 0.0;
    return Scaffold(
        backgroundColor: Colors.amberAccent,
        body: count == 0
            ? Padding(
              padding: const EdgeInsets.only(bottom: 55.0),
              child: Center(
                  child: Text(
                    "Daha Önce Girilen \nHerhangi Bir Talep \nBulunamadı!",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 26,
                        color: Colors.black),
                  ),
                ),
            )
            : SingleChildScrollView(
              child: Column(
                  children: [
                    LayoutBuilder(builder: (context, constraints) {
                      var list = List.generate(count, (index) {
                        Random random = new Random();
                        int randomNumber = random.nextInt(3) + 0;
                        if (index == 0) {
                          padding = padding + 10;
                        } else {
                          padding = padding + 70;
                        }
                        return RequestListItem(
                          icon: IconList[index],
                          text: "Talep",
                          padding: padding,
                          durum: randomNumber,
                        );
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

class RequestListItem extends StatefulWidget {
  final IconData icon;
  final text;
  final padding;
  final bool hasNavigation;
  final durum;

  RequestListItem(
      {Key? key,
      required this.icon,
      required this.text,
      this.padding,
      this.durum,
      this.hasNavigation = true})
      : super(key: key);

  @override
  State<RequestListItem> createState() => _RequestListItemState();
}

class _RequestListItemState extends State<RequestListItem> {
  var IconListStatus = [
    Icons.check,
    LineAwesomeIcons.times,
    LineAwesomeIcons.clock
  ];
  var durumIcon;
  var colorDurum;
  @override
  Widget build(BuildContext context) {
    if (this.widget.durum == 1) {
      durumIcon = IconListStatus[0];
      colorDurum = Colors.green;
    } else if (this.widget.durum == 2) {
      durumIcon = IconListStatus[1];
      colorDurum = Colors.red;
    } else {
      durumIcon = IconListStatus[2];
      colorDurum = Colors.blue;
    }
    print(this.widget.padding);
    return Container(
      height: 10 * 5.5,
      margin: EdgeInsets.only(top: this.widget.padding, left: 10, right: 10),
      padding: EdgeInsets.symmetric(horizontal: 10 * 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10 * 3),
        color: Colors.black,
      ),
      child: Row(
        children: [
          Icon(
            this.widget.icon,
            size: 10 * 2.5,
            color: Colors.amberAccent,
          ),
          SizedBox(width: 10 * 1.5),
          Text(this.widget.text,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10 * 2,
                  color: Colors.amberAccent)),
          SizedBox(width: 2),
          if (this.widget.hasNavigation)
            Icon(
              LineAwesomeIcons.angle_right,
              size: 10 * 2.5,
              color: Colors.amberAccent,
            ),
          SizedBox(
            width: 105,
          ),
          Text(
            "Durum:",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 10 * 2,
                color: Colors.amberAccent),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            durumIcon,
            size: 10 * 2.5,
            color: colorDurum,
          ),
        ],
      ),
    );
  }
}

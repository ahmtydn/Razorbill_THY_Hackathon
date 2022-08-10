import 'package:Razorbill/gamification/quizScreenPage.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';


import '../Pages/6SigmaQuizPage.dart';
import '../Pages/LeadarBoardPage.dart';
import '../Pages/RazorbillGameDetail.dart';


class GamificationHome extends StatefulWidget {
  const GamificationHome({Key? key}) : super(key: key);

  @override
  State<GamificationHome> createState() => _GamificationHomeState();
}

class _GamificationHomeState extends State<GamificationHome> {
  @override
  Widget build(BuildContext context) {

    var profileInfo = Expanded(
      child: Row(
        children: [
          SizedBox(width: 10 * 2),
          Container(
            height: 10 * 10,
            width: 10 * 10,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 10 * 5,
                  backgroundImage: AssetImage('images/avatar.png'),
                ),
              ],
            ),
          ),
          SizedBox(width: 10 * 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ahmet Aydın",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15 * 2,
                    color: Colors.black),
              ),
              SizedBox(height: 10 * 0.5),
              Text(
                "Sıralama: 1",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),

        ],
      ),
    );
    return Scaffold(

      backgroundColor: Colors.amberAccent,
        body: Column(
          children: [
            SizedBox(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileInfo,
              ],
            ),
            SizedBox(
                height: 225,
                width: 350,
                child: Image.asset("images/siyahbackground.jpg")),
            Expanded(
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizScreenPage()));
                      },
                      child: ProfileListItem(
                        icon: LineAwesomeIcons.question,
                        text: 'Soru Çöz',
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SigmaQuizScreenPage()));
                      },
                      child: ProfileListItem(
                        icon: LineAwesomeIcons.question_circle,
                        text: '6Sigma Soru Çöz',
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LeadarBoardPage()));
                      },
                      child: ProfileListItem(
                        icon: LineAwesomeIcons.bar_chart,
                        text: 'Sıralamayı Gör',
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> RazorbillDetail()));
                      },
                      child: ProfileListItem(
                        icon: LineAwesomeIcons.bar_chart,
                        text: 'Oyun Hakkında',
                      ),
                    ),
                  ],
                )),
          ],
        ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final text;
  final bool hasNavigation;

  ProfileListItem(
      {Key? key,
        required this.icon,
        required this.text,
        this.hasNavigation = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10 * 5.5,
      margin: EdgeInsets.symmetric(
        horizontal: 10 * 2,
      ).copyWith(
        bottom: 10 * 2,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10 * 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10 * 3),
        color: Colors.black,
      ),
      child: Row(
        children: [
          Icon(
            this.icon,
            size: 10 * 2.5,
            color: Colors.amberAccent,
          ),
          SizedBox(width: 10 * 2.5),
          Text(this.text,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10 * 2,
                  color: Colors.amberAccent)),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              LineAwesomeIcons.angle_right,
              size: 10 * 2.5,
              color: Colors.amberAccent,
            ),
        ],
      ),
    );
  }
}


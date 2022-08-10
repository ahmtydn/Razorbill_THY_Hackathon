import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/UserModel/UserModel.dart';
import '../models/authmodel/TokenModel.dart';
import 'EditProfilePage.dart';
import 'FavoritesPage.dart';
import 'LoginPage.dart';
import 'TicketsPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  UserModel parseUserModelResponse(String response) {
    return userModelFromJson(response);
  }


  Future<UserModel> UserRequest(TokenModel tokenModel) async {
    final response = await http.get(
        Uri.parse( "https://tk1919.herokuapp.com/api/auth"),
        headers: {
          'Authorization':"Bearer ${tokenModel.accessToken}"
        },);
    return parseUserModelResponse(response.body);

  }

  Future<UserModel> getUserInfo() async {
    var sp=await SharedPreferences.getInstance();
    var token=sp.get("token");
    TokenModel tokenModel=TokenModel(accessToken: token.toString());
    var model = await UserRequest(tokenModel);
    return model;
  }

@override
  void initState() {
  getUserInfo().then((value) => {
    setState((){
      isimSoyisim=value.firstName+" "+value.lastName;
      email=value.email;
      loading=false;
    }),
  });
    super.initState();
  }
  var isimSoyisim="",email="";
  var loading=true;
  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context,
        designSize: const Size(414, 896), minTextAdapt: true);

    var profileInfo = Expanded(
      child: Column(
        children: [
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: kSpacingUnit.w * 5,
                  backgroundImage: AssetImage('images/avatar.png'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w * 3.5,
                    width: kSpacingUnit.w * 3.5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LineAwesomeIcons.pen,
                      color: Colors.white,
                      size: ScreenUtil().setSp(kSpacingUnit.w * 2.5),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            "${isimSoyisim}",
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            "${email}",
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Container(
            decoration: BoxDecoration(),
            child: Center(
              child: Icon(
                LineAwesomeIcons.github,
                size: kSpacingUnit.w * 4,
              ),
            ),
          ),
        ],
      ),
    );

    return loading==true?Center(child: CircularProgressIndicator()): Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Column(
        children: [
          SizedBox(height: kSpacingUnit.w * 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kSpacingUnit.w * 3),
              profileInfo,
            ],
          ),
          SizedBox(height: kSpacingUnit.w * 1),
          Expanded(
              child: ListView(
            children: [
              GestureDetector(
                onTap:(){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditProfilePage()));
                 },
                child: ProfileListItem(
                  icon: LineAwesomeIcons.user_edit,
                  text: 'Bilgilerimi Düzenle',
                ),
              ),
              ProfileListItem(
                icon: LineAwesomeIcons.wallet,
                text: 'THY Cüzdan',
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoritesPage()));
                },
                child: ProfileListItem(
                  icon: LineAwesomeIcons.heart,
                  text: 'Favoriler',
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TicketsPage()));
                },
                child: ProfileListItem(
                  icon: Icons.airplane_ticket,
                  text: 'Biletlerim',
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                  var sp=await SharedPreferences.getInstance();
                  sp.remove("token");
                },
                child: ProfileListItem(
                  icon: LineAwesomeIcons.door_open,
                  text: 'Çıkış Yap',
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
      height: kSpacingUnit.w * 5.5,
      margin: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 2,
      ).copyWith(
        bottom: kSpacingUnit.w * 2,
      ),
      padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
        color: Colors.black,
      ),
      child: Row(
        children: [
          Icon(
            this.icon,
            size: kSpacingUnit.w * 2.5,
            color: Colors.amberAccent,
          ),
          SizedBox(width: kSpacingUnit.w * 2.5),
          Text(this.text,
              style: kTitleTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: kSpacingUnit.w * 2,
                  color: Colors.amberAccent)),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              LineAwesomeIcons.angle_right,
              size: kSpacingUnit.w * 2.5,
              color: Colors.amberAccent,
            ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/UserModel/UserModel.dart';
import '../models/UserModel/UserUpdateErrorModel.dart';
import '../models/UserModel/UserUpdateModel.dart';
import '../models/authmodel/TokenModel.dart';
import 'MainPage.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;

  UserModel parseUserModelResponse(String response) {
    return userModelFromJson(response);
  }

  Future<UserModel> UserRequest(TokenModel tokenModel) async {
    final response = await http.get(
      Uri.parse("https://tk1919.herokuapp.com/api/auth"),
      headers: {'Authorization': "Bearer ${tokenModel.accessToken}"},
    );
    return parseUserModelResponse(response.body);
  }

  Future<UserModel> getUserInfo() async {
    var sp = await SharedPreferences.getInstance();
    var token = sp.get("token");
    TokenModel tokenModel = TokenModel(accessToken: token.toString());
    var model = await UserRequest(tokenModel);
    return model;
  }

  @override
  void initState() {
    getUserInfo().then((value) => {
          setState(() {
            isim = value.firstName;
            soyisim = value.lastName;
            email = value.email;
            id = value.id;
            loading = false;

            isimController.text = isim;
            soyisimController.text = soyisim;
            mailController.text = email;
            sifreController.text = "";
          }),
        });
    super.initState();
  }

  var isim = "", soyisim = "", email = "";
  var id;
  var loading = true;
  var isimController = TextEditingController();
  var soyisimController = TextEditingController();
  var mailController = TextEditingController();
  var sifreController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  UserUpdateErrorModel parseUpdateErrorResponse(String response) {
    return userUpdateErrorModelFromJson(response);
  }

  UserUpdateModel parseUserUpdateModelResponse(String response) {
    return userUpdateModelFromJson(response);
  }

  Future<UserUpdateModel?> UserUpdateRequest(
      TokenModel tokenModel) async {
    String? password= sifreController.text;
    if(password.isEmpty){
      password=null;
    }
    final response = await http.put(
      Uri.parse("https://tk1919.herokuapp.com/api/users/${id}"),
      headers: {
        'Authorization': "Bearer ${tokenModel.accessToken}",
        'Content-Type':"application/json"
      },
      body: jsonEncode({
        "firstName":"${isimController.text}",
        "lastName": "${soyisimController.text}",
        "email": "${mailController.text}",
        "password":password
      }),
    );
    if (response.statusCode == 200) {
      parseUserUpdateModelResponse(response.body);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainPage(4)));
      return null;
    }
    final error = parseUpdateErrorResponse(response.body);
    scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(error.message),
    ));
    return null;
  }

  Future<void> UserUpdate() async {
    var sp = await SharedPreferences.getInstance();
    var token = sp.get("token");
    TokenModel tokenModel = TokenModel(accessToken: token.toString());
    await UserUpdateRequest(
      tokenModel
    );
  }

  @override
  Widget build(BuildContext context) {
    var profileInfo = Expanded(
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 10 * 5,
                  backgroundImage: AssetImage('images/avatar.png'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 10 * 3.5,
                    width: 10 * 3.5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LineAwesomeIcons.pen,
                      color: Colors.white,
                      size: ScreenUtil().setSp(10 * 2.5),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

    return loading == true
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            key: scaffoldKey,
            extendBody: true,
            backgroundColor: Colors.amberAccent,
            appBar: AppBar(
              title: Text(
                "Profil Düzenle",
                style: TextStyle(color: Colors.amberAccent),
              ),
              backgroundColor: Colors.black,
            ),
            body: Container(
              padding: EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [profileInfo],
                        ),
                      ],
                    ),
                    SizedBox(height: 55),
                    buildTextField("İsim", false, isimController),
                    buildTextField("Soyisim", false, soyisimController),
                    buildTextField("E-mail", false, mailController),
                    buildTextField("Yeni Şifre", true, sifreController),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 60),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Colors.black),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage(4)));
                          },
                          child: Text(
                            "İptal",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.amberAccent),
                          ),
                        ),
                        Spacer(),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 60),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Colors.blue),
                          onPressed: () {
                            setState((){
                              UserUpdate();
                            });

                          },
                          child: Text(
                            "Kaydet",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget buildTextField(String labelText, bool isPasswordField,
      TextEditingController controller) {
    var colorEye = [Colors.green, Colors.red];
    var color = Colors.red;
    var colorControl = true;
    return Padding(
      padding: EdgeInsets.only(bottom: 25.0),
      child: TextField(
        controller: controller,
        obscureText: isPasswordField ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                      if (colorControl) {
                        setState(() {
                          color = colorEye[0];
                          colorControl = false;
                        });
                      } else {
                        setState(() {
                          color = colorEye[1];
                          colorControl = true;
                        });
                      }
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: color,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

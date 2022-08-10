import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/authmodel/LoginErrorModel.dart';
import '../models/authmodel/LoginModel.dart';
import '../models/authmodel/TokenModel.dart';
import 'MainPage.dart';

Color firstColor = Color(0xFFFFDE59);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TokenModel parseTokenResponse(String response) {
    return tokenModelFromJson(response);
  }

  LoginErrorModel parseErrorResponse(String response) {
    return loginErrorModelFromJson(response);
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var kullaniciAdiController = TextEditingController();
  var sifreController = TextEditingController();

  Future<TokenModel?> LoginRequest(LoginModel loginModel) async {
    final response = await http.post(
        Uri.parse("https://tk1919.herokuapp.com/api/auth/login"),
        headers: {'Content-Type': "application/json"},
        body: jsonEncode(loginModel));
    if (response.statusCode == 201) {
      return parseTokenResponse(response.body);
    }
    final error = parseErrorResponse(response.body);
    scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(error.message),
    ));
    return null;
  }

  Future<void> Login(String email, String password) async {
    var model =
        await LoginRequest(LoginModel(email: email, password: password));
    if (model != null) {
      var sp = await SharedPreferences.getInstance();
      sp.setString("token", model.accessToken);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage(0)));
    }
  }


  @override
  Widget build(BuildContext context) {
    kullaniciAdiController.text = "ahmet@tk1919.com";
    sifreController.text = "Ahmet1234.";
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: firstColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset("images/rezo.png")),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    //Hoşgeldin
                    Text(
                      "Tekrar Merhaba",
                      style: GoogleFonts.bebasNeue(fontSize: 52),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Hoşgeldiniz,sizi özledik!",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 50),

                    //email textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow[200],
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: kullaniciAdiController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "E-mail",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    //password textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow[200],
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: sifreController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Şifre",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    //sing in button
                    GestureDetector(
                      onTap: () {
                        Login(
                            kullaniciAdiController.text, sifreController.text);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              "Giriş",
                              style: TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    //not a member? register now

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Üye değil misin?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "  Şimdi Kayıt Ol",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

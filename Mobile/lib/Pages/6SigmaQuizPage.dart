import 'package:flutter/material.dart';

class SigmaQuizScreenPage extends StatefulWidget {
  const SigmaQuizScreenPage({Key? key}) : super(key: key);

  @override
  State<SigmaQuizScreenPage> createState() => _SigmaQuizScreenPageState();
}

Color colorControllerA = Colors.black;
Color colorControllerB = Colors.black;
Color colorControllerC = Colors.black;
Color colorControllerD = Colors.black;
bool optionColorController =true;

void cleanOptionColors() {
  colorControllerA = Colors.white;
  colorControllerB = Colors.white;
  colorControllerC = Colors.white;
  colorControllerD = Colors.white;
}

class _SigmaQuizScreenPageState extends State<SigmaQuizScreenPage> {






  @override
  Widget build(BuildContext context) {
    double dynamicHeight(double value) =>
        MediaQuery.of(context).size.height * value;
    double dynamicWidth(double value) =>
        MediaQuery.of(context).size.width * value;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title:
        Text("Rezorbill Sigma Game", style: TextStyle(color: Colors.amberAccent)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                width: dynamicWidth(1),
                height: dynamicHeight(0.3),
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                padding: EdgeInsets.symmetric(horizontal: 10 * 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * 3),
                  color: Colors.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        "Depremin büyüklüğünü ve süresini ölçen alete ne ad verilir?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 10 * 1.5,
                          color: Colors.amberAccent,
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: dynamicHeight(0.06),
            ),
            OptionA(),
            OptionB(),
            OptionC(),
            OptionD(),
            const SizedBox(height: 30),
            ContinueButton(context),
          ],
        ),
      ),
    );
  }
}

Card ContinueButton(BuildContext context) {
  return Card(
    color: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35.0),
    ),
    child: InkWell(
      onTap: () {},
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
                  "DEVAM",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10 * 1.5,
                    color: Colors.amberAccent,
                  ),
                ))
          ],
        ),
      ),
    ),
    elevation: 5,
  );
}

Expanded OptionD() {
  return Expanded(
    child: Card(
      color: colorControllerD,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      elevation: 5,
      child: InkWell(
        onTap: () {
          optionColorController==true ? funcD : funcD;
        },
        child: SizedBox(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              children: [
                Text("D-)  Sismograf",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10 * 1.5,
                      color: Colors.amberAccent,
                    ))
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Expanded OptionC() {
  return Expanded(
    child: Card(
      color: colorControllerC,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              children: [
                Text("C-)  Tomograf",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10 * 1.5,
                      color: Colors.amberAccent,
                    ))
              ],
            ),
          ),
        ),
      ),
      elevation: 5,
    ),
  );
}
void  funcD(){
  cleanOptionColors();
  colorControllerD.blue;
  print("d tıklandı");
}

Expanded OptionB() {
  return Expanded(
    child: Card(
      color:colorControllerB,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              children: [
                Text("B-) Usturlap",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10 * 1.5,
                      color: Colors.amberAccent,
                    ))
              ],
            ),
          ),
        ),
      ),
      elevation: 5,
    ),
  );
}

Expanded OptionA() {
  return Expanded(
    child: Card(
      color: colorControllerA,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              children: [
                Text("A-) Teleskop",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10 * 1.5,
                      color: Colors.amberAccent,
                    ))
              ],
            ),
          ),
        ),
      ),
      elevation: 5,
    ),
  );
}

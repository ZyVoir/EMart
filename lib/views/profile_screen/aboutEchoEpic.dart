import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class aboutEchoEpic extends StatefulWidget {
  const aboutEchoEpic({super.key});

  @override
  State<aboutEchoEpic> createState() => _aboutEchoEpicState();
}

class _aboutEchoEpicState extends State<aboutEchoEpic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 111, 22),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: -20,
              right: -16,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(-25 / 360),
                child: Opacity(
                  opacity: 0.18,
                  child: Image.asset(
                    "assets/icons/app_logo.png",
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 265, 0, 0),
              child: Container(
                width: double.infinity,
                height: 580,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 35, 0, 0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.keyboard_backspace_rounded,
                            size: 30,
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(
                      width: 115,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                      child: Text(
                        'ABOUT',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  "assets/icons/app_logo.png",
                  width: 250,
                  height: 250,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  child: const Text(
                    'EchoEpic is an app for buying an managing product, starting from adding product, reading product, updating product and deleting product',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Container(
                    width: 350,
                    child: const Text(
                      'This EchoEpic App was made to met the requirement of Mobile Cloud Computing Course',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Container(
                    width: 350,
                    child: const Text(
                      'MADE BY:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 30, 0, 0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/Chris.png'),
                        radius: 45,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/Nick.png'),
                        radius: 45,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/Will.png'),
                        radius: 45,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 30, 41, 0),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.circle,
                            size: 7,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Christian Jonathan Gunawan',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 15.5),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            '2602099794',
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 15.5),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 10, 0, 0),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.circle,
                            size: 7,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Nickson Tan Clarino',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 15.5),
                          ),
                          SizedBox(
                            width: 87,
                          ),
                          Text(
                            '2602091955',
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 15.5),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 10, 39, 0),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.circle,
                            size: 7,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'William',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 15.5),
                          ),
                          SizedBox(
                            width: 181,
                          ),
                          Text(
                            '2602054120',
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 15.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/views/profile_screen/History.dart';
import 'package:emart_app/views/profile_screen/aboutEchoEpic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widget/button1.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  final authUser = FirebaseAuth.instance.currentUser;
  final user = FirebaseFirestore.instance.collection('users');

  late Future<String> futureDName;

  Future<String> getName() async {
    late final fields;
    await user.doc(authUser?.uid).get().then((DocumentSnapshot doc) {
      fields = doc.data() as Map<String, dynamic>;
    });

    return fields['name'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureDName = getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFfE72A00),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 1100,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                      bottomRight: Radius.circular(45),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 350,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          35.heightBox,
                          CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.transparent,
                            child: authUser?.photoURL == null
                                ? Icon(
                                    Icons.person,
                                    size: 200,
                                    color: Colors.black,
                                  )
                                : Image.network(
                                    authUser?.photoURL ?? "",
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          30.heightBox,
                          if (authUser?.displayName != null)
                            Text(
                              authUser?.displayName ?? "",
                            ),
                          if (authUser?.displayName == null)
                            FutureBuilder(
                              future: futureDName,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                if (snapshot.hasData) {
                                  final data = snapshot.data as String;
                                  print(data);
                                  return Text("${data}");
                                }
                                return Placeholder();
                              },
                            ),
                          Text(
                            authUser?.email ?? "",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 390, 20, 0),
                  child: Column(
                    children: [
                      button1(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => aboutEchoEpic(),
                              ));
                          print("i was tapped");
                        },
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/icons/information-chat.png',
                              width: 40,
                              height: 40,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "About EchoEpic",
                              style: TextStyle(color: Colors.black, fontSize: 24),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      button1(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => History(),
                            ),
                          );
                          print("i was tapped");
                        },
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/icons/analysis-left.png',
                              width: 40,
                              height: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "My Transaction",
                              style: TextStyle(color: Colors.black, fontSize: 24),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      button1(
                        onPressed: () {
                          signOut();
                          print("user has logged out");
                        },
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              'assets/icons/sign-out-alt-2.png',
                              width: 40,
                              height: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Sign Out",
                              style: TextStyle(color: Colors.black, fontSize: 24),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}

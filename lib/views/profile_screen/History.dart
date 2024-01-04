import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class History extends StatefulWidget {
  // nerima data list transaction untuk di show
  const History({
    super.key,
  });

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Stream<QuerySnapshot<Map<String, dynamic>>> getTransactionStream() {
    final transactions = FirebaseFirestore.instance.collection('transactions');
    final authUser = FirebaseAuth.instance.currentUser;
    return transactions.where('email', isEqualTo: authUser?.email).snapshots();
  }

  // main widget
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 255, 90, 44), Color.fromARGB(255, 224, 64, 0)]),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Text(
                    "MY TRANSACTION",
                    style: TextStyle(
                      fontSize: 27,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
              20.heightBox,
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: getTransactionStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      List transactionList = snapshot.data!.docs;

                      return Container(
                        height: 571,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: transactionList.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot document = transactionList[index];
                            String docID = document.id;

                            Map<String, dynamic> instance = document.data() as Map<String, dynamic>;

                            double price = instance['totalSpend'];
                            return Card(
                              child: ListTile(
                                leading: Image.network(
                                  instance['imageLink'],
                                  height: 50,
                                  width: 50,
                                ),
                                title: Text(
                                  "${instance['name']}",
                                  style: TextStyle(fontSize: 23),
                                ),
                                subtitle: Text(
                                  "quantity : ${instance['quantity']}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                trailing: Text(
                                  "\$${price.toStringAsFixed(2).toString()}",
                                  style: TextStyle(fontSize: 23),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return Center(
                        child: Text("There's no item"),
                      );
                    }
                    return Center(
                      child: Text("There's no item"),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

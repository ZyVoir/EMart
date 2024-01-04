import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:velocity_x/velocity_x.dart';

class detailBuy extends StatefulWidget {
  final Map<String, dynamic> selectedProduct;
  final String docID;
  const detailBuy({super.key, required this.selectedProduct, required this.docID});

  @override
  State<detailBuy> createState() => _detailBuyState();
}

class _detailBuyState extends State<detailBuy> {
  TextEditingController quantityController = TextEditingController();
  void showMessage(String message) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: Color(0xFfE72A00),
            title: Center(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        }));
  }

  bool isNumeric(String text) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(text);
  }

  void buyItem() {
    if (!isNumeric(quantityController.text)) {
      Navigator.of(context).pop();
      showMessage("Input must be a number");
    } else if (quantityController.text == "" || int.parse(quantityController.text) <= 0) {
      Navigator.of(context).pop();
      showMessage("Input must be greater than 0");
    } else {
      final transactions = FirebaseFirestore.instance.collection('transactions');
      final authUser = FirebaseAuth.instance.currentUser;
      transactions.add({
        'id': authUser?.uid,
        'email': authUser?.email,
        'date': DateTime.now(),
        'name': widget.selectedProduct['name'],
        'imageLink': widget.selectedProduct['imageLink'],
        'quantity': quantityController.text,
        'totalSpend': widget.selectedProduct['price'] * int.parse(quantityController.text)
      });
      Navigator.of(context).pop();
      showMessage("Successfully buy the product");
    }
  }

  void showDialogBuy() {
    setState(() {
      quantityController.text = "1";
    });
    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: Color(0xFfE72A00),
          title: Center(
            child: Column(
              children: [
                Text(
                  "Quantity :",
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: quantityController,
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: "> 0",
                      hintStyle: TextStyle(color: Color.fromARGB(150, 255, 255, 255)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                10.heightBox,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.transparent),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // Adjust the border radius as needed
                    ),
                  ),
                  onPressed: () => buyItem(),
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 86, 74),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
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
                        "PRODUCT DETAIL",
                        style: TextStyle(
                          fontSize: 27,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.network(
                    widget.selectedProduct['imageLink'],
                    height: 250,
                    width: 250,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: 500 + widget.selectedProduct['Description'].toString().length / 55 * 27,
                // isi dari product detail
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 10, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        widget.selectedProduct['name'],
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Price",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "\$${widget.selectedProduct['price']} In stock",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "SELLER DESCRIPTION",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.selectedProduct['Description'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.red), // Change color as needed
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(25), // Adjust the radius as needed
                              ),
                            ),
                          ),
                          onPressed: () => showDialogBuy(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Buy Now",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

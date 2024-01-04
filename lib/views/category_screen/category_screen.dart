import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/views/detail_screen/create.dart';
import 'package:emart_app/views/detail_screen/detail_manage.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController searchBarController = TextEditingController();

  Stream<QuerySnapshot<Map<String, dynamic>>> getProductsStream() {
    // Reference to the "products" collection
    final productsCollection = FirebaseFirestore.instance.collection('products');

    // Return a stream of snapshots from the "products" collection
    return productsCollection.snapshots();
  }

  String searchValue = "";

  void updateSearch(String value) {
    setState(() {
      searchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              //carousel brands
              10.heightBox,

              // Image Carousel
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Manage Product",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              15.heightBox,

              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) => updateSearch(value),
                        controller: searchBarController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search),
                          filled: true,
                          fillColor: whiteColor,
                          hintText: searchanything,
                          hintStyle: TextStyle(color: textfieldGrey),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreatePage(),
                            ));
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25), // Adjust the radius as neededs
                        ),
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),

              20.heightBox,
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: getProductsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      List productList = snapshot.data!.docs;
                      productList = productList
                          .where((product) => product['name']
                              .toString()
                              .toLowerCase()
                              .startsWith(searchValue.toLowerCase()))
                          .toList();
                      return Container(
                        height: 571,
                        child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: productList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 300,
                          ),
                          itemBuilder: (context, index) {
                            DocumentSnapshot document = productList[index];
                            String docID = document.id;

                            Map<String, dynamic> instance = document.data() as Map<String, dynamic>;

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => detailManage(
                                        selectedProduct: instance,
                                        docID: docID,
                                      ),
                                    ));
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: [
                                    Image.network(
                                      instance['imageLink'],
                                      height: 200,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 5, 5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              instance['name'],
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                            5.heightBox,
                                            Text(
                                              "\$${instance['price']}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.amber[800],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
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

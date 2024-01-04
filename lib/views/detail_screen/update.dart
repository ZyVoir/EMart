import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widget/CreateForm.dart';
import '../widget/TextDesciption.dart';
import '../widget/button3.dart';

class UpdatePage extends StatefulWidget {
  final Map<String, dynamic> selectedProduct;
  final String docID;
  const UpdatePage({super.key, required this.selectedProduct, required this.docID});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController imageLinkController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void showErrorMessage(String message) {
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

  void updateItem() {
    double price = double.parse(priceController.text);
    if (imageLinkController.text == "" ||
        itemNameController.text == "" ||
        itemDescriptionController.text == "" ||
        priceController.text == "") {
      showErrorMessage("All field must be filled");
      return;
    } else if (!imageLinkController.text.startsWith("http")) {
      showErrorMessage("Image Link must starts with : http");
      return;
    } else if (itemNameController.text.length < 3) {
      showErrorMessage("item name minimum of 3 characters");
      return;
    } else if (itemDescriptionController.text.length < 25) {
      showErrorMessage("image description minimum of 25 characters");
      return;
    } else if (price <= 0) {
      showErrorMessage("price must be greater than 0");
      return;
    }
    final products = FirebaseFirestore.instance.collection('products');
    products.doc(widget.docID).update({
      "imageLink": imageLinkController.text,
      "Description": itemDescriptionController.text,
      "name": itemNameController.text,
      "price": double.parse(priceController.text)
    });
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    showErrorMessage("Item succesfully updated!");
    return;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageLinkController.text = widget.selectedProduct['imageLink'];
    itemNameController.text = widget.selectedProduct['name'];
    itemDescriptionController.text = widget.selectedProduct['Description'];
    priceController.text = widget.selectedProduct['price'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE72A00),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(65, 0, 0, 0),
          child: Text(
            'UPDATE ITEM',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      backgroundColor: Color(0xFFFF6F5B),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Image Link",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: CreateForm(
                      hintT: "Image Link (http)",
                      keyBType: TextInputType.text,
                      isObscure: false,
                      isEnabled: true,
                      besar: false,
                      controller: imageLinkController,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Text(
                        "Item Name",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: CreateForm(
                      hintT: "Minimum 3 characters",
                      keyBType: TextInputType.text,
                      isObscure: false,
                      isEnabled: true,
                      besar: false,
                      controller: itemNameController,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Text(
                        "Description",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: DescText(
                      hintT: "Minimum 25 characters",
                      controller: itemDescriptionController,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Text(
                        "Price",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: CreateForm(
                      hintT: "=> 0",
                      keyBType: TextInputType.text,
                      isObscure: false,
                      isEnabled: true,
                      besar: false,
                      controller: priceController,
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: button3(
                        onPressed: () => updateItem(),
                        height: 44.0,
                        width: double.infinity,
                        child: const Text(
                          "Update",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                  ),
                  20.heightBox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

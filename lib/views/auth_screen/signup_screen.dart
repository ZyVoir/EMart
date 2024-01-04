import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/views/auth_screen/login_or_register.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../widgets_common/appLogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  final Function()? onTap;
  SignupScreen({super.key, required this.onTap});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  Future<void> addUser() async {
    final users = FirebaseFirestore.instance.collection('users');
    final currUser = FirebaseAuth.instance.currentUser;
    print(nameController.text);
    users.doc(currUser?.uid).set({
      "email": emailController.text,
      "name": nameController.text,
    });
  }

  void signUp() async {
    try {
      // Show loading indicator using Get.snackbar
      Get.snackbar(
        'Signing In',
        'Please wait...',
        showProgressIndicator: true,
        snackPosition: SnackPosition.BOTTOM,
      );
      if (passwordController.text == passwordConfirmationController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        await addUser();
      } else {
        showErrorMessage("Passwords don't match");
      }
      // Dismiss the loading indicator
      Get.back();
    } on FirebaseAuthException catch (e) {
      // Dismiss the loading indicator
      if (e.code == 'email-already-in-use') {
        showErrorMessage('Email already existed!');
      }

      Get.back();
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFfE72A00),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 20.heightBox, // Adjusted the initial padding here
              applogoWidget(),
              10.heightBox,
              "Join the $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Column(
                children: [
                  customTextField(
                      controller: nameController, obscure: false, hint: nameHint, title: name),
                  customTextField(
                      controller: emailController, obscure: false, hint: emailHint, title: email),
                  customTextField(
                      controller: passwordController,
                      obscure: true,
                      hint: passwordHint,
                      title: password),
                  customTextField(
                      controller: passwordConfirmationController,
                      obscure: true,
                      hint: passwordHint,
                      title: retypepassword),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: forgetpassword.text.make(),
                  //   ),
                  // ),
                  // 5.heightBox,
                  // Row(
                  //   children: [
                  //     // Checkbox(
                  //     //   checkColor: orangeColor,
                  //     //   value: isCheck,
                  //     //   onChanged: (newValue) {
                  //     //     setState(() {
                  //     //       isCheck = newValue;
                  //     //     });
                  //     //   },
                  //     // ),
                  //     10.heightBox,
                  //     Expanded(
                  //       child: RichText(
                  //         text: const TextSpan(
                  //           children: [
                  //             TextSpan(
                  //               text: "I agree to this ",
                  //               style: TextStyle(
                  //                 fontFamily: regular,
                  //                 color: fontGrey,
                  //               ),
                  //             ),
                  //             TextSpan(
                  //               text: termAndCondition,
                  //               style: TextStyle(
                  //                 fontFamily: regular,
                  //                 color: orangeColor,
                  //               ),
                  //             ),
                  //             TextSpan(
                  //               text: " & ",
                  //               style: TextStyle(
                  //                 fontFamily: regular,
                  //                 color: fontGrey,
                  //               ),
                  //             ),
                  //             TextSpan(
                  //               text: privacyPolicy,
                  //               style: TextStyle(
                  //                 fontFamily: regular,
                  //                 color: orangeColor,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  15.heightBox,
                  ourButton(
                      color: orangeColor,
                      title: signup,
                      textColor: whiteColor,
                      onPress: () {
                        signUp();
                      }).box.width(context.screenWidth - 50).make(),
                  // GestureDetector(
                  //   onTap: (() {
                  //     Get.back();
                  //   }),
                  //   child: RichText(
                  //       text: const TextSpan(
                  //     children: [
                  //       TextSpan(
                  //         text: alreadyHaveAccount,
                  //         style: TextStyle(fontFamily: bold, color: fontGrey),
                  //       ),
                  //       TextSpan(
                  //           text: login,
                  //           style: TextStyle(
                  //               fontFamily: bold, color: orangeColor)),
                  //     ],
                  //   )),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        alreadyHaveAccount,
                        style: TextStyle(fontFamily: bold, color: fontGrey),
                      ),
                      TextButton(
                          onPressed: widget.onTap,
                          child: Text(
                            login,
                            style: TextStyle(fontFamily: bold, color: orangeColor),
                          ))
                    ],
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}

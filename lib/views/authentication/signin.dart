// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:blog_it/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/widgets.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  final AuthService _auth = AuthService();

  bool _isLoading = false;

  // signIn() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     await authService.signInEmailAndPass(email, password).then((val) {
  //       if (val != null) {
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       }
  //     });
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => Home()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(children: [
                    SizedBox(
                      height: 150,
                    ),
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.blueAccent, BlendMode.modulate),
                      child: Image.asset(
                        'assets/images/pngegg.png',
                        height: 200,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    SizedBox(
                      height: 130,
                    ),
                    TextFormField(
                      cursorColor: Colors.blueAccent,
                      validator: (val) =>
                          val!.isEmpty ? "Enter Email Id " : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueAccent), //<-- SEE HERE
                        ),
                        hintText: "Email",
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      cursorColor: Colors.blueAccent,
                      obscureText: true,
                      validator: (val) => val!.length < 7
                          ? "Password length must be grater than 6 "
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueAccent), //<-- SEE HERE
                        ),
                        hintText: "Password",
                      ),
                    ),
                    SizedBox(height: 25),
                    GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);

                            if (result == null) {
                              setState(() => _isLoading = false);
                            }
                          }
                        },
                        child: amberButton(
                          context: context,
                          lable: "Sign In",
                        )),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                        GestureDetector(
                            onTap: () {
                              widget.toggleView();
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => SignUp(toggleView: toggleView),
                              //     ));
                            },
                            child: Text("Sign Up",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                                ))),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    )
                  ]),
                ),
              ),
            ),
    );
  }
}

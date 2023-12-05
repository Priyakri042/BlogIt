// ignore_for_file: prefer_const_constructors

import 'package:blog_it/services/database.dart';
import 'package:blog_it/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  late String quizImageUrl, quizTitle, quizDescription, quizId;

  DatabaseService databaseService = new DatabaseService();

  bool _isLoading = false;
  uploadQuestionData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizId = quizTitle.replaceAll(" ", "_").toLowerCase();

      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgurl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDescription,
      };
      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: _isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(children: [
                    TextFormField(
                      cursorColor: Colors.blueAccent,
                      validator: (val) =>
                          val!.isEmpty ? "Enter image url " : null,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueAccent), //<-- SEE HERE
                        ),
                        hoverColor: Colors.blueAccent,
                        hintText: "Blog Image Url",
                      ),
                      onChanged: (val) {
                        quizImageUrl = val;
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      cursorColor: Colors.blueAccent,
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                      validator: (val) =>
                          val!.isEmpty ? "Enter Blog Title  " : null,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueAccent), //<-- SEE HERE
                        ),
                        hintText: "Blog Title",
                      ),
                      onChanged: (val) {
                        quizTitle = val;
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      cursorColor: Colors.blueAccent,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (val) =>
                          val!.isEmpty ? "Enter Blog Description " : null,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueAccent), //<-- SEE HERE
                        ),
                        hintText: "Blog Description",
                      ),
                      onChanged: (val) {
                        quizDescription = val;
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            // Add this
                            uploadQuestionData();
                            Navigator.pop(context);
                          }
                        },
                        child: amberButton(context: context, lable: "Submit")),
                    SizedBox(
                      height: 70,
                    )
                  ]),
                ),
              ),
            ),
    );
  }
}

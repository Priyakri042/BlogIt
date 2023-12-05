import 'package:blog_it/services/auth.dart';
import 'package:blog_it/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BlogPost extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String quizId;

  const BlogPost({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.quizId,
  }) : super(key: key);

  @override
  State<BlogPost> createState() => _BlogPostState();
}

class _BlogPostState extends State<BlogPost> {
  bool isPostOwner = false;
  
  @override
  void initState() {
  super.initState();
  checkOwnership();
}

void checkOwnership() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    print('No user is currently signed in.');
    return;
  }

  final blogPostDoc = await FirebaseFirestore.instance.collection('Blog').doc(widget.quizId).get();
  final blogPostData = blogPostDoc.data();

  if (blogPostData != null && blogPostData['writerId'] == currentUser.uid) {
    setState(() {
      isPostOwner = true;
    });
  }
}
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backbutton

        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.blueAccent,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [ isPostOwner ?
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.blueAccent,
            onPressed: () async {
              final currentUser = FirebaseAuth.instance.currentUser;
              if (currentUser == null) {
                print('No user is currently signed in.');
                return;
              }

              final blogPostDoc = await FirebaseFirestore.instance
                  .collection('Blog')
                  .doc(widget.quizId)
                  .get();
              final blogPostData = blogPostDoc.data();

              if (blogPostData == null ||
                  blogPostData['writerId'] != currentUser.uid) {
                print('Only the writer of the blog post can delete it.');
                return;
              }

              try {
                await blogPostDoc.reference.delete();
                Navigator.pop(context);
              } catch (e) {
                print(e.toString());
              }
            },
          )
          : Container(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8.0),
              Image.network(widget.imageUrl),
              SizedBox(height: 8.0),
              Text(
                widget.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


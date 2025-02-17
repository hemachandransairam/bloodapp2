// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Post> posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Donation Stories'),
      ),
      body: posts.isEmpty 
          ? Center(child: Text('Share your blood donation story or experience!'))
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostCard(post: posts[index], updatePostCallback: _updatePost);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createPost,
        backgroundColor: Colors.red,
        child: Icon(Icons.add, color: Colors.white),
        tooltip: 'Share Story',
      ),
    );
  }

  void _createPost() async {
    List<File>? images = await _pickImages();
    if (images != null && images.isNotEmpty) {
      setState(() {
        posts.add(Post(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: '',
          images: images,
          likes: [],
          comments: [],
        ));
      });

      String? text = await _showTextInputDialog();
      if (text != null) {
        setState(() {
          posts.last.text = text;
        });
      }
    }
  }

  Future<List<File>?> _pickImages() async {
    List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null) {
      return pickedFiles.map((file) => File(file.path)).toList();
    }
    return null;
  }

  Future<String?> _showTextInputDialog() async {
    String? result = await showDialog(
      context: context,
      builder: (context) {
        String text = '';
        return AlertDialog(
          title: Text('Share Your Experience'),
          content: TextField(
            onChanged: (value) {
              text = value;
            },
            decoration: InputDecoration(hintText: "Tell us about your donation..."),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Share'),
              onPressed: () {
                Navigator.of(context).pop(text);
              },
            ),
          ],
        );
      },
    );
    return result;
  }

  void _updatePost(Post updatedPost) {
    setState(() {
      int index = posts.indexWhere((post) => post.id == updatedPost.id);
      if (index != -1) {
        posts[index] = updatedPost;
      }
    });
  }
}

class Post {
  final String id;
  String text;
  final List<File> images;
  List<String> likes;
  List<Comment> comments;

  Post({required this.id, this.text = '', required this.images, this.likes = const [], this.comments = const []});
}

class Comment {
  final String text;
  final String user;

  Comment({required this.text, required this.user});
}

class PostCard extends StatelessWidget {
  final Post post;
  final Function(Post) updatePostCallback;

  PostCard({required this.post, required this.updatePostCallback});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.text, style: TextStyle(fontSize: 16)),
          ),
          if (post.images.isNotEmpty)
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: post.images.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImage(image: post.images[index]),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(post.images[index], width: 100, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),
          Row(
            children: [
              IconButton(
                icon: Icon(post.likes.contains('user1') ? Icons.thumb_up : Icons.thumb_up_outlined, color: Colors.red),
                onPressed: () {
                  List<String> newLikes = List.from(post.likes);
                  if (post.likes.contains('user1')) {
                    newLikes.remove('user1');
                  } else {
                    newLikes.add('user1');
                  }

                  Post updatedPost = Post(
                    id: post.id,
                    text: post.text,
                    images: post.images,
                    likes: newLikes,
                    comments: post.comments,
                  );
                  updatePostCallback(updatedPost);
                },
              ),
              Text(post.likes.length.toString()),
              SizedBox(width: 16),
              IconButton(
                icon: Icon(Icons.comment, color: Colors.red),
                onPressed: () async {
                  String? comment = await _showCommentInputDialog(context);
                  if (comment != null) {
                    Post updatedPost = Post(
                      id: post.id,
                      text: post.text,
                      images: post.images,
                      likes: post.likes,
                      comments: List.from(post.comments)
                        ..add(Comment(text: comment, user: 'user1')),
                    );
                    updatePostCallback(updatedPost);
                  }
                },
              ),
              Text(post.comments.length.toString()),
            ],
          ),
          if (post.comments.isNotEmpty)
            ...post.comments.map((comment) => ListTile(
                  title: Text(comment.text),
                  subtitle: Text(comment.user),
                )).toList(),
        ],
      ),
    );
  }

  Future<String?> _showCommentInputDialog(BuildContext context) async {
    String? result = await showDialog(
      context: context,
      builder: (context) {
        String text = '';
        return AlertDialog(
          title: Text('Add Comment'),
          content: TextField(
            onChanged: (value) {
              text = value;
            },
            decoration: InputDecoration(hintText: "Leave a comment..."),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Post Comment'),
              onPressed: () {
                Navigator.of(context).pop(text);
              },
            ),
          ],
        );
      },
    );
    return result;
  }
}

class FullScreenImage extends StatelessWidget {
  final File image;

  FullScreenImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.file(image),
        ),
      ),
    );
  }
}
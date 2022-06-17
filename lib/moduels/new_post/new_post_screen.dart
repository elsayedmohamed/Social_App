import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:social_app/moduels/home_screen/social_layout.dart';
import 'package:social_app/shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(IcoFontIcons.arrowLeft),
          onPressed: () {
            NavigateTo(context: context, screen: SocialLayout());
          },
        ),
        title: Text(
          'Add Post',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: null,
    );
  }
}

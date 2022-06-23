import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';

import '../../cubit/states.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel model;

  ChatDetailsScreen(this.model);
  var chatTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit.get(context).getMessages(receiverId: model.uId!);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text('${model.name}')
              ],
            ),
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).messages.length > 0,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          var message =
                              SocialCubit.get(context).messages[index];
                          if (SocialCubit.get(context).userModel ==
                              message.senderId) return buildChatMe(message);

                          return buildChatItem(message);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10.0,
                            ),
                        itemCount: SocialCubit.get(context).messages.length),
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(children: [
                      Expanded(
                        child: TextFormField(
                          controller: chatTextController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type your message here',
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.blueAccent,
                        child: MaterialButton(
                          onPressed: () {
                            SocialCubit.get(context).sendMessage(
                              receiverId: model.uId!,
                              text: chatTextController.text,
                              dateTime: DateTime.now().toString(),
                            );
                            chatTextController.text = '';
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildChatItem(MessageModel model) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                )),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Text(
                '${model.text} ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
  Widget buildChatMe(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                )),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Text(
                '${model.text}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
}

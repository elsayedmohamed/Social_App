import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:social_app/moduels/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          NavigateTo(context: context, screen: NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(fontSize: 20.0),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notification_important_outlined)),
              const SizedBox(
                width: 10.0,
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(IcoFontIcons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IcoFontIcons.chat), label: 'chats'),
              BottomNavigationBarItem(
                  icon: Icon(IcoFontIcons.uiAdd), label: 'post'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'users'),
              BottomNavigationBarItem(
                  icon: Icon(IcoFontIcons.settings), label: 'settings'),
            ],
          ),
        );
      },
    );
  }
}

//email verification
//Column(
//                 children: [
//                   if (!FirebaseAuth.instance.currentUser!.emailVerified)
//                     Container(
//                       width: double.infinity,
//                       color: Colors.amber.shade300,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 10.0,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             const Icon(Icons.info_outline),
//                             const SizedBox(
//                               width: 10.0,
//                             ),
//                             const Expanded(
//                               flex: 2,
//                               child: Text(
//                                 'Please verify your email',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             const Spacer(),
//                             const SizedBox(
//                               width: 10.0,
//                             ),
//                             defaultTextButton(
//                               onpressed: () {
//                                 FirebaseAuth.instance.currentUser!
//                                     .sendEmailVerification()
//                                     .then((value) {
//                                   ShowToast(
//                                       msg: 'Check your mail ',
//                                       state: ToastStates.SUCCESS);
//                                 }).catchError((error) {});
//                               },
//                               text: 'Send',
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                 ],
//               );

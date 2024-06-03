import 'package:flutter/material.dart';
import 'package:flutter_mvvm_learning/res/color.dart';
import 'package:flutter_mvvm_learning/utils/routes/routes_name.dart';
import 'package:flutter_mvvm_learning/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
@override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);
    UserModel? usermod;

userPreferences.getUser().then((UserModel user) {
  usermod = user;

  if (usermod != null) {
    print(usermod!.token.toString()+'printing value');
  } else {
    print('usermod is null');
  }
});

    return Scaffold(
      backgroundColor: AppColors.primaryButtonColor,
      appBar: AppBar(
        title: const Text('homeScreen1'),
        actions: [
          IconButton(
              onPressed: () {
                userPreferences.removeUser().then((value) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.login, (route) => route.isCurrent);
                });
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                userPreferences.removeUser().then((value) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.login, (route) => route.isCurrent,);
                });
              },
              icon: const Text('Logout'),
            ),
            // Text(usermod!.token)
            IconButton(onPressed: (){setState(() {
              
            });}, icon: const Icon(Icons.check))
          ],
        ),
      ),
    );
  }
}

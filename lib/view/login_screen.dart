import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_learning/res/components/round_button.dart';
import 'package:flutter_mvvm_learning/utils/routes/routes_name.dart';
import 'package:flutter_mvvm_learning/utils/utils.dart';
import 'package:flutter_mvvm_learning/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../view_model/user_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose(){
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences=Provider.of<UserViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(
                hintText: 'Email',
                labelText: 'Email',
                prefixIcon: Icon(Icons.alternate_email),
              ),
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(
                    context, emailFocusNode, passwordFocusNode);
                // FocusScope.of(context).requestFocus(passwordFocusNode);
              },
            ),
            ValueListenableBuilder(
              valueListenable: _obsecurePassword,
              builder: ((context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: _obsecurePassword.value,
                  focusNode: passwordFocusNode,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    suffixIcon: InkWell(
                      onTap: () {
                        _obsecurePassword.value = !_obsecurePassword.value;
                      },
                      child: Icon(_obsecurePassword.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    prefixIcon: const Icon(Icons.alternate_email),
                  ),
                );
              }),
            ),
            SizedBox(height: height * .085),
            RoundButton(
              loading: authViewModel.loading,
              title: 'Login',
              onPress: () {
                if(_emailController.text.trim().isEmpty){
                  Utils.flushbarErrorMessage('Please entter email', context);
                } else if(_passwordController.text.trim().isEmpty){
                  Utils.flushbarErrorMessage('Please enter password', context);
                } else if(_passwordController.text.trim().length < 6){
                  Utils.flushbarErrorMessage('Min 6 character password', context);
                }else{
                  Map data={
                    'email':_emailController.text.trim(),
                    'password':_passwordController.text.trim(),
                  };
                  authViewModel.loginApi(data,context);
                  log('api hit');
                }
              },
            ),
            SizedBox(height: height * .085),
            GestureDetector(
              onTap:(){
                Navigator.pushNamedAndRemoveUntil(context,RoutesName.signup,(route)=>route.isCurrent);
              } ,
              child: const Text('Already have an account? Login'),
            )
          ],
          // child: GestureDetector(
          //   onTap: (){
          //     // Navigator.pushNamed(context, RoutesName.home);
          //     Utils.toastMessage('no internet connection');
          //     Utils.flushbarErrorMessage('this is flushbar', context);
          //     // Utils.snackBar('this is snackbar', context);
          //   },
          //   child: const Text('Click'),
          // ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_learning/res/components/round_button.dart';
import 'package:flutter_mvvm_learning/utils/utils.dart';
import 'package:flutter_mvvm_learning/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
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
              loading: authViewModel.signupLoading,
              title: 'Signup',
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
                  authViewModel.signupApi(data,context);
                  log('api hit');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

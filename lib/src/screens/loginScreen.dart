// ignore_for_file: use_build_context_synchronously

import 'package:deliveryapp/src/providers/loginProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import 'orderScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final lProvider = Provider.of<LoginProvider>(context);
    // OR Consumer<LoginProvider>(builder: (context, provider, pChild) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Welcome')),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(24),
                child: Text('Login',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w500)),
              ),
              TextFormField(
                controller: lProvider.emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'Email Address',
                    hintText: 'Enter your email'),
                validator: lProvider.emailValidator,
              ),
              AppConstants.defSpace,
              TextFormField(
                controller: lProvider.passwordController,
                obscureText: lProvider.secure,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () => lProvider.toogleSecure(),
                        icon: Icon(
                          lProvider.secure
                              ? Icons.remove_red_eye_rounded
                              : Icons.remove_red_eye_outlined,
                          color: Theme.of(context).primaryColor,
                        )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'Password',
                    hintText: 'Enter your password'),
                validator: lProvider.passwordValidator,
              ),
              Container(
                alignment: AlignmentDirectional.centerEnd,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text('Forgot Password?',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor)),
              ),
              SizedBox(
                width: double.maxFinite,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      Map<String, dynamic> result = await lProvider.login();
                      if (result['success']) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderScreen()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(result['msg']),
                        ));
                      }
                    }
                  },
                  child: !lProvider.btnLoading
                      ? const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white)),
                ),
              ),
              AppConstants.defSpace,
              RichText(
                text: TextSpan(
                    text: 'New here? ',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Create an account',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

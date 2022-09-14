import 'dart:convert';

import 'package:authapi/api_services/custom_http.dart';
import 'package:authapi/homepage.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;
  islogin() async {
    SharedPreferences sharePrefr = await SharedPreferences.getInstance();
    var token = sharePrefr.getString('token');
    if (token != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    }
  }

  @override
  void initState() {
    islogin();
    // TODO: implement initState
    super.initState();
  }

  getLogin() async {
    setState(() {
      isLoading = true;
    });
    var results = await CustomHttp()
        .loginUser(_emailController.text, _passwordController.text);
    setState(() {
      isLoading = false;
    });
    var data = jsonDecode(results);
    print("response is $data");
    if (data['access_token'] != null) {
      SharedPreferences sharePref = await SharedPreferences.getInstance();
      sharePref.setString("token", data['access_token']);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInPage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: const CircularProgressIndicator(),
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.network(
                "https://th.bing.com/th/id/R.3669de9d5710f5319efecbc86c736194?rik=6IDHaI%2bO1JMIIQ&riu=http%3a%2f%2fwallpapercave.com%2fwp%2ffVTz9PJ.jpg&ehk=oFc2LrSaFpUceLSKZ5L0AwlmnYBNL%2f7PDSxHYoXhJK0%3d&risl=&pid=ImgRaw&r=0",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Color(0xff0b5d47),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Please SignIn to your account....",
                      style: TextStyle(
                          color: Colors.white24,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Enter Email",
                        labelStyle: const TextStyle(color: Colors.white30),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                const BorderSide(color: Colors.white54)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.white54),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelText: "Enter Password",
                        labelStyle: const TextStyle(color: Colors.white30),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                const BorderSide(color: Colors.white54)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.white54),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xfffea839)),
                        onPressed: () {
                          getLogin();
                        },
                        child: const Text("Sign In")),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Doesn't have an Account? Sign up.",
                          style: TextStyle(color: Colors.white),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "“Move fast, break things”",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

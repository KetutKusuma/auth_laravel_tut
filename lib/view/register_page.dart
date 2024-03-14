// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:auth_laravel_tut/services/auth_services.dart';
import 'package:auth_laravel_tut/services/globals.dart';
import 'package:auth_laravel_tut/view/home_page.dart';
import 'package:auth_laravel_tut/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    String email = " ";
    String password = " ";
    String name = " ";

    createAccountPressed() async {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      if (emailValid) {
        http.Response response =
            await AuthServices.register(name, email, password);
        log(response.body);
        Map responseMap = jsonDecode(response.body);
        if (response.statusCode == 200) {
          log("register berhasil");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        nama: name,
                      )));
        } else {
          errorSnackBar(context, responseMap.values.first[0]);
        }
      } else {
        errorSnackBar(context, "email not valid");
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Halaman Register",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(hintText: "Name"),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(hintText: "email"),
                onChanged: (value) {
                  email = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Password"),
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: ElevatedButton(
                  onPressed: () {
                    createAccountPressed();
                  },
                  child: const Text("Register"),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const LoginPage())));
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "already have an account",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ));
  }
}

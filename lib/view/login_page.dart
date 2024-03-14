// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:auth_laravel_tut/services/auth_services.dart';
import 'package:auth_laravel_tut/services/globals.dart';
import 'package:auth_laravel_tut/view/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/zondicons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _password = "";

  loginFunction() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_email, _password);
      Map responseMap = jsonDecode(response.body);
      log(responseMap.toString());
      print(responseMap['user']);
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => HomePage(
                      nama: responseMap['user']['name'],
                    ))));
      } else {
        errorSnackBar(context, responseMap.values.first);
      }
    } else {
      errorSnackBar(context, "Masukkan semua permintaan kolom");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Halaman Login",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Email",
              ),
              onChanged: (value) {
                _email = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Password",
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                loginFunction();
              },
              icon: Iconify(Zondicons.play),
              label: Text("Login"),
              style: ElevatedButton.styleFrom(),
            )
          ],
        ),
      ),
    );
  }
}

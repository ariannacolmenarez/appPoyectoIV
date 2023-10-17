import 'package:app_movil/Home/Home.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../cifrado.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;

  String usu= '';
  String pass= '';

  void ingresar (usuario, pass) async {
    try{

      var url = "https://joseviveresmarket.000webhostapp.com/login?api";

      // getKey(usuario).then((encrypteduser) {
      //   getKey(usuario).then((encryptedpass) async {
      //     print("en camino");
      //
      //     var response = await http.post(Uri.parse(url),
      //         body:{'usuario' :encrypteduser,'pass':encryptedpass}
      //     ).timeout(const Duration(seconds: 90));print(response.body);if(response.body == '1'){
      //
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => Home()),
      //       );
      //     }else{
      //
      //       alerta();
      //     }
      //   });
      // });

      var encryptedUser = Encryption.instance.encrypt(usuario);
      var encryptedPass = Encryption.instance.encrypt(pass);
      // var keyPub = getKey();
       print(encryptedUser);
      var response = await http.post(Uri.parse(url),
          body:{
          'usuario' :encryptedUser,
          'pass':encryptedPass
      }
      ).timeout(const Duration(seconds: 90));print(response.body);
      if(response.body == '1'){

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }else{

        alerta();
      }
      } on TimeoutException catch(e){
      print('Tardo mucho la conexion');

      }on Error catch(e){
      print('Http error');
      }
  }

  void alerta() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: const Text('Las Credenciales son incorrectas'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_cart,
            size: 100,
            color: Colors.white,
          ),
          Text(
            "Market MP",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bienvenid@s",
          style: TextStyle(
              color: Colors.grey, fontSize: 42, fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Inicio de sesión"),
        const SizedBox(height: 50),
        _buildGreyText("Usuario"),
        _buildInputField(emailController),
        const SizedBox(height: 40),
        _buildGreyText("Contraseña"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 40),
        _buildLoginButton(),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }



  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        usu = emailController.text;
        pass = passwordController.text;

        if(usu != '' && pass != ''){
          ingresar(usu, pass);
        }else{
          print('Ingresa datos');
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("Iniciar sesión"),
    );
  }
}
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsindia/Auth/bloc/AuthBloc.dart';
import 'package:newsindia/Auth/models/USer.dart';
class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final key=GlobalKey<FormState>();
  late String _email;
  late String _password;
  nameFeild(name){
    return TextFormField(decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10,),),prefixIcon: Icon(name=="Email"?Icons.person_3_outlined:Icons.lock_outline_sharp,color: Colors.grey,),labelText: name),
    onSaved: (value){
      if(name=='Email'){
        setState(() {
          _email = value!;
        });
      }
      else{
        setState(() {
          _password=value!;
        });
      }
    },
      validator: (value){
        if(value!=null){
          if (name == "Email") {
            final RegExp emailRegExp = RegExp(
              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
            );
            return emailRegExp.hasMatch(value!) ? null : "Enter a valid email";
          }
        }
        else{
          return "Enter the value";
        }
      },
    );
  }
  _onLoginButtonClicked(){
    if(key.currentState!.validate()){
      key.currentState!.save();
      context.read<AuthBloc>().add(LoginUser(user: User(email: _email, password: _password)));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Form(
             key: key,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('asset/newspaper.png',height: 200,),
                    Align(alignment: Alignment.center,child: Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),),
                  Padding(padding:EdgeInsets.all(20),child: nameFeild("Email"),),
                Padding(padding:EdgeInsets.all(20),child: nameFeild("Password"),),
                ElevatedButton(onPressed: _onLoginButtonClicked,style: ElevatedButton.styleFrom(fixedSize: Size(300, 50),backgroundColor: Theme.of(context).primaryColor,), child: Text("LOGIN",style: TextStyle(color: Colors.white)),)
              ],
            ),
          ),
    );
  }
}

import 'package:flutter/material.dart';

class Cor{
  late Color corPrimaria;
  late Color corSecundaria;


  opcao1(){
    corPrimaria =  const Color.fromRGBO(240, 125, 54, 1.0);
    corSecundaria = Colors.white;
  } 

   opcao2(){
    corPrimaria =  Colors.white;
    corSecundaria = const Color.fromRGBO(240, 125, 54, 1.0) ;
  } 

}
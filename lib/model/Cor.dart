import 'package:flutter/material.dart';

//classe para o gerenciamento de cores do projeto
class Cor{
   late Color corPrimaria;
   late Color corSecundaria;
   late Color corTerciaria;


  opcao1(){
    corPrimaria =  const Color.fromRGBO(240, 125, 54, 1.0);
    corSecundaria = Colors.white;
    corTerciaria = const Color.fromRGBO(128, 128, 128, 1);
  } 

   opcao2(){
    corPrimaria =  Colors.white;
    corSecundaria = const Color.fromRGBO(240, 125, 54, 1.0) ;
    corTerciaria = const Color.fromRGBO(128, 128, 128, 1);
  } 

}
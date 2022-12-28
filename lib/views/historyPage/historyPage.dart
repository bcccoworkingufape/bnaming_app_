import 'package:bnaming_app/model/Cor.dart';
import 'package:bnaming_app/model/Historico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Repository/HistoryRepository.dart';
import '../Card/HistoryCard.dart';

// classe que constroi e exibe a tela de históricos
class historyPage extends StatefulWidget {
  historyPage({Key? key}) : super(key: key);

  @override
  State<historyPage> createState() => _historyPageState();
}
class _historyPageState extends State<historyPage> {
  List<History> historyList = [];
  Cor cor = Cor();


//app bar da tela
  appBarDinamica() {
    var historico = context.watch<HistoryRepository>();
    
    if (historico.Selecionadas.isEmpty) {
      cor.opcao1();
      return AppBar(
          title: const Text(
              "Histórico",
              style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
                              ),
                            ),
          centerTitle: true,
          backgroundColor: cor.corPrimaria,
          actions: [
            PopupMenuButton(
                color: cor.corTerciaria,
                icon:  Icon(
                  Icons.more_vert,
                  color: cor.corSecundaria,
                ),
                itemBuilder: (context) => [
                      PopupMenuItem(
                          child: ListTile(
                              title:  Center(
                                child: Text("Limpar Histórico",
                                style: TextStyle(
                                  color: cor.corSecundaria,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                historico.removeAll();
                              }))
                    ])
          ]);
    } else {
      cor.opcao2();
      return AppBar(
        
        leading: IconButton(
          color: cor.corSecundaria,
          icon: const Icon(Icons.close),
          onPressed: () {
              historico.limparSelecionadas();
          },
        ),
        title: Text("${historico.Selecionadas.length} Selecionadas",
        style:  TextStyle(
              color: cor.corSecundaria,
              fontSize: 21,
              fontWeight: FontWeight.w600,
        ),
        ),
        centerTitle: true,
        backgroundColor:cor.corPrimaria,
      );
    }
  }

//constroi a tela de historico
  @override
  Widget build(BuildContext context) {
    var historico = context.watch<HistoryRepository>();
    Cor cor2 = Cor();
    cor2.opcao1();
    return Scaffold(
      appBar: appBarDinamica(),
      body: Container(
        color: cor2.corPrimaria.withOpacity(0.7),
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(12.0),
        child:
            Consumer<HistoryRepository>(builder: (context, historyList, child) {
          return historyList.Lista.isEmpty
              ? const ListTile(
                  leading: Icon(Icons.history),
                  title: Text("histórico vazio"),
                )
              : SizedBox(
                  child: ListView.builder(
                    itemCount: historyList.tamanho(),
                    itemBuilder: (_, index) {
                      return HistoryCard(history: historyList.Lista[index]);
                    },
                  ),
                );
        }),
      ),
      //botão flutuante dinamico
      floatingActionButton: (historico.Selecionadas.isNotEmpty)
      ?
      FloatingActionButton.extended(
        onPressed: (() {
          historico.removerSelecionadasHistorico();
        }),
        elevation: 5,
        shape: RoundedRectangleBorder(
        side:  BorderSide(
          color:cor.corSecundaria,
          width: 3, 
          ),
        borderRadius: BorderRadius.circular(12.0)
      ),
        backgroundColor: cor2.corSecundaria,
        icon:  Icon(Icons.delete,color: cor2.corPrimaria,),
         label:  Text("Remover",
         style: TextStyle(
          color: cor2.corPrimaria,
          letterSpacing: 0 ,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          
          ) ,
         )
         
         )
         :null,
         
         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
    );
  }
}

import 'package:bnaming_app/http/client.dart';
import 'package:bnaming_app/model/Cor.dart';
import 'package:bnaming_app/views/helpPage/help_page.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class EvaluationPage extends StatefulWidget {
  const EvaluationPage({Key? key}) : super(key: key);

  @override
  _EvaluationPageState createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<EvaluationPage> {
  Cor cor = Cor();
  late Map _dados;
  final ClientHttp _api = ClientHttp();

  // Função para criar o campo com o gráfico de resultado de cada critério
  Widget evaluationCriterionChart(BuildContext context, String criterio, int nota, String descricao){

    cor.opcao1();

    // Criando lista base para o gráfico
    List<charts.Series<int, String>> data = [
      charts.Series<int, String>(
        id: criterio,
        data: [nota],
        domainFn: (int n,_) => n.toString(),
        measureFn: (int n, _) => n,
        colorFn: (_, __) => charts.Color.fromHex(code: '#F27E35'),
        measureLowerBoundFn: (int n, __) => 0,
        measureUpperBoundFn: (int n, __) => 5,
      )
    ];

    return Container(
      
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        criterio,
                        style:  TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: cor.corPrimaria,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(
                              criterio,
                              style:  TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: cor.corPrimaria,
                              ),
                            ),
                            content: Text(
                              descricao,
                              style:  TextStyle(
                                fontSize: 16,
                                color: cor.corTerciaria,
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child:  Text(
                                  'OK',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: cor.corPrimaria,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      iconSize: 10,
                      icon:  Icon(
                        Mdi.informationOutline,
                        color: cor.corTerciaria,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                alignment: Alignment.centerRight,
                child: Text(
                  nota.toString(),
                  style:  TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: cor.corTerciaria,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 70,
            child: charts.BarChart(
              data,
              animate: true,
              vertical: false,
              //charts.NumericAxisSpec(showAxisLine: false, renderSpec: charts.NoneRenderSpec()),
              domainAxis: const charts.OrdinalAxisSpec(showAxisLine: false, renderSpec: charts.NoneRenderSpec()),
              primaryMeasureAxis: const charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
            ),
          ),

           Divider(color: cor.corTerciaria,),

        ],
      ),
    );
  }

  num _calcMedia(Map data){
    var listNotas = data.values.toList();
    num soma = 0;
    for(int i=0; i<listNotas.length;i++){
      soma = soma + listNotas[i];
    }
    return soma/listNotas.length;
  }

  @override
  Widget build(BuildContext context) {
    cor.opcao1();

    _dados = ModalRoute.of(context)!.settings.arguments as Map;
    late Map _avaliacao;

    // Criando WIDGET para condicionar a tela entre, carregando, erro e quando tudo ocorrer bem
    return FutureBuilder(
      future: _api.postAPI(_dados["name"], _dados["segment"]).then((value) => _avaliacao = value), // Setando variável condicional para o fluxo de telas
      builder: (context, snapshot) {
        late Widget children;

        // Quando é carregado a avaliação com sucesso, vamos para essa tela
        if (snapshot.hasData) { // Se está tudo ok
          print("TUDO OK");
          children = Scaffold(
            // Configurando App Bar
            appBar: AppBar(
              title: const Text(
                "Avaliação",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              backgroundColor: cor.corPrimaria,
            ),

            //Botão flutuante
            floatingActionButton: FloatingActionButton(
              child:  Icon(Mdi.help,size: 30, color: cor.corSecundaria,),
              backgroundColor: cor.corPrimaria,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpPage()));
              },
            ),

            // Corpo da página
            body: Column(
              children:  [
                // Configurando o cabeçalho estático da página
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 25, 25, 10),
                  child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Colocando o nome avaliado
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(
                                    _dados["name"],
                                    style:  TextStyle(
                                      color: cor.corPrimaria,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                // Colocando o segmento do nome avaliado
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(
                                    _dados["segment"],
                                    style:  TextStyle(
                                      color: cor.corTerciaria,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Colocando o nome avaliado
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Row(
                                  children: [
                                    Text(
                                      _calcMedia(_avaliacao).toString(),
                                      style:  TextStyle(
                                        color: cor.corPrimaria,
                                        fontSize: 35,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                     Text(
                                      "/5",
                                      style: TextStyle(
                                        color: cor.corTerciaria,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Colocando o segmento do nome avaliado
                               Padding(
                                padding: const EdgeInsets.fromLTRB(00, 0, 20, 0),
                                child: Text(
                                  "nota média",
                                  style: TextStyle(
                                    color: cor.corTerciaria,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),


                        ],
                      ),

                      //Espaçamento
                      const SizedBox(height: 10,),

                       Divider(
                        color: cor.corTerciaria,
                      ),
                    ],
                  ),
                ),

                // Configurando a lista de avaliação
                Expanded(
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior(),
                    child: GlowingOverscrollIndicator(
                      axisDirection: AxisDirection.down,
                      color: cor.corTerciaria,
                      child: ListView(
                        children: [

                          const SizedBox(height: 5,),

                          // Corpo com as avaliações de cada critério
                          evaluationCriterionChart(context, "Conceito",_avaliacao["conceito"], "Critério que avalia se o conceito do nome está alinhado ou não à marca. Trata-se de um critério subjetivo."),
                          evaluationCriterionChart(context, "Criatividade",_avaliacao["criatividade"], "Critério que avalia se o nome informado é ou não criativo."),
                          evaluationCriterionChart(context, "Grafia",_avaliacao["grafia"], "Critério que avalia se o nome é fácil ou difícil de ser escrito."),
                          evaluationCriterionChart(context, "Memorização",_avaliacao["memorizacao"], "Critério que avalia se o nome é fácil ou difícil de ser lembrado."),
                          evaluationCriterionChart(context, "Originalidade",_avaliacao["originalidade"], "Critério que avalia a originalidade do nome, se é um nome já existente ou não."),
                          evaluationCriterionChart(context, "Popularidade",_avaliacao["popularidade"], "Critério que avalia o quão popular o nome é."),
                          evaluationCriterionChart(context, "Potencial",_avaliacao["potencial"], "Critério que avalia o potencial do nome como marca. Trata-se de um critério subjetivo."),
                          evaluationCriterionChart(context, "Pronuncia",_avaliacao["pronuncia"], "Critério que avalia se o nome é fácil ou difícil de se pronunciar de forma correta."),
                          evaluationCriterionChart(context, "Simplicidade",_avaliacao["simplicidade"], "Critério que avalia se o nome é simples ou complexo."),
                          evaluationCriterionChart(context, "Sonoridade",_avaliacao["sonoridade"], "Critério que avalia se o nome soa bem ou mal."),

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          );

        // Quando há algum erro no carregamento, vamos para essa tela
        } else if (snapshot.hasError){ // Se tiver erro
          print("ERRO");
          children = Scaffold(
            backgroundColor: cor.corPrimaria,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Icon(
                    Icons.warning_amber_rounded,
                    size: 120,
                    color: cor.corSecundaria,
                  ),
                  const SizedBox(height: 5,),
                   Text(
                    "ATENÇÃO!",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: cor.corSecundaria
                    ),
                  ),
                  const SizedBox(height: 15,),
                   Text(
                    "Serviço temporariamente indispoível.",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: cor.corSecundaria,

                    ),
                  ),
                  const SizedBox(height: 5),
                   Text(
                    "Tente novamente mais tarde.",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: cor.corSecundaria,

                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    child:  Text(
                      "VOLTAR",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: cor.corPrimaria,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(cor.corSecundaria),
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),

                ],
              ),
            ),
          );

        // Enquanto está carregando a responta, vamos para essa tela
        } else { // Enquanto carrega
          print("CARREGANDO");
          children = Scaffold(
            body: Container(
              color: cor.corPrimaria,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    SizedBox(
                      child: CircularProgressIndicator(color: cor.corSecundaria,),
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Realizando avaliação...",
                      style: TextStyle(
                        color: cor.corSecundaria,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return children;
      },
    );
  }
}
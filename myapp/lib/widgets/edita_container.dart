import 'package:flutter/material.dart';

// Verificar quais bordas estão habilitadas
bool bordaTopo = true;
bool bordaInferior = true;
bool bordaEsquerda = true;
bool bordaDireita = true;

// Update é utilizado para o timer do cria grid
bool update = false;

// Listas para armazenar todos as customizações do grid
List<Border> bordas = [];
List<Color> cores = [];
int _num = 0; // Obtem o num atual do grid para facilitar as mudanças
// Bordas e cores padrão
Border _borda = Border.all(color: Colors.black, width: 2);
Color _corBorda = Color.fromARGB(255, 0, 0, 0);
Color _corFundo = Color.fromARGB(255, 255, 255, 255);
// Inputs para cores da borda e fundo
final _inputRBorda = TextEditingController(text: "0");
final _inputGBorda = TextEditingController(text: "0");
final _inputBBorda = TextEditingController(text: "0");
final _inputRFundo = TextEditingController(text: "0");
final _inputGFundo = TextEditingController(text: "0");
final _inputBFundo = TextEditingController(text: "0");


class EditaContainer {
  // Pintor possui um bug causado pelos operadores ternários deixando espaços transparentes entre containers, talvez tenha que usar if else para todos os casos para evitar esse espaço em branco sobreescrito.
  Border _pintaBorda(bool bordaTopo, bool bordaInferior, bool bordaEsquerda, bool bordaDireita) {
    return Border(
      left: bordaEsquerda
          ? BorderSide(color: _corBorda, width: 2)
          : BorderSide(color: Colors.transparent, width: 2),
      right: bordaDireita
          ? BorderSide(color: _corBorda, width: 2)
          : BorderSide(color: Colors.transparent, width: 2),
      top: bordaTopo
          ? BorderSide(color: _corBorda, width: 2)
          : BorderSide(color: Colors.transparent, width: 2),
      bottom: bordaInferior
          ? BorderSide(color: _corBorda, width: 2)
          : BorderSide(color: Colors.transparent, width: 2),
    );
  }

  Color _pintaFundo(){
    return Color.fromARGB(255, int.parse(_inputRFundo.text), int.parse(_inputGFundo.text), int.parse(_inputBFundo.text));
  }

  // Utilizado para obter o numero do container que vai ser editado e abrir a tela de edição
  void editaBorda(BuildContext context, int num) {
    _num = num;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditorScreen(),
      ),
    );
  }

  // Salva os inputs e fecha a tela de edição
  void _salvar(int num){
    bordas[num-1] = _borda;
    cores[num-1] = _corFundo;
    update = true;
  }
}

// Tela de edição
class EditorScreen extends StatefulWidget {
  @override
  _EditorScreenState createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  // Toggles para habilitar os botões da borda e cor, lembrar de remover fundoToggle que é desnecessario
  bool bordaToggle = false;
  bool bordaCor = false;
  bool fundoCor = false;
  bool fundoToggle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela de edição"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Preview do container final
              SizedBox(height: 20),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(16),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(border: _borda, color: _corFundo),
                ),
              ),
              // Toggle das opções de borda
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Color(0xFF004684)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            bordaToggle = !bordaToggle;
                          });
                        },
                        child: Text("Habilitar bordas",
                            style: TextStyle(color: Colors.white)),
                      ),
                      Container
                      (
                        height: bordaCor || bordaToggle
                          ? 200
                          : 0,
                        child: bordaToggle
                          ? Column(
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFF85B5D9)),
                                ),
                                onPressed: () {
                                  setState(() {
                                    bordaDireita = !bordaDireita;
                                    _borda = EditaContainer()._pintaBorda(
                                        bordaTopo,
                                        bordaInferior,
                                        bordaEsquerda,
                                        bordaDireita);
                                  });
                                },
                                child: Text("Borda direita",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFF85B5D9)),
                                ),
                                onPressed: () {
                                  setState(() {
                                    bordaEsquerda = !bordaEsquerda;
                                    _borda = EditaContainer()._pintaBorda(
                                        bordaTopo,
                                        bordaInferior,
                                        bordaEsquerda,
                                        bordaDireita);
                                  });
                                },
                                child: Text("Borda esquerda",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFF85B5D9)),
                                ),
                                onPressed: () {
                                  setState(() {
                                    bordaTopo = !bordaTopo;
                                    _borda = EditaContainer()._pintaBorda(
                                        bordaTopo,
                                        bordaInferior,
                                        bordaEsquerda,
                                        bordaDireita);
                                  });
                                },
                                child: Text("Borda topo",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFF85B5D9)),
                                ),
                                onPressed: () {
                                  setState(() {
                                    bordaInferior = !bordaInferior;
                                    _borda = EditaContainer()._pintaBorda(
                                        bordaTopo,
                                        bordaInferior,
                                        bordaEsquerda,
                                        bordaDireita);
                                  });
                                },
                                child: Text("Borda inferior",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ) : SizedBox.shrink(),
                      )
                    ]
                  ),
                  Column(children: [
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF004684)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          bordaCor = !bordaCor;
                        });
                      },
                      child: Text("Cor da borda",
                          style: TextStyle(color: Colors.white)),
                    ),
                    Container(
                      height: bordaCor || bordaToggle
                          ? 200
                          : 0,
                      child: bordaCor
                          ? Column(
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF85B5D9)),
                              ),
                              onPressed: () {
                                setState(() {
                                  _corBorda = Color.fromARGB(255, int.parse(_inputRBorda.text), int.parse(_inputGBorda.text), int.parse(_inputBBorda.text));
                                  _borda = EditaContainer()._pintaBorda(
                                      bordaTopo,
                                      bordaInferior,
                                      bordaEsquerda,
                                      bordaDireita
                                    );
                                });
                              },
                              child: Text("Mudar cor", style: TextStyle(color: Colors.white)),
                            ),
                            Column(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 65,
                                child: TextField(
                                  controller: _inputRBorda,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(255, 175, 0, 0),
                                    border: OutlineInputBorder(),
                                    hintText: "R",
                                    hintStyle: TextStyle(color: Colors.white)
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: 65,
                                child: TextField(
                                  controller: _inputGBorda,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(255, 0, 175, 0),
                                    border: OutlineInputBorder(),
                                    hintText: "G",
                                    hintStyle: TextStyle(color: Colors.white)
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: 65,
                                child: TextField(
                                  controller: _inputBBorda,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(255, 0, 0, 175),
                                    border: OutlineInputBorder(),
                                    hintText: "B",
                                    hintStyle: TextStyle(color: Colors.white)
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        ],
                      ) : SizedBox.shrink(),
                    )
                  ],
                  )
                ],
              ),
              // Toggle das opções de fundo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF004684)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          fundoCor = !fundoCor;
                        });
                      },
                      child: Text("Cor do fundo",
                          style: TextStyle(color: Colors.white)),
                    ),
                    Container(
                      height: fundoCor || fundoToggle
                          ? 200
                          : 0,
                      child: fundoCor
                          ? Column(
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF85B5D9)),
                              ),
                              onPressed: () {
                                setState(() {
                                  _corFundo = EditaContainer()._pintaFundo();
                                });
                              },
                              child: Text("Mudar cor", style: TextStyle(color: Colors.white)),
                            ),
                            Column(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 65,
                                child: TextField(
                                  controller: _inputRFundo,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(255, 175, 0, 0),
                                    border: OutlineInputBorder(),
                                    hintText: "R",
                                    hintStyle: TextStyle(color: Colors.white)
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: 65,
                                child: TextField(
                                  controller: _inputGFundo,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(255, 0, 175, 0),
                                    border: OutlineInputBorder(),
                                    hintText: "G",
                                    hintStyle: TextStyle(color: Colors.white)
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: 65,
                                child: TextField(
                                  controller: _inputBFundo,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(255, 0, 0, 175),
                                    border: OutlineInputBorder(),
                                    hintText: "B",
                                    hintStyle: TextStyle(color: Colors.white)
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        ],
                      ) : SizedBox.shrink(),
                    )
                  ],
                  )
                ],
              ),
              // Botão de salvar, tentar mudar futuramente o alignment para o salvar ficar na direita da tela e o resto como space evenly
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    EditaContainer()._salvar(_num);
                    Navigator.pop(context);
                  });
                },
                child: Text("Salvar",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

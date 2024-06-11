import 'dart:math';

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
List<String> texto = [];
List<double> angulo = [];
List<double> tamanho = [];

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

String _textoContainer = 'teste';
final _inputTexto = TextEditingController(text: "");
double _tamanhoTexto = 24;
final _inputTextoTamanho = TextEditingController(text: "");
double _anguloTexto = 0;
final _inputAnguloTexto = TextEditingController(text: "");

class EditaContainer {
  // Pintor possui um bug causado pelos operadores ternários deixando espaços transparentes entre containers, talvez tenha que usar if else para todos os casos para evitar esse espaço em branco sobreescrito.
  Border _pintaBorda(bool bordaTopo, bool bordaInferior, bool bordaEsquerda,
      bool bordaDireita) {
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

  Color _pintaFundo() {
    return Color.fromARGB(255, int.parse(_inputRFundo.text),
        int.parse(_inputGFundo.text), int.parse(_inputBFundo.text));
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
  void _salvar(int num) {
    bordas[num - 1] = _borda;
    cores[num - 1] = _corFundo;
    texto[num - 1] = _textoContainer;
    angulo[num - 1] = _anguloTexto;
    tamanho[num - 1] = _tamanhoTexto;

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
  bool textoToggle = false;

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
                    child: OverflowBox(
                      minHeight: 0,
                      minWidth: 0,
                      maxHeight: double.infinity,
                      maxWidth: double.infinity,
                      child: Transform.rotate(
                        angle: _anguloTexto * pi / 180,
                        child: Text(
                          "$_textoContainer",
                          style: TextStyle(fontSize: _tamanhoTexto),
                        ),
                      ),
                    )),
              ),
              // Toggle das opções de borda
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF004684)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    Container(
                      height: bordaCor || bordaToggle ? 200 : 0,
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
                            )
                          : SizedBox.shrink(),
                    )
                  ]),
                  Column(
                    children: [
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF004684)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        height: bordaCor || bordaToggle ? 200 : 0,
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
                                        _corBorda = Color.fromARGB(
                                            255,
                                            int.parse(_inputRBorda.text),
                                            int.parse(_inputGBorda.text),
                                            int.parse(_inputBBorda.text));
                                        _borda = EditaContainer()._pintaBorda(
                                            bordaTopo,
                                            bordaInferior,
                                            bordaEsquerda,
                                            bordaDireita);
                                      });
                                    },
                                    child: Text("Mudar cor",
                                        style: TextStyle(color: Colors.white)),
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
                                              fillColor: Color.fromARGB(
                                                  255, 175, 0, 0),
                                              border: OutlineInputBorder(),
                                              hintText: "R",
                                              hintStyle: TextStyle(
                                                  color: Colors.white)),
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
                                              fillColor: Color.fromARGB(
                                                  255, 0, 175, 0),
                                              border: OutlineInputBorder(),
                                              hintText: "G",
                                              hintStyle: TextStyle(
                                                  color: Colors.white)),
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
                                              fillColor: Color.fromARGB(
                                                  255, 0, 0, 175),
                                              border: OutlineInputBorder(),
                                              hintText: "B",
                                              hintStyle: TextStyle(
                                                  color: Colors.white)),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            : SizedBox.shrink(),
                      )
                    ],
                  )
                ],
              ),
              // Toggle das opções de fundo
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF004684)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            textoToggle = !textoToggle;
                          });
                        },
                        child: Text("Texto",
                            style: TextStyle(color: Colors.white)),
                      ),
                      Container(
                        height: textoToggle ? 180 : 0,
                        child: textoToggle
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
                                        _textoContainer = _inputTexto.text;
                                        _inputTextoTamanho.text == ""
                                            ? _tamanhoTexto = 24
                                            : _tamanhoTexto = double.parse(
                                                _inputTextoTamanho.text);
                                        _inputAnguloTexto.text == ""
                                            ? _anguloTexto = 0
                                            : _anguloTexto = double.parse(
                                                _inputAnguloTexto.text);
                                      });
                                    },
                                    child: Text("Mudar texto",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 70,
                                        width: 350,
                                        child: TextField(
                                          controller: _inputTexto,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                              filled: true,
                                              fillColor: Color.fromARGB(
                                                  62, 0, 158, 150),
                                              border: OutlineInputBorder(),
                                              hintText:
                                                  "Insira o texto desejado",
                                              hintStyle: TextStyle(
                                                  color: Colors.black)),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 40,
                                            width: 120,
                                            child: TextField(
                                              controller: _inputAnguloTexto,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  filled: true,
                                                  fillColor: Color.fromARGB(
                                                      62, 0, 158, 150),
                                                  border: OutlineInputBorder(),
                                                  hintText: "Rotação",
                                                  hintStyle: TextStyle(
                                                      color: Colors.black)),
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 40,
                                            width: 120,
                                            child: TextField(
                                              controller: _inputTextoTamanho,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  filled: true,
                                                  fillColor: Color.fromARGB(
                                                      62, 0, 158, 150),
                                                  border: OutlineInputBorder(),
                                                  hintText: "Tamanho",
                                                  hintStyle: TextStyle(
                                                      color: Colors.black)),
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                            : SizedBox.shrink(),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF004684)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        height: fundoCor ? 200 : 0,
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
                                        _corFundo =
                                            EditaContainer()._pintaFundo();
                                      });
                                    },
                                    child: Text("Mudar cor",
                                        style: TextStyle(color: Colors.white)),
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
                                              fillColor: Color.fromARGB(
                                                  255, 175, 0, 0),
                                              border: OutlineInputBorder(),
                                              hintText: "R",
                                              hintStyle: TextStyle(
                                                  color: Colors.white)),
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
                                              fillColor: Color.fromARGB(
                                                  255, 0, 175, 0),
                                              border: OutlineInputBorder(),
                                              hintText: "G",
                                              hintStyle: TextStyle(
                                                  color: Colors.white)),
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
                                              fillColor: Color.fromARGB(
                                                  255, 0, 0, 175),
                                              border: OutlineInputBorder(),
                                              hintText: "B",
                                              hintStyle: TextStyle(
                                                  color: Colors.white)),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            : SizedBox.shrink(),
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
                child: Text("Salvar", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

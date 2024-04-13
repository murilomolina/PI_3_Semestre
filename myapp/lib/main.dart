import 'package:flutter/material.dart';
import 'package:pathfinding/finders/astar.dart';
import 'package:pathfinding/core/grid.dart';

void main() {
  runApp(const MyApp());
}

// Trata os dados do pathfinder para saber quais pedaços do grid foram encontrados para o caminho mais curto
class PathProcessor {
  // Cria listas para armazenar a coordenada das colunas e fileiras
  final List<int> _cols = [];
  final List<int> _rows = [];

  // Getters para _cols e _rows retornados como cols e rows para outras classes
  List<int> get cols => List<int>.from(_cols);
  List<int> get rows => List<int>.from(_rows);

  // Metodo para separas os dados do path encontrado pelo algoritimo
  void processPath(List<List<dynamic>> path) {
    for (var pair in path) {
      _cols.add(pair[0]);
      _rows.add(pair[1]);
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Grid Display'),
        ),
        body: const Center(
          // Da display no grid criado pelo GridWidget
          child: GridWidget(),
        ),
      ),
    );
  }
}

class GridWidget extends StatefulWidget {

  const GridWidget({super.key});

  @override
  State<GridWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  // Copia da nossa grid do pacote pathfinding para ter dados acessaveis pelo construtor de Grids, tentar corrigir esse workaround no futuro para remover essa copia do grid de verdade do pathfinder.
  final List<List<int>> gridData = [
    [0, 0, 1, 1], // 0 - walkable, 1 - not walkable
    [1, 0, 1, 0],
    [1, 0, 1, 0],
    [1, 0, 0, 0]
  ];

  @override
  Widget build(BuildContext context) {
    // Grid com nossas posições 0 é andavel e 1 não é
    var grid = Grid(4, 4, [
    [0, 0, 1, 1],
    [1, 0, 1, 0],
    [1, 0, 1, 0],
    [1, 0, 0, 0]
    ]);
    // Cria um pathfinder usando o algoritimo A*
    var pathFinder = AStarFinder();
    // Acha um caminho originando das coordenadas 0,0 indo até 3,3
    var path = pathFinder.findPath(0, 0, 3, 3, grid.clone());

    // Chama a nossa classe para filtrar o path
    var pathProcessor = PathProcessor();
    pathProcessor.processPath(path);
    // Coloca os valores filtrados em novas variaveis
    var rows = pathProcessor.rows;
    var cols = pathProcessor.cols;
    // Controla as posições ainda disponiveis em rows e cols
    int pos = 0;

    return GridView.builder(
      // Calcula o tamanho do grid que tem que ser montado
      itemCount: gridData.length * gridData[0].length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridData[0].length,
      ),
      itemBuilder: (context, index) {
        // Descobre a posição da coluna e fileira da iteração atual
        int row = index ~/ gridData[0].length;
        int col = index % gridData[0].length;
        Color color;
        // Colore o tile do grid caso a row e col estejam na mesma posição que as coordenas de cols e rows na pos atual
        if(cols[pos] == col && rows[pos] == row){
          color = Colors.amber;
          // Passa a pos pro proximo index de cols e rows
          pos++;
        }
        // Colore os tiles que são andáveis mas que não foram utilizados pelo pathfinder para o caminho mais curto
        else if(gridData[row][col] == 0){
          color = Colors.green;
        }
        // Caso o tile não esteja disponivel colore de vermelho
        else{
          color = Colors.red;
        }
        // Devolve o container que vai ser a grid da coordenada da atual iteração
        return Container(
          margin: const EdgeInsets.all(2),
          color: color,
          child: Center(
            child: Text('$row, $col'),
          ),
        );
      },
    );
  }
}
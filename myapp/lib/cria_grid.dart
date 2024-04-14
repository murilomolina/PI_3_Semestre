import 'package:flutter/material.dart';
import 'package:pathfinding/core/grid.dart';
import 'package:pathfinding/finders/astar.dart';
import 'package:myapp/path_processor.dart';
import 'package:myapp/busca.dart';

class CriaGrid extends StatefulWidget {

  const CriaGrid({super.key});

  @override
  State<CriaGrid> createState() => _CriaGridState();
}

class _CriaGridState extends State<CriaGrid> {
  // Copia da nossa grid do pacote pathfinding para ter dados acessaveis pelo construtor de Grids, tentar corrigir esse workaround no futuro para remover essa copia do grid de verdade do pathfinder.
  final List<List<int>> gridData = [
    [0, 0, 1, 1],
    [1, 0, 1, 1],
    [1, 0, 1, 1],
    [1, 0, 0, 0]
  ];

  @override
  Widget build(BuildContext context) {
    // Grid com nossas posições 0 é andavel e 1 não é
    var grid = Grid(4, 4, [
    [0, 0, 1, 1],
    [1, 0, 1, 1],
    [1, 0, 1, 1],
    [1, 0, 0, 0]
    ]);
    // Cria um pathfinder usando o algoritimo A*
    var pathFinder = AStarFinder();
    // Cria um pathProcessor pra tratar os dados das coordenadas encontradas pelo pathfinder
    var pathProcessor = PathProcessor();
    // Lista do tipo usado pelo pathFinder
    List<List<dynamic>> path;
    // Marcador da posição atual das listas de cols e rows
    int pos = 0;
    try{
      if (coordenadas.isNotEmpty){
        // Acha um caminho originando das coordenadas 0,0 indo até 3,3
        path = pathFinder.findPath(0, 0, coordenadas[0], coordenadas[1], grid.clone());
        // Chama a nossa classe para filtrar o path
        pathProcessor.processPath(path);
        // Coloca os valores filtrados em novas variaveis
        var rows = pathProcessor.rows;
        var cols = pathProcessor.cols;
        // Reseta a pos para novas coordenadas enviadas pelo usuario
        pos = 0;

        return GridView.builder(
        // Limita o maximo de containers para 16
        itemCount: 16,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          // Limita o maximo de colunas em 4
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          // Descobre a posição da coluna e fileira da iteração atual
          int row = index ~/ gridData[0].length;
          int col = index % gridData[0].length;
          Color color;
          // Colore o tile do grid caso a row e col estejam na mesma posição que as coordenas de cols e rows na pos atual
          if((cols.isNotEmpty && rows.isNotEmpty) && (cols[pos] == col && rows[pos] == row)){
            color = Colors.amber;
            // Passa a pos pro proximo index de cols e rows
            if(pos < cols.length-1){
              pos++;
            }
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
            color: color,
            child: Center(
              // Insere a coordenada no grid para facilitar testes, remover quando adicionar busca por nome ra trabalho, etc
              child: Text('$col, $row'),
            ),
          );
        },
      );
      }
    }
    catch(e){
      // previne erros no display caso uma coordenada inalcancavel seja inserida, passar a mensagem na tela para o usuario no futuro
      print("Escolha uma coordenada que pode ser alcancada");
    }
    // Monta o grid sem pathfinding
    return GridView.builder(
      // Limita o maximo de containers para 16
      itemCount: 16,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // Limita o maximo de colunas em 4
        crossAxisCount: 4,
      ),
      itemBuilder: (context, index) {
        // Descobre a posição da coluna e fileira da iteração atual
        int row = index ~/ gridData.length;
        int col = index % gridData.length;
        Color color;
        // Colore os tiles que são andáveis mas que não foram utilizados pelo pathfinder para o caminho mais curto
        if(gridData[row][col] == 0){
          color = Colors.green;
        }
        // Caso o tile não esteja disponivel colore de vermelho
        else{
          color = Colors.red;
        }
        // Devolve o container que vai ser a grid da coordenada da atual iteração
        return Container(
          color: color,
          child: Center(
            // Insere a coordenada no grid para facilitar testes, remover quando adicionar busca por nome ra trabalho, etc
            child: Text('$col, $row'),
          ),
        );
      },
    );
  }
}
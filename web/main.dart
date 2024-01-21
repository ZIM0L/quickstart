import 'dart:html';
import 'dart:async';

void main() {
  querySelector('#output')?.text = 'Gra w życie.';
  List<List<TableCellElement>> rows = [];
  var index = 2;

  void boolToText() {

  }
  //function to create table
  void printGameBlueprint(row, col) {

    for (var i = 0; i < row; i++) {
      List<TableCellElement> cells = [];
      for (var f = 0; f < col; f++) {
        var cell = TableCellElement()..text = '□';
        cells.add(cell); // tworzy rzad
      }
      rows.add(cells);
    } //wypelnianie tablicy pusto

    var table = TableElement();
    for (var i = 0; i < row; i++) {
      var tableRow = TableRowElement();
      for (var f = 0; f < col; f++) {
        tableRow.append(rows[i][f]);
      }
      table.append(tableRow);
    }
    querySelector('#gameDiv')?.append(table); // dodanie
  } // dodawanie tablicy do div

  void updateCellText() {
    for (var i = 0; i < rows.length; i++) {
      for (var j = 0; j < rows[i].length; j++) {
        var cell = rows[i][j];
        // if (cell) {
          
        // }
      }
    }
    print(rows);
    print('Wykonuję co 1 sekundy!');
  }

  printGameBlueprint(20, 60);
  Timer.periodic(Duration(seconds: 1), (timer) {
      updateCellText();
  });
}

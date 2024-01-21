import 'dart:html';
import 'dart:async';

void main() {
  querySelector('#output')?.text = 'Gra w życie.';
  var row = 1;
  var col = 4;
  List<List<bool>> rows = [];
  List<List<TableCellElement>> rowsText = [];

  void addTable() {
  querySelector('#gameDiv')?.innerHtml = ""; //clear prev table
  var table = TableElement();
    for (var i = 0; i < rows.length; i++) {
      var tableRow = TableRowElement();
      for (var f = 0; f < rows[i].length; f++) {
        tableRow.append(rowsText[i][f]);
      }
      table.append(tableRow);
    }
    querySelector('#gameDiv')?.append(table);
  }

  void boolToText() {
      for (var i = 0; i < rows.length; i++) {
      List<TableCellElement> colsText = [];
        for (var f = 0; f < rows[i].length; f++) {
          var cell = rows[i][f];
          var cellTest = TableCellElement();
          cell == true? cellTest.text = "■" : cellTest.text = "□";
          colsText.add(cellTest);

        }
        print("+++++++++++++++"); 
      print(rowsText[0][0].text); 
      print(rowsText[0][1].text); 
      print(rowsText[0][2].text); 
      print(rowsText[0][3].text); 
      rowsText.addAll([colsText]);
      }
      print("----------------------"); 
      print(rowsText[0][0].text); 
      print(rowsText[0][1].text); 
      print(rowsText[0][2].text); 
      print(rowsText[0][3].text); 
  }

  var index = 0;
  void updateCellText() {
    rows[0][index] = true;
    index++;
    boolToText();
    addTable();
  }

  void printGameBlueprint(int row, int col) {
    for (var i = 0; i < row; i++) {
      List<bool> cellsArray = [];
      for (var f = 0; f < col; f++) {
        var cell = false;
        cellsArray.add(cell);
      }
      rows.add(cellsArray);
    }
  }

  printGameBlueprint(row, col);
  updateCellText();

  Timer.periodic(Duration(seconds:2), (timer) {
    updateCellText();
    // print('Wykonuję co 4 sekundy!');
  });
}

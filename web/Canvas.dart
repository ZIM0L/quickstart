import 'dart:async';
import 'dart:html';
import 'dart:math';



  void drawChart() {
  CanvasElement canvas = CanvasElement(width: window.innerWidth, height: 400);
  querySelector("#containerForCanvas")!.append(canvas);
  CanvasRenderingContext2D context = canvas.context2D;
 

  Timer.periodic(Duration(milliseconds: 800), (timer) {
   
  int numPoints = Random().nextInt(200) + 120;
   List<Point> data = List.generate(
      numPoints,
      (index) => Point(0, Random().nextInt(330) + 50),
    );
  var distance = window.innerWidth! / data.length;


   void draw() {
    context.clearRect(0, 0, canvas.width!, canvas.height!);

    context.beginPath();
    context.moveTo(0, data[0].y);

    for (var i = 1; i < data.length-1; i++) {
      var newDistance = distance * i;
      context.lineTo(newDistance, data[i].y);
      context.arc(newDistance+3, data[i].y+5, 1, 0, 2 * pi);
      context.stroke();
    }

    context.lineTo(canvas.width!,data[data.length-1].y);
    context.lineTo(canvas.width!,canvas.height!);
    context.lineTo(0,canvas.height!);
    context.fillStyle = 'rgb(${Random().nextInt(255)}, ${Random().nextInt(255)}, ${Random().nextInt(255)})';
    context.fill();
    context.stroke();
  }

  draw();
    });
}
  
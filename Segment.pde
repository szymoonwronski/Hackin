class Segment {
  int number;
  int id;
  String shape;
  String shapecolor;
  String backgroundcolor;
  
  Segment(int n) {
    id = n;
  }
  
  void randomizeValues() {
   shape = shapes[int(random(shapes.length))];
   shapecolor = colors[int(random(colors.length))]; 
   backgroundcolor = colors[int(random(colors.length))]; 
  }
  
  void displayCovered(int x, int y) {
    stroke(0, 200, 0);
    textSize(40);
    fill(50);
    rectMode(CORNER);
    textAlign(CENTER, CENTER);
    strokeWeight(4);
    rect(spaceleft + space * x + (x - 1) * scale, space * y + (y - 1) * scale, scale, scale);
    fill(0, 200, 0);
    text(str(number), spaceleft + space * x + (x - 1) * scale, space * y + (y - 1) * scale, scale, scale);
  }
  void displayShown(int x, int y) {
    stroke(0, 200, 0);
    textSize(40);
    switch(backgroundcolor) {
      case "red": fill(255, 0, 0); break;
      case "yellow": fill(255,255,0); break;
      case "orange": fill(255, 165, 0); break;
      case "blue": fill(0, 0, 255); break;
      case "purple": fill(150, 0, 200); break;
      case "green": fill(0, 255, 0); break;
      case "pink": fill(255,192,203); break;
    }
    rectMode(CORNER);
    ellipseMode(CORNER);
    textAlign(CENTER, CENTER);
    strokeWeight(4);
    rect(spaceleft + space * x + (x - 1) * scale, space * y + (y - 1) * scale, scale, scale);
    stroke(30);
    switch(shapecolor) {
      case "red": fill(255, 0, 0); break;
      case "yellow": fill(255,255,0); break;
      case "orange": fill(255, 165, 0); break;
      case "blue": fill(0, 0, 255); break;
      case "purple": fill(150, 0, 200); break;
      case "green": fill(0, 255, 0); break;
      case "pink": fill(255,192,203); break;
    }
    switch(shape) {
      case "triangle": triangle(spaceleft + space * x + (x - 1) * scale + scale / 2, space * y + (y - 1) * scale + scale / 6,
      spaceleft + space * x + (x - 1) * scale + scale / 6, space * y + (y - 1) * scale + 5 * scale / 6,
      spaceleft + space * x + (x - 1) * scale + 5 * scale / 6, space * y + (y - 1) * scale + 5 * scale / 6); break;
      case "square": rect(spaceleft + space * x + (x - 1) * scale + scale / 6, space * y + (y - 1) * scale + scale / 6, 
      2 * scale / 3, 2 * scale / 3); break;
      case "rectangle": rect(spaceleft + space * x + (x - 1) * scale + scale / 6, space * y + (y - 1) * scale + scale / 4, 
      2 * scale / 3, scale / 2); break;
      case "circle": ellipse(spaceleft + space * x + (x - 1) * scale + scale / 6, space * y + (y - 1) * scale + scale / 6, 
      2 * scale / 3, 2 * scale / 3); break;
    }
    fill(0);
    text(str(id + 1), spaceleft + space * x + (x - 1) * scale, space * y + (y - 1) * scale - 5, scale, scale);
  }
}

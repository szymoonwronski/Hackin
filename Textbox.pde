class Textbox {
  int w, h, x, y;
  String value;
  
  Textbox(int a, int b, int c, int d) {
    w = a;
    h = b;
    x = c;
    y = d;
    value = "";
  }
  
  void display() {
    noStroke();
    strokeWeight(4);
    fill(50);
    rectMode(CENTER);
    rect(x, y, w, h, 20);
    fill(0, 200, 0);
    textSize(40);
    textAlign(LEFT, CENTER);
    text(value, x - w / 2 + 10, y - 10); 
  }
}

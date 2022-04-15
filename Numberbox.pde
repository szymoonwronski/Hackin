class Numberbox {
  int w, h, x, y;
  String value;
  String label;
  boolean isActive;
  
  Numberbox(int a, int b, int c, int d) {
    w = a;
    h = b;
    x = c;
    y = d;
    value = "";
    label = "";
    isActive = false;
  }
  
  void display() {
    noStroke();
    if(isActive) fill(70);
    else fill(50);
    rectMode(CENTER);
    rect(x, y, w, h, 20);
    fill(0, 200, 0);
    textSize(40);
    textAlign(LEFT, CENTER);
    text(label, x - w / 2 + 10, y - 10);
    textAlign(RIGHT, CENTER);
    text(value, x + w / 2 - 10, y - 10);
  }
  
  boolean numberboxHover() {
    if(mouseX >= x - w / 2 && mouseX <= x + w / 2 &&
    mouseY >= y - h / 2 && mouseY <= y + h / 2) {
      fill(70);
      rect(x, y, w, h, 20);
      fill(0, 200, 0);
      textSize(40);
      textAlign(LEFT, CENTER);
      text(label, x - w / 2 + 10, y - 10);
      textAlign(RIGHT, CENTER);
      text(value, x + w / 2 - 10, y - 10);
      return true;
    }
    return false;
  }
  
  boolean numberboxPressed() {
    if(numberboxHover() && mousePressed) {
      return true;
    }
    return false;
  }
}

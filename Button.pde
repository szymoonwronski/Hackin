class Button {
  int w, h, x, y;
  
  Button(int a, int b, int c, int d) {
    w = a;
    h = b;
    x = c;
    y = d;
  }
  
  void display() {
    stroke(0, 200, 0);
    strokeWeight(4);
    fill(50);
    rectMode(CENTER);
    rect(x, y, w, h, 20);
    fill(0, 200, 0);
    textSize(40);
    textAlign(CENTER, CENTER);
    text("Hack", x, y - 10);
    
  }
  
  boolean buttonHover() {
    if(mouseX >= x - w / 2 && mouseX <= x + w / 2 &&
    mouseY >= y - h / 2 && mouseY <= y + h / 2) {
      stroke(0, 200, 0);
      strokeWeight(4);
      fill(70);
      rectMode(CENTER);
      rect(x, y, w, h, 20);
      fill(0, 200, 0);
      textSize(40);
      textAlign(CENTER, CENTER);
      text("Hack", x, y - 10);
      return true;
    }
    return false;
  }
  
  boolean buttonPressed() {
    if(buttonHover() && mousePressed) {
      return true;
    }
    return false;
  }
}

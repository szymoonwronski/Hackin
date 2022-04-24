int numberOfSegments, numberOfQuestions, numberOfRounds;
String question, answer, error;
float timeToRemember, timeToAnswer, timeRemained, s;
int rows, cols, scale, space, spaceleft;
int state, currentRound;
boolean con;

String[] shapes = {"triangle", "square", "rectangle", "circle"};
String[] colors = {"red", "yellow", "orange", "blue" ,"purple", "green", "pink"};
String[] questions = {"shape", "shape color", "background color"};

Button button;
Textbox textbox;
Numberbox[] numberboxes;
Numberbox activeNumberbox, p;
Segment[] segments;

void setVars() {
  numberOfSegments = int(numberboxes[0].value);
  numberOfQuestions = int(numberboxes[1].value);
  numberOfRounds = int(numberboxes[2].value);
  timeToRemember = float(numberboxes[3].value) * frameRate;
  timeToAnswer = float(numberboxes[4].value) * frameRate;
}

void setup() {
  size(1000, 600);
  surface.setTitle("Hackin");
  background(30);
  frameRate(60);
  
  space = 20;
  state = 0;
  error = "";
  
  numberboxes = new Numberbox[5];
  for(int i = 0; i < 5; i++) {
    numberboxes[i] = new Numberbox(width / 2, height / 10, width / 2, 50 + i * height / 8, i);
  }
  numberboxes[0].label = "Number Of Segments";
  numberboxes[0].value = "6";
  numberboxes[1].label = "Number Of Questions";
  numberboxes[1].value = "2";
  numberboxes[2].label = "Number Of Rounds";
  numberboxes[2].value = "4";
  numberboxes[3].label = "Time To Remember";
  numberboxes[3].value = "8";
  numberboxes[4].label = "Time To Answer";
  numberboxes[4].value = "14";
  
  activeNumberbox = numberboxes[0];
  p = activeNumberbox;
  
  setVars();
  
  button = new Button(width / 5, height / 8, width / 2, height - height / 4);
  textbox = new Textbox(width / 2, height / 9, width / 2, height - height / 5);
  
}

void draw() {
  background(30);
  
  switch(state) {
    case 0: menu(); break;
    case 1: displayCoveredSegments();
      displayTime();
    
      timeRemained--;
      if(timeRemained < 0) {
        timeRemained = timeToAnswer;
        s = width / (2 * timeRemained);
        state = 2;
      } break;
    case 2: displayShownSegments();
      textbox.display();
      displayQuestion();
      displayTime();
      
      timeRemained--;
      if(timeRemained < 0) {
        timeRemained = 1 * frameRate;
        s = width / (2 * timeRemained);
        state = 3;
      } break;
    case 3: if(currentRound == numberOfRounds) {
            timeRemained = 1 * frameRate;
            s = width / (2 * timeRemained);
            state = 4;
      }
      else answerPanel();
    
      timeRemained--;
      if(timeRemained < 0) {
        if(checkAnswer()) {
          currentRound++;
          randomizeSegments();
          createQuestion();
          timeRemained = timeToRemember;
          s = width / (2 * timeRemained);
          textbox.value = "";
          state = 1;
        }
        else state = 0;
      } break;
    case 4: winPanel();
      
      timeRemained--;
      if(timeRemained < 0) state = 0;
  }
}

void setLayout() {
  
  if(numberOfSegments % 5 == 0) {
    cols = 5;
    rows = numberOfSegments / 5;
  }
  else if(numberOfSegments % 4 == 0) {
    cols = 4;
    rows = numberOfSegments / 4;
  }
  else if(numberOfSegments % 3 == 0) {
    cols = 3;
    rows = numberOfSegments / 3;
  }
  else if(numberOfSegments == 2) {
    cols = 2;
    rows = 1;
  }
  else if(numberOfSegments == 1) {
    cols = 1;
    rows = 1;
  }
  
  scale = (int(0.7 * height) - (rows + 1) * space) / rows;
  while(scale * cols + (cols + 1) * space > width) {
    scale -= 1;
  }
  spaceleft = (width - (space * (cols + 1) + cols * scale)) / 2;
}

void displayCoveredSegments() {
  int k = 0;
  for(int i = 1; i <= rows; i++) {
    for(int j = 1; j <= cols; j++) {
      segments[k].displayCovered(j, i);
      k++;
    }
  }
}

void displayShownSegments() {
  int k = 0;
  for(int i = 1; i <= rows; i++) {
    for(int j = 1; j <= cols; j++) {
      segments[k].displayShown(j, i);
      k++;
    }
  }
}

void createQuestion() {
  question = "";
  answer = "";
  IntList ids = new IntList();
  for(int i = 0; i < numberOfSegments; i++) ids.append(i);
  for(int i = 0; i < numberOfQuestions; i++) {
    int index = int(random(ids.size()));
    int id = ids.get(index);
    ids.remove(index);
    String attribute = questions[int(random(questions.length))];
    
    question += attribute + " ( " + segments[id].number + " ) ";
    
    switch(attribute) {
      case "shape": attribute = segments[id].shape; break;
      case "shape color": attribute = segments[id].shapecolor; break;
      case "background color": attribute = segments[id].backgroundcolor; break;
    }
    answer += attribute + " ";
  }
}

void displayQuestion() {
  textAlign(CENTER, CENTER);
  textSize(30);
  text(question, width / 2, 0.7 * height);
}

void displayTime() {
  stroke(0, 200, 0);
  strokeWeight(1);
  fill(0, 200, 0);
  line(width / 4, 0.9 * height, width / 4 + timeRemained * s, 0.9 * height);
}

void displayError() {
  textSize(30);
  text(error, width / 2, 0.9 * height);
}

void randomizeSegments() {
  IntList numbers = new IntList();
  int i = 1;
  for(Segment s : segments) {
    numbers.append(i);
    s.randomizeValues();
    i++;
  }
  for(i = 0; i < numberOfSegments; i++) {
    int index = int(random(numbers.size()));
    segments[i].number = numbers.get(index);
    numbers.remove(index);
  }
}

boolean checkAnswer() {
  if(trim(answer).equals(trim(textbox.value.toLowerCase()))) return true;
  return false;
}

boolean checkForErrors() {
  error = "";
  for(Numberbox n : numberboxes) {
    if(int(n.value) < 1) {
      error = "Values cannot be smaller than 1";
      return false;
    }
  }
  if(int(numberboxes[0].value) != 1 && int(numberboxes[0].value) % 2 != 0 && int(numberboxes[0].value) % 3 != 0 && int(numberboxes[0].value) % 5 != 0) {
    error = "Number Of Segments must be 1 or a multiply of 2, 3 or 5";
    return false;
  }
  if(int(numberboxes[1].value) > int(numberboxes[0].value)) {
    error = "Number Of Questions cannot exceed Number Of Segments";
    return false;
  }
  return true;
}

void menu() {
  button.display();
  displayError();
  if(mousePressed) {
    boolean x = false;
    for(Numberbox n : numberboxes) {
      if(n.numberboxHover()) x = true;
    }
    if(!x) {
      activeNumberbox.isActive = false;
      activeNumberbox = numberboxes[0];
      con = false;
    }
  }
  for(Numberbox n : numberboxes) {
    n.display();
    if(n.numberboxPressed()) {
      p.isActive = false;
      activeNumberbox = n;
      n.isActive = true;
      p = n;
      con = false;
    }
  }
  if(button.buttonPressed()) {
    starting();
  }
}

void answerPanel() {
  background(30);
  textAlign(CENTER, CENTER);
  if(checkAnswer()) text("Correct", width / 2, height / 2);
  else text("Incorrect", width / 2, height / 2);
}

void winPanel() {
  background(30);
  textAlign(CENTER, CENTER);
  text("Hacked", width / 2, height / 2);
}

void starting() {
  if(checkForErrors()) {
    setVars();
    setLayout();
    segments = new Segment[numberOfSegments];
    for(int i = 0; i < numberOfSegments; i++) {
     segments[i] = new Segment(i); 
    }
    randomizeSegments();
    createQuestion();
    activeNumberbox.isActive = false;
    con = false;
    activeNumberbox = numberboxes[0];
    timeRemained = timeToRemember;
    s = width / (2 * timeRemained);
    textbox.value = "";
    currentRound = 1;
    state = 1;
  }
}

void keyPressed() {
  if(state == 2) {
    if(key == ENTER) {
      state = 3;
      timeRemained = 1 * frameRate;
      s = width / (2 * timeRemained);
    }
    else if(key == BACKSPACE && textbox.value.length() > 0) textbox.value = textbox.value.substring(0, textbox.value.length() - 1);
    else if(key != BACKSPACE) textbox.value += key;
  }
  else if(state == 0) {
    if(key == CODED) {
      if(keyCode == UP && activeNumberbox.id > 0) {
        activeNumberbox.isActive = false;
        activeNumberbox = numberboxes[activeNumberbox.id - 1];
        activeNumberbox.isActive = true;
        con = false;
      }
      else if(keyCode == DOWN && activeNumberbox.id < 4) {
        activeNumberbox.isActive = false;
        activeNumberbox = numberboxes[activeNumberbox.id + 1];
        activeNumberbox.isActive = true;
        con = false;
      }
    }
    else {
      if(key == ENTER) {
        starting();
      }
      else {
        if(!con) {
          activeNumberbox.value = "";
          con = true;
        }
        if(key == BACKSPACE && activeNumberbox.value.length() > 0) activeNumberbox.value = activeNumberbox.value.substring(0, activeNumberbox.value.length() - 1);
        else if(key != BACKSPACE) activeNumberbox.value += key;
      }
    }
  }
}

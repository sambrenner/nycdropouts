class School {
  String dbnCode;

  String name;
  String address;

  String cohortYear;
  String cohortCat;

  int students;
  int grads;
  int advRegents;
  int regents;
  int local;
  int enrolled;
  int dropouts;
  float dropoutPerc;
  float radius = 0;
  float tradius = 10;
  float hue = 0;
  
  PVector lonLat = new PVector();
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  int drawMode = DrawMode.PT;
  Boolean showName = true;
  
  School() {
  }
  
  void calculate() {
    dropoutPerc = dropouts / (float)students; 
  }
  
  void update() {
    pos.lerp(tpos, 0.1);
    radius = lerp(radius, tradius, 0.1);
  }
  
  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    
    switch(drawMode) {
      case DrawMode.PT:
        drawPoint();
        break;
      case DrawMode.GRADS:
        drawGrads();
        break;
      case DrawMode.DROPOUTS:
        drawDropouts();
        break;
    }
    
    if(showName) {
      showName();
    }
    
    popMatrix();
  }
  
  void showName() {
    if(dist(mouseX, mouseY, pos.x, pos.y) < 5) {
      fill(0);
      textSize(10);
      text(name + " " + ceil(dropoutPerc * 100) + "% Dropouts",10,5);
    }
  }
  
  void drawPoint() {
    noStroke();
    fill(0);
    ellipse(0,0,2,2);
  }
  
  void drawGrads() {
  }
  
  void drawDropouts() {
    stroke(0);
    fill(map(dropoutPerc, .3, 0, 0, 75), 100, 100); 
    ellipse(0,0,4,4); 
  }
}

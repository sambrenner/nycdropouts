ArrayList<School> schools = new ArrayList();
Boolean zoom = false;
PImage bg;

void setup () {
  size(1280, 720);
  colorMode(HSB, 100);
  loadData("cohorts_2007_4yraugust.csv");
  sortByLatLong();
  bg = loadImage("Boroughs.png");
}

void draw() {
  background(100);
  image(bg, 0, 0);
  fill(100,80);
  rect(0,0,width,height);
  
  for(School s:schools) {
    s.update();
    s.render();
  }
}

void toggleNames() {
  for(School s:schools) {
    s.showName = !s.showName;
  }
}

void setDrawMode(int mode) {
  for(School s:schools) {
    s.drawMode = mode;
  }
}

void sortByLatLong() {
  for(School s:schools) {
    //Tilemill String: -74.2817,40.9672,-73.6115,40.4320
    s.tpos.x = map(s.lonLat.x, -74.2817, -73.6115, 0, 684); 
    s.tpos.y = map(s.lonLat.y, 40.9672, 40.4320, 0, 720);
  }
}


void loadData (String csv) {
  Table t = loadTable(csv);
  t.removeTitleRow();

  for (int i = 0;i<t.getRowCount();i++) {
    School s = new School();
    s.dbnCode = t.getString(i, "dbn");
    s.name = t.getString(i, "school_name");
    s.address = t.getString(i, "address");
    s.cohortYear = t.getString(i, "cohort_year");
    s.cohortCat = t.getString(i, "cohort_category");
    s.students = t.getInt(i, "students");
    s.grads = t.getInt(i, "grads");
    s.advRegents = t.getInt(i, "adv_regents");
    s.regents = t.getInt(i, "regents");
    s.local = t.getInt(i, "local");
    s.enrolled = t.getInt(i, "enrolled");
    s.dropouts = t.getInt(i, "dropouts");
    s.lonLat.x = t.getFloat(i, "long");
    s.lonLat.y = t.getFloat(i, "lat");
    schools.add(s);
  }
}

void keyPressed() {
  switch(key) {
    case 'n':
      toggleNames();
      break;
    case 'd':
      setDrawMode(DrawMode.DROPOUTS);
      break;
  }
  
}


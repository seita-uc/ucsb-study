void loadDataSet() {
  // 1. Loading the Table
  table = loadTable("data/kara.csv", "header");
  rows = table.getRowCount();
  animatedSize = new float[rows];

  // 2. Feedback
  println("Rows: ", rows);
  for (int i=0; i<rows; i++) {
    animatedSize[i] = 0;
    
    int thisYear = table.getInt(i, 0);
    x[i] = map(thisYear, 1998, 2019, 200, 700);
    println("year: ", table.getString(i, 0));
    println("level: ", table.getString(i, 1));
  }
}


void showData() {
  // A. Row by Row, displaying the information...
  for (int i=0; i<rows; i++) {
    // 1. Setting the values 
    int thisYear = table.getInt(i, 0);
    float x = map(thisYear, 1998, 2019, 200, 700);
    float y = height/2;
    int thisLevel = table.getInt(i, 1);
    float theSize = map(thisLevel, 0, 10, 0, maxSize);
    if (animatedSize[i] < theSize) animatedSize[i] += 0.55; 
    // 2. Drawing
    fill(255);
    noStroke();
    ellipse(x, y, 4, 4); // Dot
    fill(0, 255, 0, 50);
    ellipse(x, y, animatedSize[i], animatedSize[i]);

    // 3. The Year
    fill(255);
    textAlign(CENTER);
    textSize(8.5);
    text(thisYear, x, y-9);
  }

  // B. Title
  textSize(8.5*1.61803398875*1.61803398875);
  textAlign(LEFT);
  text("Kara's Life", 185, 200);
}

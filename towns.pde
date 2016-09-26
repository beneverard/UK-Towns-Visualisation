
JSONArray towns;

int padding = 50;
int canvas_size = 700;

int point_min = 5;
int point_max = 5;

int point_range = point_max - point_min;


void setup() {

  towns = loadJSONArray("towns.json");
  
  int min_population = 0;
  int max_population = 0;
  
  Float min_x = null;
  Float min_y = null;
  
  Float max_x = null;
  Float max_y = null;
  
  Float offset_x = null;
  Float offset_y = null;
  
  float multiplier;
  
  // Sets the screen to be 640 pixels wide and 360 pixels high
  size(700, 700);
  
  // Set the background to black and turn off the fill color
  background(255);
  noFill();
  stroke(255, 0, 0);
  //fill(255, 0, 0);
  
  // show the content area (less padding)
  //rect(50, 50, 600, 600);
  
  for (int i = 0; i < towns.size(); i++) {
    
    JSONArray town;
    
    // output the line as an array
    town = towns.getJSONArray(i);
    
    if ( town.size() <= 4 ) {
      continue;
    }
    
    //towns.getJSONArray(2));
    
    
    int population = Integer.parseInt(town.getString(2).replace(",", ""));
    
    if ( min_population == 0 ) {
      min_population = population;
    } else {
      
      if ( population < min_population ) {
         min_population = population; 
      }
      
    }
    
    if ( max_population == 0 ) {
      max_population = population;
    } else {
      
      if ( population > max_population ) {
         max_population = population; 
      }
    
    }
    
    
    
    // get the coords yo
    float x = town.getFloat(4);
    float y = town.getFloat(5);
    
    if ( min_x == null ) {
      min_x = x;
    } else {
      
      if ( x < min_x ) {
         min_x = x; 
      }
      
    }
        
    if ( min_y == null ) {
      min_y = y;
    } else {
      
      if ( y < min_y ) {
         min_y = y; 
      }
      
    }
    
    if ( max_x == null ) {
      max_x = x;
    } else {
      
      if ( x > max_x ) {
         max_x = x; 
      }
      
    }
        
    if ( max_y == null ) {
      max_y = y;
    } else {
      
      if ( y > max_y ) {
         max_y = y; 
      }
      
    }
  
  }
 
 println(min_population);
 println(max_population);
 
  offset_x = max_x - min_x;
  offset_y = max_y - min_y;
  
  // convert the offsets to instructions
  //min_x = 0 - min_x;
  //min_y = 0 - min_y;
  
  // set the default multiplier for the canvas...
  multiplier = canvasSize() / offset_x;
  
  // ... but if it's too big calculate it based on the other axis
  if ( offset_y > offset_x ) {
    multiplier = canvasSize() / offset_y;
  }
  
  int random_color = randomColor();
  for (int i = 0; i < towns.size(); i++) {
    
    JSONArray town;
    
    // output the line as an array
    town = towns.getJSONArray(i);
    
    if ( town.size() <= 4 ) {
      continue;
    }
    
    int population = Integer.parseInt(town.getString(2).replace(",", ""));
    
    // get the coords yo
    float x = town.getFloat(4);
    float y = town.getFloat(5);
    
    x = ((x - min_x) * multiplier);
    y = ((y - min_y) * multiplier);
    
    x = (canvasSize() - x) + padding;
    y = y + padding;
  
    int point_size = (int) Math.floor(((float)point_range / (float)max_population) * (float)population);
    
    float r = y / 2.95;
    float g = random_color;
    float b = x / 2.95;
    
    // draw the place
    fill(r, g, b, 100);
    noStroke();
    ellipse(y, x, point_min + point_size, point_min + point_size);
    
    
    // output the town name for reference
     //text(town.getString(1), y + 5, x);

  }

}

int canvasSize() {
  return canvas_size - (padding * 2);
}

int randomColor() {
  
  int min = 0;
  int max = 255;
  
  return min + (int)(Math.random() * ((max - min) + 1));
  
}


//latitude    = 41.145556; // (φ)
//longitude   = -73.995;   // (λ)

//mapWidth    = 200;
//mapHeight   = 100;

//// get x value
//x = (longitude+180)*(mapWidth/360)

//// convert from degrees to radians
//latRad = latitude*PI/180;

//// get y value
//mercN = log(tan((PI/4)+(latRad/2)));
//y     = (mapHeight/2)-(mapWidth*mercN/(2*PI));
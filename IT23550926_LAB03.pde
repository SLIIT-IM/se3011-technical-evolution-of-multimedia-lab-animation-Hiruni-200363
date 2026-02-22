
int state = 0; 
int score = 0;
int startTime;
int duration = 30; 


float px = 350, py = 175;
float step = 6;
float pr = 20;


float ox, oy;
float xs = 3, ys = 2.5;
float orr = 15;


float hx, hy;
float ease = 0.08;


boolean trails = false;


void setup() {
  size(700, 350);
  resetOrb();
  hx = px;
  hy = py;
}


void draw() {

  
  if (!trails) {
    background(255);
  } else {
    noStroke();
    fill(255, 40);
    rect(0, 0, width, height);
  }

  
  if (state == 0) {
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(28);
    text("Catch the Orb!", width/2, height/2 - 40);
    textSize(18);
    text("Press ENTER to Start", width/2, height/2 + 10);
    text("Press T to Toggle Trails", width/2, height/2 + 40);
  }

 
  else if (state == 1) {

    
    int elapsed = (millis() - startTime) / 1000;
    int left = duration - elapsed;

    if (left <= 0) {
      state = 2;
    }

   
    if (keyPressed) {
      if (keyCode == RIGHT) px += step;
      if (keyCode == LEFT)  px -= step;
      if (keyCode == DOWN)  py += step;
      if (keyCode == UP)    py -= step;
    }

    px = constrain(px, pr, width - pr);
    py = constrain(py, pr, height - pr);

    // ORB MOVEMENT + BOUNCE
    ox += xs;
    oy += ys;

    if (ox > width - orr || ox < orr) xs *= -1;
    if (oy > height - orr || oy < orr) ys *= -1;

    // COLLISION (catch orb)
    float d = dist(px, py, ox, oy);
    if (d < pr + orr) {
      score++;
      resetOrb();
      xs *= 1.1; 
      ys *= 1.1;
    }

    
    hx = hx + (px - hx) * ease;
    hy = hy + (py - hy) * ease;

    
    fill(255, 120, 80);
    ellipse(ox, oy, orr*2, orr*2);

    
    fill(60, 120, 220);
    ellipse(px, py, pr*2, pr*2);

    
    fill(80, 200, 120);
    ellipse(hx, hy, 14, 14);

    
    fill(0);
    textSize(16);
    textAlign(LEFT, TOP);
    text("Score: " + score, 20, 20);
    text("Time Left: " + left, 20, 45);
    text("Press T for Trails", 20, 70);
  }

  
  else if (state == 2) {
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(26);
    text("Time Over!", width/2, height/2 - 30);
    textSize(20);
    text("Final Score: " + score, width/2, height/2 + 10);
    text("Press R to Restart", width/2, height/2 + 45);
  }
}


void keyPressed() {

  
  if (state == 0 && keyCode == ENTER) {
    state = 1;
    score = 0;
    startTime = millis();
  }

  
  if (state == 2 && (key == 'r' || key == 'R')) {
    state = 0;
    px = width/2;
    py = height/2;
    hx = px;
    hy = py;
    resetOrb();
  }

  
  if (key == 't' || key == 'T') {
    trails = !trails;
  }
}


void resetOrb() {
  ox = random(orr, width - orr);
  oy = random(orr, height - orr);
}

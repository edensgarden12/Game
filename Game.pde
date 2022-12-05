import processing.sound.*;
SoundFile wiiSound;

ArrayList<Platform>platform;

int state=0;
PImage starsImg;
int score;

PImage[]amongImages=new PImage[2];
PImage[]moonImages= new PImage[2];
Animation moonAnimation;
Animation amongAnimation;

Player p1;
Platform plat1;
Platform plat2;
Platform plat3;
Platform plat4;
Platform plat5;
Platform plat6;
Platform plat7;

float groundY=800;

ArrayList<Platform>platformList;


void setup() {
  wiiSound= new SoundFile(this, "wii.wav");
  wiiSound.play(); 
  size(1200, 800);
  score=0;
  
  starsImg=loadImage("stars.jpg");
  starsImg.resize(width, height);
  plat1=new Platform(width/2, 650);
  plat2=new Platform(width/2+150, 450);
  plat3=new Platform (width/2-100, 300);
  plat4=new Platform(width/2+250, 200);
  plat5=new Platform (width/2, 100/2);
  plat6=new Platform (width/2+200, 300);
  plat7=new Platform(width/2-200, 300);
  platformList= new ArrayList <Platform>();

  platformList.add(plat1);
  platformList.add(plat2);
  platformList.add(plat3);
  platformList.add(plat4);
  platformList.add(plat5);

  //load in among us images and put in array

  for (int i=0; i<amongImages.length; i=i+1) {

    amongImages[i]=loadImage("among" + str(i) + ".png");
  }
  amongAnimation=new Animation (amongImages, 0.1, 0.4);
  p1= new Player(width/2, height-200, 50, 110, amongAnimation);
  //amongAnimation.isAnimating=true;
  
    for (int i=0; i<moonImages.length; i=i+1) {

    moonImages[i]=loadImage("moon" + str(i) + ".png");
    }
    
    moonAnimation= new Animation (moonImages, 1.0, 0.5);
 
    
}





void draw() {
  background(starsImg);
  if(wiiSound.isPlaying()==false){
    wiiSound.play();
    
  }

 
    
  amongAnimation.isAnimating=true;
  moonAnimation.isAnimating=true;
  moonAnimation.display(width/2,height/2);

  
  textSize(50);
  text("Score is "+ score, 180, 200);
  

  switch(state) {
  case 0:
    startScreen();
    break;
  case 1:
  
  println(p1.isFalling);

    p1.render();
    p1.move();
    p1.jumping();
    p1.falling();
    p1.topOfJump();
    p1.landing();
    p1.fallOfPlatform(platformList);
    p1.hitGround(groundY);
    isDead();
   


    //forLoop for all platfroms
    for (Platform aPlatform : platformList) {
      aPlatform.render();
      aPlatform.collide(p1);
      aPlatform.reset();
    
  }

    break;
  case 2:
    gameOver();
  }
}

void keyPressed() {
  if (key== 'a') {
    p1. isMovingLeft=true;
  }

  if (key== 'd') {
    p1.isMovingRight=true;
  }
  if (key=='w' && p1.isJumping==false&& p1.isFalling==false) {
    p1.isJumping=true; //starts new jump for p1
    p1.topOfJumpY= p1.y-p1.jumpHeight;
    
    score=score+1;
    
 
  }
  if (key=='r') {
    state=1;
  }
}

void startScreen() {
 ;
  textSize(60);
  textAlign(CENTER);
  text("Press 'r' to start", width/2, height/2);
}

void gameOver() {
  
  textSize(60);
  textAlign(CENTER);
  text("Game Over", width/2, height/2);

  
  textSize(60);
  textAlign(CENTER);
  text("Press any key to continue", 600, 450);
  if (keyPressed) {
    state=1;
    setup();
  }
}
void keyReleased() {
  if (key=='a') {
    p1.isMovingLeft=false;
  }
  if (key=='d') {
    p1.isMovingRight=false;
  }
}
void isDead() {
  if (p1.dead == true) {
    state = 2;
  }
}
 

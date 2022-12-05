


class Platform {

  int x;
  int y;
  int w;
  int h;


  int left;
  int right;
  int top;
  int bottom;
  
  //making constructor

  Platform(int startX, int startY) {

    rectMode(CENTER);
    x=startX;
    y=startY;
    w=80;
    h=15;
    left=x-w/2;
    right=x+w/2;
    top=y-h/2;
    bottom=y+h/2;
    
    

  }

  void render() {
    left=x-w/2;
    right=x+w/2;
    top=y-h/2;
    bottom=y+h/2;
   rect(x, y, w, h);
  }

  void collide(Player aPlayer) {
    if (left< aPlayer.right&&
      right> aPlayer.left &&
      top<aPlayer.bottom &&
      bottom >aPlayer.top &&
      aPlayer.isFalling == true) {
      //println("collide");
      aPlayer.isFalling=false; //makes stop falling
      aPlayer.isJumping = false;
      aPlayer.y=y-h/2-aPlayer.h/2+2;
    } else {
      //println("not collide");
    }
  }

  void moveDown() {
    y=y+6;
  }
  //resets platform
  void reset(){
    if(y>height){
      y=0;
      x=int(random(100,1000));
       //score+=1;
  
      
    }
  }
}

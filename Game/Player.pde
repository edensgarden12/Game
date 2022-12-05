class Player {

  int x;
  int y;
  int w;
  int h;
  int speed;
  int jumpHeight; //distnace of jumping upward
  int topOfJumpY;

  boolean isMovingLeft;
  boolean isMovingRight;
  boolean isJumping;
  boolean isFalling;

  boolean dead;

  int left;
  int right;
  int top;
  int bottom;

  Animation animation;

  //my constructor

  Player(int startX, int startY, int startW, int startH, Animation startingAnimation ) {
    x=startX;
    y=startY;
    w=startW;
    h=startH;
    animation=startingAnimation;

    isMovingLeft=false;
    isMovingRight=false;

    isJumping= false;
    isFalling= false;
    speed=8;
    jumpHeight=230;
    topOfJumpY= y-jumpHeight;

    dead = false;

    left=x-w/2;
    right=x+w/2;
    top=y-h/2;
    bottom=y+h/2;
  }


  ///making functions

  void render() {
    rectMode(CENTER);
    
    //rect(x,y,w,h);
    animation.display(x, y);
    
  }
  //controls players movement
  void move() {
    if (isMovingLeft==true) {
      x=x-speed;
    }

    if (isMovingRight==true) {
      x=x+speed;
    }

    left=x-w/2;
    right=x+w/2;
    top=y-h/2;
    bottom=y+h/2;
  }

  void jumping() {
    if (isJumping==true) {
      y-=speed;

      for (Platform aPlatform : platformList) {
        aPlatform.moveDown();
      }
      
    }
  }
  void falling() {
    if (isFalling==true)
      y+=speed;
  }
  void topOfJump() {
    if (y<=topOfJumpY) {
      isJumping=false; //stop jumping up
      isFalling=true; //stop falling down
    }
  }
  void landing() {
    if (y>=height-h/2) {
      isFalling=false; //stops falling
      y=height-h/2;
    }
  }

  void fallOfPlatform(ArrayList<Platform>aPlatformList) {

    if (isJumping==false && y<height -h/2) {
      boolean onPlatform=false;
      for (Platform aPlatform : aPlatformList) {
        if (top<=aPlatform.bottom &&
          bottom>=aPlatform.top &&
          left<=aPlatform.right &&
          right>=aPlatform.left) {
          onPlatform=true;
        }
      }
      if (onPlatform==false) {
        isFalling=true;
      }
    }
  }

  void hitGround(float ground) {
    if (bottom >= ground) {
      dead = true;
    }
  }
}

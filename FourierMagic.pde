int mouseValue=100,freqMouseValue=100;
float time=0,freq=0.035;
int slider=1;
ArrayList<Float>list =new ArrayList<Float>(300);
void setup(){
  size(650,500);
}

void draw(){
  background(2);
  
  
  //slider for n
  strokeWeight(6);
  stroke(255,100);
  line(100,400,550,400);
  stroke(255);
  line(100,400,mouseValue,400);
  
  slider=int(map(mouseValue,100,550,0,20));
  textSize(18);
  text(String.valueOf(slider),mouseValue-5,390);
  textSize(25);
  text("n",70,407);
  
  //slider for freq
  stroke(255,100);
  line(100,450,550,450);
  stroke(255);
  line(100,450,freqMouseValue,450);
  
  freq=map(freqMouseValue,100,550,0.01,0.06);
  textSize(18);
  text(String.valueOf(freq),freqMouseValue-5,440);
  textSize(25);
  text("f",70,457);
  
  
  
  translate(180,180);
  
  strokeWeight(2);
  float x=0,y=0;
  for(int i=0;i<=slider;i++)
  {
    float prex=x;
    float prey=y;
    int n=i*2+1;
    float radius=60*(4/(n*PI));
    x+=radius*cos(n*time);
    y+=radius*sin(n*time);
    stroke(255,100);
    noFill();
    ellipse(prex,prey,radius*2,radius*2);
    stroke(255);
    line(prex,prey,x,y);
    fill(255);
  }
  
  list.add(y);
  beginShape();
  noFill();
  for(int i=0;i<list.size();i++){
    vertex(list.size()-i+(160+2*slider),list.get(i));
  }
  endShape();
  stroke(255,100);
  line(x,y,(160+2*slider),y);
  if(list.size()==300){
    list.remove(0);
  }
  time=time+freq;
}

void mouseDragged(){
  //for n
  if(mouseX>99 && mouseX<551 && mouseY>385 && mouseY<415){
    mouseValue=mouseX;
  }
  //for freq
  if(mouseX>99 && mouseX<551 && mouseY>435 && mouseY<465){
    freqMouseValue=mouseX;
  }
    
}
void mouseClicked(){
  //for n
  if(mouseX>99 && mouseX<551 && mouseY>385 && mouseY<415){
    mouseValue=mouseX;
  }
  //for freq
  if(mouseX>99 && mouseX<551 && mouseY>435 && mouseY<465){
    freqMouseValue=mouseX;
  }
    
}

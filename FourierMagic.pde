DiscreteFourierTrans dft;
ArrayList<PVector> drawingCoordinates= new ArrayList<PVector>();
ArrayList<PVector> temp= new ArrayList<PVector>();
float time=0,dt;
ArrayList<PVector>list =new ArrayList<PVector>(300);
PVector xAxisCycle, yAxisCycle;
int sliderXValue=70, slider=2;
int wheelCount=0;

void setup(){
  size(1100,1000);
  //default drawing can be anything/nothing if you wish to change it.
  float x,y;
  for(int i=0;i<100;i++){
    float angle=map(i,0,99,0,TWO_PI);
    x=250+60*cos(angle);
    y=200+60*sin(angle);
    temp.add(new PVector(x,y));
    drawingCoordinates=temp;
  }
    dft=new DiscreteFourierTrans(drawingCoordinates,slider);
}

void draw(){
  background(20);
  if(wheelCount!=0){
    delay(30);
    recalculate();
  }
  //drawing area
  noStroke();
  fill(160);
  rect(600,600,500,400);
  noFill();
  stroke(0);
  beginShape();
  for(int i=temp.size()-1;i>=0;i--){
    vertex(temp.get(i).x+600,temp.get(i).y+600);
  }
  endShape();
  textSize(18);
  fill(160);
  text("Click inside to make the drawing area empty  ",600,585);
  fill(0);
  text("Coordinates used to draw: "+String.valueOf(drawingCoordinates.size()*2),605,985);//multiplying by 2 since we skip every other coordinate
  
  //slider for k y=750 x=100
  strokeWeight(6);
  stroke(255,100);
  line(70,950,550,950);
  stroke(255);
  line(70,950,sliderXValue,950);
  
  textSize(18);
  fill(160);
  text(String.valueOf(slider-1)+" Complex numbers",sliderXValue-5,940);
  text(String.valueOf((int)((1.0-((slider-1.0)/(2*drawingCoordinates.size())))*100))+"% Compression",sliderXValue-5,920);
  text("Scroll to use the slider",70,975);
  textSize(25);
  text("k",40,957);
  
  
  
  strokeWeight(1);
  if(dft!=null && drawingCoordinates.size()>0){
    float xd=drawEpocs(300,750,dft.X,'x').x;
    float yd=drawEpocs(800,280,dft.Y,'y').y;
    list.add(new PVector(xd,yd));
    stroke(255,100);
    line(xd,yd,xAxisCycle.x,xAxisCycle.y);
    line(xd,yd,yAxisCycle.x,yAxisCycle.y);
    fill(255);
    ellipse(xd,yd,5,5);
    
    //Displaying the approximate drawing on the top left corner of the screen.
    beginShape();
    noFill();
    for(int i=0;i<list.size();i++){
      vertex(list.get(i).x,list.get(i).y);
    }
    endShape();
    
    //printing original drawing
    beginShape();
    fill(255,7);
    stroke(255,30);
    for(int i=0;i<drawingCoordinates.size();i++){
      vertex(drawingCoordinates.get(i).x+list.get(0).x-drawingCoordinates.get(0).x,drawingCoordinates.get(i).y+list.get(0).y-drawingCoordinates.get(0).y);
    }
    endShape();
    
    time+=dt;
    if(time>=TWO_PI){
      time=0;
      list=new ArrayList<PVector>();}
    
  }
  
  if(list.size()==2000){
    list.remove(0);
  } 
}

//function that draws circle epocs.
PVector drawEpocs(float x, float y, pack Y,char s){
  float phy=0.0;
  if(s=='y'){phy=HALF_PI;}
  int t=1;// by defautl t and g should not exist but for the sake of the display in the application they are added;
  float g=2;
  dt=TWO_PI/(drawingCoordinates.size());
  if(slider>=drawingCoordinates.size()){t=2;g=1;}
  for(int i=t;i<slider;i++)
    {
      float prex=x;
      float prey=y;
      float frequency=Y.epoch[i].freq;
      float radius=Y.epoch[i].amplitude;
      float phase=Y.epoch[i].phase;
      x+=radius*g*cos(frequency*time+phase+phy);
      y+=radius*g*sin(frequency*time+phase+phy);
      
      stroke(255,100);
      //noFill();
      fill(255,20);
      ellipse(prex,prey,radius*2*g,radius*2*g);
      stroke(255);
      line(prex,prey,x,y);
    }
    if(s=='y'){
      yAxisCycle=new PVector(x,y);
    }
    else
    {
      xAxisCycle=new PVector(x,y);
    }
    return new PVector(x,y);
    
}
void mouseDragged(){
  //Drawing board
  if(mouseX>600 && mouseY>600){
    temp.add(new PVector(mouseX-600,mouseY-600));
    
  }
    
}
void mouseClicked(){
  //Drawing board
  if(mouseX>600 && mouseY>600){
    drawingCoordinates=new ArrayList<PVector>();
    temp=new ArrayList<PVector>();
    sliderXValue=70;
    slider=2;
  }
    
}
void mouseReleased(){
  //Drawing board
  if(mouseX>600 && mouseY>600){
    drawingCoordinates.add(temp.get(0));
    for(int i=2;i<temp.size();i+=2)
    {
      drawingCoordinates.add(temp.get(i));
      temp.remove(i-1);
    }
    list=new ArrayList<PVector>(300);
    if(drawingCoordinates.size()%2==1){drawingCoordinates.remove(0);}
  }
  
}

void mouseWheel(MouseEvent e){
    int f=e.getCount();
    if(slider==2 && f==-1){}
    else if(slider-1==drawingCoordinates.size() && f==1){}
    else{wheelCount+=f;}
}

void recalculate(){
  int f=wheelCount;
  //println(f);
  int m=int(map(drawingCoordinates.size(),0,1000,1,10));
  f=f*m;
  sliderXValue+=f;
  if(sliderXValue<=70)
  {
    sliderXValue=70;
  }
  if(sliderXValue>=550){
    sliderXValue=550;
  }

  slider=int(map(sliderXValue,70,550,2,drawingCoordinates.size()+1));
  list=new ArrayList<PVector>(300);
  dft=new DiscreteFourierTrans(drawingCoordinates,slider);
  time=0;
  wheelCount=0;
}

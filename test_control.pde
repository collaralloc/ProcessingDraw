import controlP5.*;

ControlP5 cp5;
ContrMode cm;
String[] txtNames= {"stroke1", "fill2", "weight3", "for4", "tf5"};//name not same
String[] btnNames= {"move","Line","Rect","ellipse","circle","arc","beizer","quad"};
Button btn;
Textfield txtCpic;
int mode=0;

void setup() {
  size(800,950);

  PFont font = createFont("arial",14);
  cm = new ContrMode();
  cp5 = new ControlP5(this);
  cp5.addColorWheel("cPic" , 20 , 20 , 100 ).setRGB(color(128,0,255));
  int x = 140;
  int spacing = 65;
  for(String name: txtNames){
    cp5.addTextfield(name)
       .setPosition(x,20)
       .setSize(60,20)
       .setFont(font)
       .setAutoClear(false)
       .setColor(color(255,255,0))
       ;
     x += spacing;
  }

  //textFont(font);
  for (int i=0;i<btnNames.length;i++){
    cp5.addButton(btnNames[i]).setValue(i)
    .setPosition(20,155+i*25)
    .setSize(100,20);
  }
  cp5.addButton("noFill").setValue(11)
    .setPosition(20,455).setSize(100,20);
  cp5.addButton("noStroke").setValue(12)
    .setPosition(20,480).setSize(100,20);
  mode=0;
  cp5.addButton("Undo").setValue(13)
    .setPosition(400,100).setSize(100,25);
}
float px=-1,py=-1,nx=-1,ny=-1;
int cPic =color(100);
void draw() {
  background(25);
  
  cm.show();
  if (px>0 && nx<0) {
    switch(mode){
    case 1:
      line(px,py,mouseX,mouseY); break;
    case 2:
      rect(px,py,mouseX-px,mouseY-py);break;
    case 3:
      ellipseMode(CORNER);
      ellipse(px,py,mouseX-px,mouseY-py);break;
    case 4:
      ellipseMode(CENTER);
      float r=sqrt((mouseX-px)*(mouseX-px)+(mouseY-py)*(mouseY-py));
      r*=2;
      ellipse(px,py,r,r);
    }
  }
  
}
void mousePressed(){
  px=mouseX; py=mouseY;
}
void mouseReleased(){
  nx=mouseX; ny=mouseY;
  println(px,py,nx,ny);
  float[] d={px,py,nx,ny};
  cm.insertOpt(mode,4,d);
  px=-1; nx=-1;
  
}
void setState(String name,String val){
  int m=0;
  float value=0;
  if (val.equals("")) value=cPic;
  else {
    value=Float.valueOf(val);
  }
  if (name.equals("stroke1")){
    m=-1;
  }else if (name.equals("fill2")){
    m=-2;
  }else if (name.equals("weight3")) m=-3;
  float[] d={value};
  cm.insertOpt(m,1,d);
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    
    String name=theEvent.getName();
    String val=theEvent.getStringValue();
    setState(name,val);
  }
  else if (theEvent.isAssignableFrom(Button.class)){
	  //println("button"+theEvent.getName()+":"+theEvent.getValue());
    int val=(int)theEvent.getValue();
    if (mode==val){
      mode=0; //save
      //px=mouseX;
    }
    else if (val<10) mode=val;
    else cm.insertOpt(val,0,null);
  }
}
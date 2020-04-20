import java.util.*;
public class ContrMode{
  final String[] dopt={"line","rect","ellipseMode(CORNER);ellipse","ellipseMode(CENTER);ellipse"};
  
  Stack<Data> dl=new Stack<Data>();
  
  int mode=0;
  int x0=140,y0=140,lx=586,ly=801;
  public void run(int m,float[] d){
    if (m==-1) stroke((int)d[0]);
    else if (m==-2) fill((int)d[0]);
    else if (m==-3) strokeWeight(d[0]);
    else if (m==1) line(d[0],d[1],d[2],d[3]);
    else if (m==2) rect(d[0],d[1],d[2],d[3]);
    else if (m==3) {
      ellipseMode(CORNER);
      ellipse(d[0],d[1],d[2],d[3]);
    }
    else if (m==4){
      ellipseMode(CENTER);
      ellipse(d[0],d[1],d[2],d[3]);
    }
    else if (m==11) noFill();
    else if (m==12) noStroke();
  }
  public void insertOpt(int m,int len,float[] d){
    Data da;
    if (m==2||m==3) {
      d[3]-=d[1]; d[2]-=d[0];
    }
    else if (m==4) {
      float r=sqrt((d[3]-d[1])*(d[3]-d[1])+(d[2]-d[0])*(d[2]-d[0]));
      r*=2;
      d[3]=d[2]=r;
      
    }
    if (len>0)da=new Data(m,len,d);
    else da=new Data(m);
    dl.push(da);
    //tr.insert();
  }
  public void show(){
    fill(255);
    rect(x0,y0,lx,ly);
    for (Data da:dl){
      run(da.mode,da.data);
    }
  }
  public void output(String s,float px,float py,float tx,float ty){
    print(s);
    println("("+px+","+py+","+tx+","+ty+",)");
  }
  
}
public class Data{
  public float[] data;
  int len;
  public int mode;
  public Data(int mode,int lenth,float[] d){
    this.mode=mode; this.len=lenth;
    data = new float[len];
    for (int i=0;i<len;i++)data[i]=d[i];
  }
  public Data(int mode){
    this.mode=mode;
  }
}
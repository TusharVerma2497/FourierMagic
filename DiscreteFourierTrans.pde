import java.util.Arrays;
public class DiscreteFourierTrans{
  
  pack X,Y;
  int K;
  
  public DiscreteFourierTrans(ArrayList<PVector> p,int n){
    float x[]=new float[p.size()];
    float y[]=new float[p.size()];
    for(int i=0;i<p.size();i++){
      x[i]=p.get(i).x;
      y[i]=p.get(i).y;
    }
     this.K=n;
     this.X=dft(x);
     Arrays.sort(X.epoch);
     this.Y=dft(y);
     Arrays.sort(Y.epoch);
  }
  
  public pack dft(float[] x){
    int N=x.length;
    pack p=new pack(this.K);
    for(int k=0;k<this.K;k++){
      float re=0;
      float im=0;
      for(int n=0;n<N;n++){
        float phi=(TWO_PI*n*k)/N;
        re+=x[n]*cos(phi);
        im-=x[n]*sin(phi);
      }
      re=re/N;
      im=im/N;
      p.epoch[k]=new epoch();
      p.epoch[k].Xk=new PVector(re,im);
      p.epoch[k].freq=k;
      p.epoch[k].amplitude=sqrt(re*re+im*im);
      p.epoch[k].phase=atan2(im,re);
    }
    return p;
  }
}

class pack{
  epoch epoch[];
  
  public pack(int N){
    this.epoch=new epoch[N];
  }
}
class epoch implements Comparable<epoch>{
  
  PVector Xk;
  float freq,amplitude,phase;
  
  public int compareTo(epoch e){
    return Float.compare(e.amplitude,this.amplitude);
  }
}

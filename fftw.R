library(Rcpp)
require(inline)

plug <- Rcpp:::Rcpp.plugin.maker(include.before = "#include <fftw3.h>",libs ="-lfftw3")
registerPlugin("FFTWconv", plug )

convFFTW <- cxxfunction(
  signature(xIn="numeric"),
  body = '
  using namespace std;
  
  Rcpp::NumericVector x(xIn);
  int N = x.size();
  std::cout<<"N="<<x.size()<<std::endl;
  double dt=0.001;
  
  fftw_complex *in, *out;
  fftw_plan p;
  in = (fftw_complex *) fftw_malloc(sizeof(fftw_complex) * N);
  out= (fftw_complex *) fftw_malloc(sizeof(fftw_complex) * N);
  p = fftw_plan_dft_1d(N,in,out,FFTW_FORWARD,FFTW_ESTIMATE);
  std::cout<<"bb"<<std::endl;
  for(int i = 0;i<N;i++){
  in[i][0] = 10*sin(2*3.14*(double)i/((double)N/2.))+20*sin(2*3.14*(double)i/((double)N/7.));
  in[i][1] = 0;
  }
  
  fftw_execute(p);
  std::cout<<"cc"<<std::endl;
  std::ofstream fout("data.csv");
  fout<<"サンプル番号"<<","<<"入力信号"<<","<<"周波数[Hz]"<<","<<"振幅"<<","<<std::endl;
  for(int i = 0;i<N;i++){
  fout<<i<<","<<in[i][0]<<","<<(double)i/((double)N*dt)<<","<<sqrt(out[i][0]*out[i][0]+out[i][1]*out[i][1])/((double)N/2.)<<","<<std::endl;
  }
  fout.close();
  
  fftw_destroy_plan(p);
  fftw_free(in);
  fftw_free(out);

  return x;
  ', 
  includes="#include <fstream>",
  plugin="FFTWconv")

convolve_fftw=function(x){
  return(convFFTW(x))
}
library(Rcpp)
require(inline)

plug <- Rcpp:::Rcpp.plugin.maker(include.before = "#include </home/suzuki/tensorflow/tensorflow/loader/loader.h>",libs ="-L/home/suzuki/tensorflow/bazel-bin/tensorflow/loader -lloader")
registerPlugin("loader", plug )

helloworld<- cxxfunction(
  signature(xIn="numeric"),
  body <- '
  using namespace std;
  sample();
  return xIn;
   ', 
  plugin="hello")
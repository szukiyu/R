library(Rcpp)
require(inline)

plug <- Rcpp:::Rcpp.plugin.maker(include.before = "#include </home/suzuki/src/hello/hello.h>",libs ="-L/home/suzuki/src/hello -lhello")
registerPlugin("hello", plug )

helloworld<- cxxfunction(
  signature(xIn="numeric"),
  body <- '
  using namespace std;
  hello("world !");
  return xIn;
   ', 
  plugin="hello")
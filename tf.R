
library(Rcpp)
Sys.setenv("PKG_CXXFLAGS"="-std=c++11 -I/home/suzuki/tensorflow/ -I/home/suzuki/tensorflow/bazel-tensorflow/external/eigen_archive/ -I/home/suzuki/tensorflow/bazel-tensorflow/external/eigen_archive/eigen-eigen-f3a13643ac1f/ -I/home/suzuki/tensorflow/bazel-genfiles/ -I/home/suzuki/tensorflow/bazel-tensorflow/external/protobuf/src/")

require(inline)

plug <- Rcpp:::Rcpp.plugin.maker(include.before = "#include <tensorflow/loader/loader.h>"
                                 ,libs = paste("-L/home/suzuki/tensorflow/bazel-bin/tensorflow/loader -lloader", 
                                               "-L/home/suzuki/temp -ltensorflow"))
registerPlugin("loader", plug )

helloworld<- cxxfunction(
  signature(xIn="numeric"),
  body <- '
  abc();	

  return xIn;
   ', 
  plugin="loader")

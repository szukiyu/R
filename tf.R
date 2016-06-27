library(Rcpp)
require(inline)

plug <- Rcpp:::Rcpp.plugin.maker(include.before = "#include </home/suzuki/tensorflow/tensorflow/loader/loader.h>",libs ="-L/home/suzuki/tensorflow/bazel-bin/tensorflow/loader -lloader")
registerPlugin("loader", plug )

helloworld<- cxxfunction(
  signature(xIn="numeric"),
  body <- '
  
  
  #include <fstream> 
  #include <iostream>
  #include <iomanip>
  #include <sstream>
  #include <string>
  #include <vector>
  #include <iterator>
  #include <memory>
  #include <stdio.h>
 

  using namespace tensorflow;
  
  int b_size = 15; // number of minibatch                                                                 
  int n_step = 16; // size of minibatch                                                                   

  std::vector<std::vector<double> > X_test_norm;
  std::vector<double> y_test_norm;
  load_dataset("/home/suzuki/LSTM_tsc-master/data/TEST_batch2000", X_test_norm, y_test_norm);
  
  // Initialize a tensorflow session                                                                      
  Session* session;
  Status status = NewSession(SessionOptions(), &session);
  if (!status.ok()) {
    std::cout < < status.ToString() < < std::endl;
    return 1;
  }

  // Read in the protobuf graph we exported                                                               
  GraphDef graph_def;
  status = ReadBinaryProto(Env::Default(), "/home/suzuki/LSTM_tsc-master/models/output_graph.pb", &graph_def);
  if (!status.ok()) {
    std::cout < < status.ToString() < < std::endl;
    return 1;
  }


  return xIn;
   ', 
  includes=c("#include <vector>", '#include "tensorflow/core/public/session.h" ',  '#include "tensorflow/core/platform/env."'),
  plugin="loader")
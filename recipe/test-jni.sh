#!/bin/bash

set -e

if [[ ! -d $JAVA_LD_LIBRARY_PATH ]]; then
  echo "Did you remember to activate the conda environment?"
  exit 1
fi
os=$(uname -s | tr '[:upper:]' '[:lower:]')

${CC}                                 \
  -I${JAVA_HOME}/include              \
  -I${JAVA_HOME}/include/$os          \
  -L${JAVA_LD_LIBRARY_PATH}           \
  -Wl,-rpath,${JAVA_LD_LIBRARY_PATH}  \
  -ljvm                               \
  -o vmtest                           \
  test-jni/vmtest.c
	
./vmtest

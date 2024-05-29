#!/bin/bash
mypwd=$(pwd)
trap '{ ruby ./whattodocheriefm.rb; exit 1; }' INT
ruby ./whattodofirstcheriefm.rb "$1";

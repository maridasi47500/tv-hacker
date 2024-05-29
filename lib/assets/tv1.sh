#!/bin/bash
mypwd=$(pwd)
trap '{ cd $mypwd & ruby ./cheriefm.rb; }' EXIT
trap '{ ruby ./cheriefm.rb; exit 1; }' INT
ruby ./cheriefm.rb;

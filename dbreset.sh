#!/bin/bash

echo "Reseting database ..........."

rake db:reset
rake db:populate
rake db:test:prepare

echo "Reseting database ..................... done"
#!/bin/bash

echo "Generating /home/tronco/Desktop/Carryvent/web/doc/models_complete.svg"
railroady -lamM | sed -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g' | dot -Tsvg > /home/tronco/Desktop/Carryvent/web/doc/models_complete.svg

echo "Generating /home/tronco/Desktop/Carryvent/web/doc/models_brief.svg"}
railroady -blamM | sed -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g' | dot -Tsvg > /home/tronco/Desktop/Carryvent/web/doc/models_brief.svg

echo "Generating /home/tronco/Desktop/Carryvent/web/doc/controllers_complete.svg"
railroady -lC | sed -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g' | neato -Tsvg > /home/tronco/Desktop/Carryvent/web/doc/controllers_complete.svg

echo "Generating /home/tronco/Desktop/Carryvent/web/doc/controllers_brief.svg"
railroady -bilC | sed -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g' | neato -Tsvg > /home/tronco/Desktop/Carryvent/web/doc/controllers_brief.svg

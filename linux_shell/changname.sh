#!/bin/bash
for file in *; do
    mv "$file" "${file}.sh"
done
exit 0
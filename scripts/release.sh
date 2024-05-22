#!/usr/bin/env sh
# This script is used to create zip file for github Releases

rm whuthesis.zip
mkdir whuthesis
cp whu-thesis.cls whuthesis
cp whuthesis.pdf whuthesis
cp demo.tex whuthesis
cp demo.pdf whuthesis
cp -R pages whuthesis
cp -R logo whuthesis
cp -R ref whuthesis
cp -R spine whuthesis
cp -R module whuthesis
zip -r whuthesis.zip whuthesis
rm -R whuthesis
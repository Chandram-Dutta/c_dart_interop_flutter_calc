# Dart C Interop Based Flutter Calculator

This is a simple calculator app that uses the Dart C Interop to call a C library. The calculator is implemented in C and compiled to a dynamic library. The library is then loaded into the Dart VM and called from Dart code. Works on macOS. Dunno about other platforms, but could be done by natively compiling the C code for each platform. Read more about the Dart C Interop [here](https://dart.dev/guides/libraries/c-interop).

## Why?

Well recently I got an opportunity to work on a research project in my University where we have to develop a Electric Meter Montitoring System. The code(both UI & backend) was implemented in Python which was making it difficult to grow the project leading to immense technical debt. We had the C Code to extract the value from the meters(which I am calling the backend code) and now Dart C Interop gave me idea to implement the UI in Flutter. This is my first attempt to implement the C Code in Flutter, and its promising.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

import 'dart:io';

void decToBin(int num) {
  if (num > 0) {
    decToBin(num ~/ 2);
    stdout.write('${num % 2}');
  }
}

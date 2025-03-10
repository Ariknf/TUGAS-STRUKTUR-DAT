bool search(List<int> x, int size, int n) {
  if (size > 0) {
    if (x[size - 1] == n) {
      return true;
    } else {
      return search(x, size - 1, n);
    }
  }
  return false;
}

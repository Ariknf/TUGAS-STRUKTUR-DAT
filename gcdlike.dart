bool gcdlikeTail(int p, int q, bool result) {
  if (q == 0) {
    return (p == 1) && result;
  }
  return gcdlikeTail(q, p % q, result);
}

bool gcdlike(int p, int q) {
  return gcdlikeTail(p, q, true);
}

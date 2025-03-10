bool binarySearch(List<int> x, int start, int end, int n) {
 if (end < start) return false;
 int mid = (start + end) ~/ 2;
 if (x[mid] == n) {
 return true;
 } else {
 if (x[mid] < n) {
 return binarySearch(x, mid + 1, end, n);
 } else {
 return binarySearch(x, start, mid - 1, n);
 }
 }
}
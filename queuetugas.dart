import 'dart:io'; 

// Class Node sebagai dasar struktur tree
class Node<T> {
  T nodeValue; // Nilai/data yang disimpan dalam node
  Node<T>? left, right; // Pointer ke anak kiri dan kanan (bisa null)

  Node(this.nodeValue); // construktor untk membuat node baru dengan nilai tertentu
}

// Class utama untuk operasi Binary Tree
class BinaryTree<T> {
  Node<T>? root; // Node paling atas/puncak tree, yg awalannya kosong

  // [Method 1] Menambahkan node secara level order (tingkat demi tingkat) dengan rekursi
  void insertLevelOrderRecursive(T value) {
    Node<T> newNode = Node(value); // Buat node baru
    if (root == null) {
      // Jika tree kosong
      root = newNode; // Jadikan node baru sebagai root
    } else {
      _insertRecursiveHelper(root!, newNode); // Bantu cari posisi kosong
    }
  }

  // Helper untuk method di atas (pencarian posisi kosong secara rekursif)
  bool _insertRecursiveHelper(Node<T> current, Node<T> newNode) {
    // Cek anak kiri kosong
    if (current.left == null) {
      current.left = newNode;
      return true; // Berhasil insert
    }
    // Cek anak kanan kosong
    else if (current.right == null) {
      current.right = newNode;
      return true; // Berhasil insert
    }

    // Jika kedua anak terisi, coba insert ke subtree kiri terlebih dahulu
    if (_insertRecursiveHelper(current.left!, newNode)) return true;
    // Jika gagal di kiri, coba subtree kanan
    return _insertRecursiveHelper(current.right!, newNode);
  }

  // [Method 2] Menambahkan node level order menggunakan antrian (queue)
  void insertLevelOrderQueue(T value) {
    Node<T> newNode = Node(value);
    if (root == null) {
      root = newNode;
      return;
    }

    List<Node<T>> queue = [root!]; // Antrian berisi root

    while (queue.isNotEmpty) {
      Node<T> current = queue.removeAt(0); // Ambil node depan antrian

      // Cek anak kiri
      if (current.left == null) {
        current.left = newNode;
        break; // Keluar setelah insert
      } else {
        queue.add(current.left!); // Masukkan anak kiri ke antrian
      }

      // Cek anak kanan
      if (current.right == null) {
        current.right = newNode;
        break; // Keluar setelah insert
      } else {
        queue.add(current.right!); // Masukkan anak kanan ke antrian
      }
    }
  }

  // [Method 3] Menambahkan node baru sebagai anak dari node tertentu (target)
  bool insertByTarget(T target, T newValue) {
    if (root == null) return false; // Tree kosong
    List<Node<T>> queue = [root!]; // Antrian berisi root

    while (queue.isNotEmpty) {
      Node<T> current = queue.removeAt(0); // Ambil node depan antrian

      // Jika menemukan target
      if (current.nodeValue == target) {
        // Tambahkan di anak kiri jika kosong
        if (current.left == null) {
          current.left = Node(newValue);
          return true;
        }
        // Tambahkan di anak kanan jika kosong
        else if (current.right == null) {
          current.right = Node(newValue);
          return true;
        } else {
          print("Node $target sudah punya 2 anak");
          return false;
        }
      }

      // Tambahkan anak kiri/kanan ke antrian untuk dicek
      if (current.left != null) queue.add(current.left!);
      if (current.right != null) queue.add(current.right!);
    }
    return false; // Target tidak ditemukan
  }

  // [Traversal 1] Cetak node secara InOrder (kiri -> node -> kanan) tanpa rekursi
  void inOrderNonRecursive() {
    List<Node<T>> stack = []; // Tumpukan untuk simulasi rekursi
    Node<T>? current = root; // Mulai dari root

    while (current != null || stack.isNotEmpty) {
      // Turun ke anak kiri paling bawah
      while (current != null) {
        stack.add(current);
        current = current.left;
      }

      // Naik ke node parent
      current = stack.removeLast();
      stdout.write("${current.nodeValue} "); // Cetak nilai
      current = current.right; // Geser ke kanan
    }
    print(""); // Pindah baris
  }

  // [Traversal 2] Cetak node secara PreOrder (node -> kiri -> kanan) tanpa rekursi
  void preOrderNonRecursive() {
    if (root == null) return;

    List<Node<T>> stack = [root!]; // Mulai dari root

    while (stack.isNotEmpty) {
      Node<T> current = stack.removeLast(); // Ambil dari tumpukan
      stdout.write("${current.nodeValue} "); // Cetak nilai dulu

      // Masukkan kanan dulu agar kiri diproses lebih dulu
      if (current.right != null) stack.add(current.right!);
      if (current.left != null) stack.add(current.left!);
    }
    print("");
  }

  // [Traversal 3] Cetak node secara PostOrder (kiri -> kanan -> node) tnpa rekursi
  void postOrderNonRecursive() {
    if (root == null) return;

    List<Node<T>> stack1 = [root!]; // Stack untuk proses
    List<Node<T>> stack2 = []; // Stack untuk hasil akhir

    while (stack1.isNotEmpty) {
      Node<T> current = stack1.removeLast();
      stack2.add(current); // Simpan node ke stack2

      // Masukkan anak kiri terlebih dahulu, agar kanan dapt di proses lebih dulu
      if (current.left != null) stack1.add(current.left!);
      if (current.right != null) stack1.add(current.right!);
    }

    // Cetak isi stack2 dari belakang (urutan sebenarnya)
    while (stack2.isNotEmpty) {
      stdout.write("${stack2.removeLast().nodeValue} ");
    }
    print("");
  }
}

void main() {
  BinaryTree<int> tree = BinaryTree(); // Buat tree dengan tipe integer

  // Contoh penggunaan:
  tree.insertLevelOrderQueue(1); // Root
  tree.insertLevelOrderQueue(2); // Anak kiri root
  tree.insertLevelOrderQueue(3); // Anak kanan root
  tree.insertLevelOrderQueue(4); // Anak kiri dari 2
  tree.insertLevelOrderQueue(5); // Anak kanan dari 2

  // Tambahkan node 6 dan 7 sebagai anak dari node 3
  tree.insertByTarget(3, 6);
  tree.insertByTarget(3, 7);

  // Cetak tree dengan 3 cara berbeda:
  print("InOrder (Kiri-Node-Kanan):");
  tree.inOrderNonRecursive(); 

  print("PreOrder (Node-Kiri-Kanan):");
  tree.preOrderNonRecursive(); 

  print("PostOrder (Kiri-Kanan-Node):");
  tree.postOrderNonRecursive(); 
}

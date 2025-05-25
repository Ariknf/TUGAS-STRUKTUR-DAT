// Mendefinisikan kelas Node
class Node {
  // Properti data untuk menyimpan nilai dalam node, bertipe int
  int data;
  // Properti next untuk menyimpan referensi (pointer) ke node berikutnya 
  Node? next;

  // Konstruktor untuk menginisialisasi data dan node berikutnya (default-nya null)
  Node(this.data, [this.next]);
}

// Kelas LinkedList untuk mengelola operasi-operasi pada linked list
class LinkedList {
  // Properti head untuk menyimpan referensi ke node pertama dalam linked list
  Node? head;

  // Fungsi findNode untuk mencari node berdasarkan nilai data
  Node? findNode(int data) {
    // Variabel current yang akan digunakan untuk menelusuri linked list, dimulai dari node pertama (head)
    Node? current = head;

    // Selama current bukan null (artinya kita masih berada dalam linked list)
    while (current != null) {
      // Mengecek apakah data dalam node saat ini sesuai dengan data yang dicari
      if (current.data == data) {
        // Jika ditemukan, kembalikan node tersebut
        return current;
      }
      // Jika belum ditemukan, pindah ke node berikutnya dengan mengikuti pointer next
      current = current.next;
    }

    // Jika kita sudah menelusuri seluruh linked list dan tidak menemukan data, kembalikan null
    return null;
  }

  // Fungsi append untuk menambahkan node baru di akhir linked list
  void append(int data) {
    // Jika linked list masih kosong (head adalah null)
    if (head == null) {
      // Buat node baru sebagai head (node pertama) dengan data yang diberikan
      head = Node(data);
    } else {
      // Jika linked list sudah ada, kita akan mencari node terakhir
      Node? current = head;
      // Menelusuri hingga menemukan node yang tidak memiliki next (artinya node terakhir)
      while (current!.next != null) {
        current = current.next;
      }
      // Menambahkan node baru sebagai next dari node terakhir
      current.next = Node(data);
    }
  }
}

// Fungsi utama untuk menguji Linked List
void main() {
  // Membuat instance dari LinkedList
  LinkedList list = LinkedList();
  // Menambahkan beberapa node dengan data 10, 20, dan 30
  list.append(10);
  list.append(20);
  list.append(30);

  // Mencari node yang memiliki data 20
  Node? node = list.findNode(20);

  // Mengecek apakah node ditemukan
  if (node != null) {
    // Jika ditemukan, tampilkan data dari node tersebut
    print('Node ditemukan dengan data: ${node.data}');
  } else {
    // Jika tidak ditemukan, tampilkan pesan ini
    print('Node tidak ditemukan');
  }
}

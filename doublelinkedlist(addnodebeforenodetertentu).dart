// Kelas node dalam double linked list, bersifat generic <T> agar bisa menyimpan tipe data apa pun (int, String, dll)
class DNode<T> {
  T data; // Menyimpan data pada node
  DNode<T>?
      prev; // Menyimpan referensi ke node sebelumnya (bisa null jika ini adalah node pertama)
  DNode<T>?
      next; // Menyimpan referensi ke node berikutnya (bisa null jika ini adalah node terakhir)

  // Konstruktor untuk membuat node baru, menerima nilai data, dan opsional prev/next
  DNode(this.data, {this.prev, this.next});
}

// Kelas DoubleLinkedList untuk menyimpan dan mengelola daftar double linked list
class DoubleLinkedList<T> {
  DNode<T>? head; // Menunjuk ke node pertama dalam list
  DNode<T>? tail; // Menunjuk ke node terakhir dalam list

  // Method untuk menambahkan node baru sebelum node target
  void tambahNode_Sebelum(DNode<T> newNode, DNode<T> target) {
    // Jika target adalah head (node pertama)
    if (target == head) {
      // newNode menjadi head yang baru
      newNode.next = target; // Arahkan next dari newNode ke target
      newNode.prev = null; // Karena dia akan jadi node pertama, prev-nya null
      target.prev = newNode; // Arahkan prev dari target ke newNode
      head = newNode; // Jadikan newNode sebagai head baru
    } else {
      // Jika target bukan head (ada node sebelumnya)
      DNode<T>? prevNode = target.prev; // Ambil node sebelum target

      newNode.next = target; // newNode mengarah ke target sebagai next
      newNode.prev = prevNode; // newNode mengarah ke prevNode sebagai prev
      prevNode?.next = newNode; // prevNode sekarang mengarah ke newNode
      target.prev = newNode; // target sekarang menunjuk balik ke newNode
    }
  }

  // Method tambahan: menambahkan node di akhir list (agar bisa uji coba dengan mudah)
  void tambahDiAkhir(T data) {
    DNode<T> newNode = DNode(data);

    if (head == null) {
      // Jika list kosong, maka newNode menjadi head dan tail
      head = tail = newNode;
    } else {
      // Jika list tidak kosong, tambahkan di akhir
      tail!.next = newNode; // tail lama menunjuk ke newNode
      newNode.prev = tail; // newNode menunjuk ke tail lama
      tail = newNode; // perbarui tail menjadi newNode
    }
  }

  // Menampilkan isi list dari depan ke belakang (maju)
  void tampilMaju() {
    DNode<T>? current = head;
    while (current != null) {
      print(current.data); // Cetak data pada node saat ini
      current = current.next; // Lanjut ke node berikutnya
    }
  }
}

void main() {
  // Buat objek DoubleLinkedList untuk menyimpan angka
  DoubleLinkedList<int> list = DoubleLinkedList<int>();

  // Tambahkan beberapa node awal
  list.tambahDiAkhir(10);
  list.tambahDiAkhir(30);

  // Kita akan menyisipkan node baru (20) sebelum node dengan data 30
  DNode<int> nodeBaru = DNode(20);
  DNode<int>? target =
      list.head?.next; // Ambil node dengan data 30 (node kedua)

  // Jalankan fungsi untuk menyisipkan nodeBaru sebelum target
  if (target != null) {
    list.tambahNode_Sebelum(nodeBaru, target);
  }

  list.tampilMaju();
}

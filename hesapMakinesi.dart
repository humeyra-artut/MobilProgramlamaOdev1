import 'dart:io';

void main() {
  print("Lütfen yapmak istediğiniz işlemi seçin:");
  print("1. Toplama");
  print("2. Çıkarma");
  print("3. Çarpma");
  print("4. Bölme");

  int secim = int.parse(stdin.readLineSync()!);

  print("İlk sayıyı girin:");
  double sayi1 = double.parse(stdin.readLineSync()!);

  print("İkinci sayıyı girin:");
  double sayi2 = double.parse(stdin.readLineSync()!);

  double? sonuc; // null değer alabilmesi için değişkeni nullable yapıyoruz.

  switch (secim) {
    case 1:
      sonuc = sayi1 + sayi2;
      break;
    case 2:
      sonuc = sayi1 - sayi2;
      break;
    case 3:
      sonuc = sayi1 * sayi2;
      break;
    case 4:
      if (sayi2 == 0) {
        print("Hata: Bir sayıyı sıfıra bölemezsiniz.");
        return; // Hata durumunda işlemi sonlandırıyoruz.
      } else {
        sonuc = sayi1 / sayi2;
      }
      break;
    default:
      print("Geçersiz bir seçim yaptınız.");
      return; // Hatalı seçim durumunda işlemi sonlandırıyoruz.
  }

  print("Sonuç: $sonuc");
}

import 'dart:io';
import 'dart:convert';

class Ogrenci {
  String ad;
  String soyad;
  int numara;
  List<double> notlar = [];

  Ogrenci(this.ad, this.soyad, this.numara);

  double hesaplaOrtalama() {
    if (notlar.isEmpty) {
      return 0;
    }
    return notlar.reduce((a, b) => a + b) / notlar.length;
  }

  // JSON'dan Ogrenci nesnesi oluşturma
  Ogrenci.fromJson(Map<String, dynamic> json)
      : ad = json['ad'],
        soyad = json['soyad'],
        numara = json['numara'],
        notlar = List<double>.from(json['notlar']);

  // Ogrenci nesnesini JSON formatına çevirme
  Map<String, dynamic> toJson() => {
        'ad': ad,
        'soyad': soyad,
        'numara': numara,
        'notlar': notlar,
      };
}

List<Ogrenci> ogrenciler = [];

void main() {
  // Verileri dosyadan okuma (varsa)
  okuVerileri();

  while (true) {
    print("1. Öğrenci Ekle");
    print("2. Not Ekle");
    print("3. Öğrenci Bilgilerini Görüntüle");
    print("4. Verileri Kaydet");
    print("5. Çıkış");

    int secim = int.parse(stdin.readLineSync()!);

    switch (secim) {
      case 1:
        ogrenciEkle();
        break;
      case 2:
        notEkle();
        break;
      case 3:
        ogrenciBilgileriniGoster();
        break;
      case 4:
        kaydetVerileri();
        break;
      case 5:
        exit(0);
      default:
        print("Geçersiz seçim.");
    }
  }
}

void ogrenciEkle() {
  print("Öğrenci Adı:");
  String ad = stdin.readLineSync()!;
  print("Öğrenci Soyadı:");
  String soyad = stdin.readLineSync()!;
  print("Öğrenci Numara:");
  int numara = int.parse(stdin.readLineSync()!);

  Ogrenci yeniOgrenci = Ogrenci(ad, soyad, numara);
  ogrenciler.add(yeniOgrenci);
  print("Öğrenci başarıyla eklendi.");
}

void notEkle() {
  print("Not eklenecek öğrencinin numarasını girin:");
  int numara = int.parse(stdin.readLineSync()!);

  Ogrenci? ogrenci = ogrenciler.firstWhere((o) => o.numara == numara, orElse: () => Ogrenci("", "", 0));

  if (ogrenci.numara == 0) {
    print("Böyle bir öğrenci bulunamadı.");
  } else {
    print("Notu girin:");
    double not = double.parse(stdin.readLineSync()!);
    ogrenci.notlar.add(not);
    print("Not başarıyla eklendi.");
  }
}

void ogrenciBilgileriniGoster() {
  if (ogrenciler.isEmpty) {
    print("Henüz öğrenci eklenmemiş.");
  } else {
    for (Ogrenci ogrenci in ogrenciler) {
      print("Adı Soyadı: ${ogrenci.ad} ${ogrenci.soyad}");
      print("Numara: ${ogrenci.numara}");
      print("Not Ortalaması: ${ogrenci.hesaplaOrtalama()}");
      print("Notlar: ${ogrenci.notlar}");
      print("--------------------");
    }
  }
}

void kaydetVerileri() {
  // Öğrenci listesini JSON formatında bir dosyaya yazma
  String jsonVeri = jsonEncode(ogrenciler.map((e) => e.toJson()).toList());
  File('ogrenciler.json').writeAsStringSync(jsonVeri);
  print("Veriler başarıyla kaydedildi.");
}

void okuVerileri() {
  // Öğrenci verilerini JSON dosyasından okuma (varsa)
  try {
    String jsonVeri = File('ogrenciler.json').readAsStringSync();
    List<dynamic> jsonList = jsonDecode(jsonVeri);
    ogrenciler = jsonList.map((e) => Ogrenci.fromJson(e)).toList();
  } catch (e) {
    print("Veri dosyası bulunamadı veya okunamadı.");
  }
}


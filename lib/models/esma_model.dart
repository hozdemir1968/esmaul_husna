import 'package:flutter/services.dart';

class EsmaModel {
  int id;
  String isim;
  String detay;
  String isimeng;
  String detayeng;
  Uint8List resim;

  EsmaModel(this.id, this.isim, this.detay, this.isimeng, this.detayeng, this.resim);
}

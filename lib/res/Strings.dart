
import 'package:zwalkowe_pegle/utils/TextUtils.dart';

abstract class Strings {
  static String superScript3 = String.fromCharCode(0x00B3);

  static String dataMissing = "Brak danych";
  static String levelChartId = "Poziom wody [cm]" ;
  static String dischargeChartId = "Przepływ [m$superScript3/s]" ;
  static String appName = "Zwałkowe Pegle";
  static String chooseRegion = "wybierz województwo";

  static String dateOfData(DateTime date) {
    return "Dane z ${TextUtils.formatDate(date)}";
  }

  static var regions = [
    'dolnośląskie',
    'kujawsko-Pomorskie',
    'lubelskie',
    'lubuskie',
    'łódzkie',
    'małopolskie',
    'mazowieckie',
    'opolskie',
    'podkarpackie',
    'podlaskie',
    'pomorskie',
    'śląskie',
    'świętokrzyskie',
    'warmińsko-mazurskie',
    'wielkopolskie',
    'zachodniopomorskie'
  ];

}
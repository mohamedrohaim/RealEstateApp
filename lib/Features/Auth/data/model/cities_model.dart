class Cities {
  List<String>? alexandria;
  List<String>? aswan;
  List<String>? asyut;
  List<String>? beheira;
  List<String>? beniSuef;
  List<String>? cairo;
  List<String>? dakahlia;
  List<String>? damietta;
  List<String>? fayoum;
  List<String>? gharbia;
  List<String>? giza;
  List<String>? ismailia;
  List<String>? kafrAlSheikh;
  List<String>? luxor;
  List<String>? matruh;
  List<String>? minya;
  List<String>? monufia;
  List<String>? newValley;
  List<String>? portSaid;
  List<String>? qalyubia;
  List<String>? qena;
  List<String>? redSea;
  List<String>? sharqia;
  List<String>? sohag;
  List<String>? southSinai;
  List<String>? suez;

  Cities(
      {this.alexandria,
      this.aswan,
      this.asyut,
      this.beheira,
      this.beniSuef,
      this.cairo,
      this.dakahlia,
      this.damietta,
      this.fayoum,
      this.gharbia,
      this.giza,
      this.ismailia,
      this.kafrAlSheikh,
      this.luxor,
      this.matruh,
      this.minya,
      this.monufia,
      this.newValley,
      this.portSaid,
      this.qalyubia,
      this.qena,
      this.redSea,
      this.sharqia,
      this.sohag,
      this.southSinai,
      this.suez});

  Cities.fromJson(Map<String, dynamic> json) {
    alexandria = json['alexandria'].cast<String>();
    aswan = json['aswan'].cast<String>();
    asyut = json['asyut'].cast<String>();
    beheira = json['beheira'].cast<String>();
    beniSuef = json['beni suef'].cast<String>();
    cairo = json['cairo'].cast<String>();
    dakahlia = json['dakahlia'].cast<String>();
    damietta = json['damietta'].cast<String>();
    fayoum = json['fayoum'].cast<String>();
    gharbia = json['gharbia'].cast<String>();
    giza = json['giza'].cast<String>();
    ismailia = json['ismailia'].cast<String>();
    kafrAlSheikh = json['kafr al-sheikh'].cast<String>();
    luxor = json['luxor'].cast<String>();
    matruh = json['matruh'].cast<String>();
    minya = json['minya'].cast<String>();
    monufia = json['monufia'].cast<String>();
    newValley = json['new valley'].cast<String>();
    portSaid = json['port said'].cast<String>();
    qalyubia = json['qalyubia'].cast<String>();
    qena = json['qena'].cast<String>();
    redSea = json['red sea'].cast<String>();
    sharqia = json['sharqia'].cast<String>();
    sohag = json['sohag'].cast<String>();
    southSinai = json['south sinai'].cast<String>();
    suez = json['suez'].cast<String>();
  }
}

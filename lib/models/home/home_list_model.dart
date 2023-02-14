import 'dart:convert';

import 'package:http/http.dart' as http;

class HomeListModel {
  bool? signal;
  MatchedInfo? matchedInfo;
  List<SignalInfo>? signalToMe;
  List<SignalInfo>? signalRequest;

  HomeListModel(
      {this.signal, this.matchedInfo, this.signalToMe, this.signalRequest});

  HomeListModel.fromJson(Map<String, dynamic> json) {
    signal = json['signal'];
    matchedInfo = json['matched_info'] != null
        ? MatchedInfo.fromJson(json['matched_info'])
        : null;
    if (json['signalToMe'] != null) {
      signalToMe = <SignalInfo>[];
      json['signalToMe'].forEach((v) {
        signalToMe!.add(SignalInfo.fromJson(v));
      });
    }
    if (json['signalRequest'] != null) {
      signalRequest = <SignalInfo>[];
      json['signalRequest'].forEach((v) {
        signalRequest!.add(SignalInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['signal'] = signal;
    if (matchedInfo != null) {
      data['matched_info'] = matchedInfo!.toJson();
    }
    if (signalToMe != null) {
      data['signalToMe'] = signalToMe!.map((v) => v.toJson()).toList();
    }
    if (signalRequest != null) {
      data['signalRequest'] = signalRequest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MatchedInfo {
  String? name;
  String? image;
  List<String>? tag;
  int? temperature;
  String? location;

  MatchedInfo(
      {this.name, this.image, this.tag, this.temperature, this.location});

  MatchedInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    tag = json['tag'].cast<String>();
    temperature = json['temperature'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['tag'] = tag;
    data['temperature'] = temperature;
    data['location'] = location;
    return data;
  }
}

class SignalInfo {
  String? image;
  String? name;

  SignalInfo({this.image, this.name});

  SignalInfo.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    return data;
  }
}

Future<HomeListModel> fetchHome() async {
  var url = Uri.parse(
      'https://ac684759-244f-486f-9c52-fd91d013aeed.mock.pstmn.io/home');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return HomeListModel.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load Home Info');
  }
}

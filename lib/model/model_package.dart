import 'dart:convert';

class PackageModel {
  PackageModel({
    required this.name,
    required this.description,
    required this.feature,
    required this.publisher,
    required this.gallery,
    required this.app,
    required this.play,
    required this.web,
  });

  final String name;
  final String description;
  final String feature;
  final String publisher;
  final List<String> gallery;
  final String app;
  final String play;
  final String web;

  PackageModel copyWith({
    String? title,
    String? description,
    String? feature,
    String? publisher,
    List<String>? gallery,
    String? app,
    String? play,
    String? web,
  }) =>
      PackageModel(
        name: title ?? name,
        description: description ?? this.description,
        feature: feature ?? this.feature,
        publisher: publisher ?? this.publisher,
        gallery: gallery ?? this.gallery,
        app: app ?? this.app,
        play: play ?? this.play,
        web: web ?? this.web,
      );

  factory PackageModel.fromJson(String str) =>
      PackageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PackageModel.fromMap(Map<String, dynamic> json) => PackageModel(
        name: json['name'],
        description: json['description'],
        feature: json['feature'],
        publisher: json['publisher'],
        gallery: json['gallery'],
        app: json['app'],
        play: json['play'],
        web: json['web'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'description': description,
        'feature': feature,
        'publisher': publisher,
        'gallery': gallery,
        'app': app,
        'play': play,
        'web': web,
      };

  @override
  String toString() =>
      "PackageModel(name: '$name', description: '$description', feature: '$feature', publisher: '$publisher', gallery: '$gallery', app: '$app', play: '$play', web: '$web')";
}

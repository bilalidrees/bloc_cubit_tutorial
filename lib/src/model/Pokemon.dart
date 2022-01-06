class Pokemon {
  String? name, url;
  bool? isFav;

  Pokemon({this.name, this.url, this.isFav});

  factory Pokemon.fromJson(Map<dynamic, dynamic> json) {
    return Pokemon(
      name: json["name"],
      url: json["url"],
      isFav: false,
    );
  }

  Map<String, dynamic> toJson() => _pokemonToJson(this);

  Map<String, dynamic> _pokemonToJson(Pokemon instance) => <String, dynamic>{
        'name': instance.name,
        'url': instance.url,
        'isFav': instance.isFav,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pokemon &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}

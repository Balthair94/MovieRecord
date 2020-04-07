class Cast {
  List<Actor> actors = List();

  Cast();

  Cast.fromJson(List<dynamic> json) {
    if(json == null) return;

    json.forEach((jsonObject) {
      Actor actor = Actor.fromJson(jsonObject);
      actors.add(actor);
    });
  }
}

class Actor {
  int id;
  String name;
  String profilePath;

  Actor({this.id, this.name, this.profilePath});

  Actor.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    profilePath = json['profile_path'];
  }

  String getProfilePhoto() {
    if(this.profilePath ==  null || this.profilePath == '') {
      return 'assets/no-available-image.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500${this.profilePath}';
    }
  }
}
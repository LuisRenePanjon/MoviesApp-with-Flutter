class Cast {
  List<Actor> actors = [];

  Cast.fromJsonList( List<dynamic> jsonList ){
    if ( jsonList == null ) return;

    jsonList.forEach((element) { 
      final actor = Actor.fromJsonMap(element);
      actors.add(actor);
    });
  }
}


class Actor {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });


  Actor.fromJsonMap( Map<String ,dynamic> json){
    adult         = json[ 'adult' ];
    gender        = json[ 'gender' ];
    id            = json[ 'id' ];
    knownForDepartment = json[ 'known_for_department' ];
    name          = json[ 'name' ];
    originalName  = json[ 'original_name' ];
    popularity    = json[ 'popularity' ];
    profilePath   = json[ 'profile_path' ];
    castId        = json[ 'cast_id' ];
    character     = json[ 'character' ];
    creditId      = json[ 'creditId' ];
    order         = json[ 'order' ];
    department    = json[ 'department' ];
    job           = json[ 'job' ];
  }

  getProfilePicture() {
    if ( profilePath == null){
      return 'https://api-private.atlassian.com/users/aa7543e682dff486562017fe2fedc6c0/avatar';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }

}

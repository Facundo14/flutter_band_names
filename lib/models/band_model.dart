class Band {
  String? id;
  String? name;
  int? votes;

  Band({
    this.id,
    this.name,
    this.votes,
  });

  // Factory tiene como objetivo una nueva instancia de la Clase Band
  factory Band.fromMap(Map<String, dynamic> obj) => Band(
        id: obj.containsKey('id') ? obj['id'] : 'no-id',
        name: obj.containsKey('name') ? obj['name'] : 'no-name',
        votes: obj.containsKey('votes') ? obj['votes'] : 'no-votes',
      );
}

class TeamModel{
String reps;
  String userName;
  String image;
  bool status;

  TeamModel(this.userName,this.image,this.status,this.reps);

  @override
  String toString() {
    return '{ ${this.userName}, ${this.image} ,${this.status},${this.reps} }';
  }
}
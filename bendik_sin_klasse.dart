import 'dart:math';

void main() {
  const emne1 = Emne("dart og flutter osv", "Emne1", 9000);
  const emne2 = Emne("Swift og SwiftUI", "Emne2", 21);
  const emne3 = Emne("Smisking med Læreren", "Emne3", 1);
  
  const nyttStudie = Studie([emne1, emne2, emne3]);
    
  var sasha = Student(nyttStudie, 
                      "Sasha",
                      null,
                      kandidatnummer: 1, 
                      studentnummer: 1);    
  var samakab = Student(nyttStudie, 
                      "Samakab",
                      sasha,
                      kandidatnummer: 2, 
                      studentnummer: 2);
  var dimitrije = Student(nyttStudie, 
                      "Dimitrije",
                      null,
                      kandidatnummer: 3, 
                      studentnummer: 3);
      
  var miriame = Student(nyttStudie, 
                      "Miriame",
                      dimitrije,
                      kandidatnummer: 4, 
                      studentnummer: 5);
  var studenter = [sasha, samakab, dimitrije, miriame];
  
  // bendik sin klasse blir opprettet
  var bendikSinKlasse = BendikSinKlasse(studenter);
  print("bendikSinKlasse er opprettet, med studenter i");

  // en ny student joiner klassen til bendik
  var fabian = Student.minimal(studentnummer: 33, kandidatnummer: 44);
  // dårlig ide: bendikSinKlasse.studenter = fabian;
  bendikSinKlasse.leggTilStudent(fabian);
  print("bendikSinKlasse får besøk av: $fabian");

  // bendik sin klasse blir tildelt et klasserom
  bendikSinKlasse.klasserom = "230";
  print("klasseromet til Bendik er: ${bendikSinKlasse.klasserom}");
  
  // gi fabian et navn
  print("student nummber ${fabian.studentnummer} får et navn");
  fabian.name = "Fabian den store og kule";
  
  // enda en ny student blir med, sen påmelding lol
  var thomas = Student(nyttStudie, 
                      "Thomas",
                      fabian,
                      kandidatnummer: 99, 
                      studentnummer: 99);
  print("""thomas starter på skolen. Han heter: ${thomas.name}
  og han har kandidatnummer: ${thomas.kandidatnummer}
  og han er bestevenner med: ${thomas.bestevenn.name}""");
  
  bendikSinKlasse.leggTilStudent(thomas);
  
  // Dimitrije får en bestevenn (spenning... er det miriame?)
  print("bestevennen til Dimitrije var: ${bendikSinKlasse.studenter[2].bestevenn}");
  dimitrije.bestevenn = miriame;
  print("bestevennen til Dimitrije er nå: ${bendikSinKlasse.studenter[2].bestevenn.name}");
  
  
  // studenter går til eksamen.
  
  // ny student starter mitt i eksamenstiden...
    var sander = Student.minimal(kandidatnummer: 1111, 
                      studentnummer: 1111);   
    bendikSinKlasse.leggTilStudent(sander);

  
  print("\nNå er det på tide med eksamen!\n");
  
  var listeMedResultater = [];
  
  for(int i = 0; i < bendikSinKlasse.studenter.length; i++){
    var eksamensrapport = bendikSinKlasse.studenter[i].name ?? 
              bendikSinKlasse.studenter[i].kandidatnummer.toString() ??
             "fantes ikke noenting her...";
    var karakter = bendikSinKlasse.studenter[i].taEksamen();
    
    eksamensrapport += " ... fikk $karakter i karakter";
    listeMedResultater.add(eksamensrapport);
  }
  
  listeMedResultater.sort();
  
  listeMedResultater.forEach((var resultat) => print(resultat));
  
  // de skrives ut på en liste, så alle kan se, 
  // og beundre de studentene som får god karakter
  
  
  
  
}

class BendikSinKlasse {
  var studenter;
  var stemning;
  var klasserom;
  var bakgrunnsmusikk;
  
  BendikSinKlasse(this.studenter, 
                  [this.stemning, 
                   this.klasserom, 
                   this.bakgrunnsmusikk]);
  
  void leggTilStudent(Student s){
    if (studenter == null){
      studenter = [s];
    } else {
      studenter.add(s);
    }
  }
  
}

class Student {
  var studie;
  var name;
  final kandidatnummer;
  final studentnummer;
  var bestevenn;
  
  // Using a curly brace syntax at the end of the parameter 
  // list, you can define parameters that have names.
  Student(this.studie, this.name, this.bestevenn,
          { required this.kandidatnummer, 
          required this.studentnummer});
  Student.minimal({required this.kandidatnummer, 
                   required this.studentnummer});
  
  String taEksamen() {
    var rng = Random();
    var tall = rng.nextInt(5);
    if (tall == 0){
      return "A";}
    if (tall == 1){
      return "B";}
    if (tall == 2){
      return "C";}
    if (tall == 3){
      return "D";}
    if (tall == 4){
      return "E";}
  
    return "F";
  }  
  String taEksamenMedSwitch() {
    var rng = Random();
    var tall = rng.nextInt(5);
    switch(tall) {
      case 0:
          return("A");
      case 1:
          return("B");
      case 2:
          return("C");
      case 3:
          return("D");
      case 4:
          return("E");
      case 5:
          return("F");
      default:
          return("Ikke Vurdert");
    }
  }
}

class Studie {
  final emner;
  
  const Studie(this.emner);
}

class Emne {
  final pensum;
  final navn;
  final anbefaltTimebruk;
    
  const Emne(this.pensum, this.navn, this.anbefaltTimebruk);
}

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'src/water_service.dart';

@Component(
  // Ce composant sera introduit par  <cats-app>
  selector: 'cats-app',
  // Le modèle HTML du composant avec les bindings angular
  template: '''
    <div class="header">{{name}}</div>
    <div class="content">
      <div>
        <p>
          <material-toggle class="controls__faster-button" label="Eau" [checked]="isWaterOn" (checkedChange)="toggleWater()"> </material-toggle>&nbsp;
          <span [hidden]="!isWaterOn"> Encore {{waterTime}}s</span>
        </p>
        <material-progress [activeProgress]="progress"> </material-progress>
        <material-button class="green" raised [disabled]="isWaterOn" (trigger)="toggleWater()">Start</material-button>
        <material-button class="red" raised [disabled]="!isWaterOn" (trigger)="toggleWater()">Stop</material-button>
        <material-spinner *ngIf="isWaterOn"></material-spinner>
        
      </div>
    </div>
  ''',
  // Les styles CSS associés avec ce composant
  styles: [ '''
      .green:not([disabled]) {
        background-color:darkgreen;
        color:white;
      }

      .red:not([disabled]) {
        background-color:red;
        color:white;
      }
    '''
  ],
  // Les classes utilisées dans le modèle HTML
  directives: [
    MaterialToggleComponent,
    MaterialButtonComponent,
    MaterialSpinnerComponent,
    MaterialProgressComponent,
    NgIf // *ngIf utilisé dans <material-spinner> (affiche ou pas en fonction de la condition)
  ],
  // Liste des services dont dépend le composant, ici un service timer, dependency injection
  providers: [ClassProvider(WaterService)]
)
// La logique du composant
class AppComponent {
  // les membres du composants, accessibles depuis le modèle HTML
  final String name = 'La Chatière';
 
  // Le "Water Service" de la chatière
  final WaterService _waterService;

  // valeurs intervenant dans le modèle
  int waterTime = 0;
  bool get isWaterOn => waterTime > 0;
  int progress = 0;
  int maxprogress = 0;
  
  // Le constructeur initialise le Water Service et met en place un timer pour raffraichir l'application toutes les secondes
  AppComponent(this._waterService) {
    Timer.periodic(Duration(seconds: 1), _onTimer);
  }

  // Périodiquement l'AppComponent va chercher les valeurs sur la Water Service
  void _onTimer(Timer t) async {
    waterTime = await _waterService.getWaterRemainingTime();
    if (maxprogress == 0 || waterTime == 0) {
      maxprogress = waterTime;
      progress = 0;
    }
    else {
      progress = 100 - (waterTime * 100 / maxprogress).round();
    }
  }

  // les méthodes associées au composant, accessibles depuis le modèle HTML
  void toggleWater() async {
    waterTime = await _waterService.toggleWater();
    maxprogress = waterTime;
  }
}

```
  _____ _      _    _      _                   _ _   
 |  __ (_)    | |  | |    | |                 | | |  
 | |__) |  ___| | _| | ___| |__   __ _ _ __ __| | |_ 
 |  ___/ |/ __| |/ / |/ _ \ '_ \ / _` | '__/ _` | __|
 | |   | | (__|   <| |  __/ |_) | (_| | | | (_| | |_ 
 |_|   |_|\___|_|\_\_|\___|_.__/ \__,_|_|  \__,_|\__|
              
```

WIP. Android app. Made with Godot v4.3.  

<br/>

## Installation guide

Download  **_releases/Picklebardt_vX.X.X.apk** to your android device. Run to install.

Launch app, then set player names and court settings.

<br/>

<br/>

## Features: 

- Placement determined via Fisher-Yates shuffling. Partnering is best-effort, goal of unique partners over mutiple matches.

- Locally stored player lists. 

- Variable court count and capacity.

- Seeded outcome for reproducing match histories.

## Planned features

- Rework placement alogrithm to guarantee buy rounders participate in new round. Previous partnering can result in repeated buy rounds, especially at low player counts.

- Player list imports/exports via JSON.

- Aesthetic modeling beyond UI MVP.
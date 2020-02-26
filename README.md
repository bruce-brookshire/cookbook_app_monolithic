# Cookbook App Monolithic

## Cookbook API
This is an Elixir API running a PostgreSQL database. 

Start the server by running: 
```bash
cd cookbook_api
mix deps.get -y
mix phx.server
```

## Cookbook Mobile App
This is the primary interface for interacting with the Cookbook backend. 
It is implemented in Flutter in order to service iOS and Android.

Start the app by starting a simulator or connecting a device, and doing the following:
```bash
cd cookbook_mobile
flutter pub get
flutter run 
```

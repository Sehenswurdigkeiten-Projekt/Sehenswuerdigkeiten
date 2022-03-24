class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String token = 'your-mapbox-token';
    final String style = 'url-to-style';

    return Scaffold(
      body: MapboxMap(
          accessToken: token,
          styleString: style,
          initialCameraPosition: CameraPosition(
            zoom: 15.0,
            target: LatLng(14.508, 46.048),
          ),

          // The onMapCreated callback should be used for everything related
          // to updating map components via the MapboxMapController instance
          onMapCreated: (MapboxMapController controller) {
            // Acquire current location (returns the LatLng instance)
            final result = await acquireCurrentLocation();

            // You can either use the moveCamera or animateCamera, but the former
            // causes a sudden movement from the initial to 'new' camera position,
            // while animateCamera gives a smooth animated transition
            await controller.animateCamera(
              CameraUpdate.newLatLng(result),
            );

            // Add a circle denoting current user location
            await controller.addCircle(
              CircleOptions(
                circleRadius: 8.0,
                circleColor: '#006992',
                circleOpacity: 0.8,

                // YOU NEED TO PROVIDE THIS FIELD!!!
                // Otherwise, you'll get a silent exception somewhere in the stack
                // trace, but the parameter is never marked as @required, so you'll
                // never know unless you check the stack trace
                geometry: result,
                draggable: false,
              ),
            );
          }
      ),
    );
  }
}
import 'dart:async';

import 'package:flutter/material.dart';
import '../configs/screen_size_config.dart';
import '../widgets/dashboard_data_container.dart';
import '../widgets/dashboard_date_container.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = 'dashboard-screen';
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double speed = 0.0;
  double lat = 0.0;
  double long = 0.0;
  GoogleMapController? mapController;

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  void getPosition() async {
    if (await Permission.location.request().isGranted) {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((value) async {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                value.latitude,
                value.longitude,
              ),
              zoom: 20.0,
            ),
          ),
        );
        getLocation();
      });
    } else {
      openAppSettings();
    }
  }

  void getLocation() {
    // StreamSubscription<Position> positionStream =
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      setState(() {
        speed = position!.speed * 3.6;
        lat = position.latitude;
        long = position.longitude;
      });
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              lat,
              long,
            ),
            zoom: 20.0,
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    getPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: ScreenConfig.screenSizeHeight * 0.4,
                    child: SfRadialGauge(
                      backgroundColor: Colors.black,
                      animationDuration: 3000,
                      enableLoadingAnimation: true,
                      axes: <RadialAxis>[
                        RadialAxis(
                          useRangeColorForAxis: true,
                          canScaleToFit: true,
                          showLastLabel: true,
                          showTicks: true,
                          tickOffset: 5,
                          minimum: 0,
                          maximum: 250,
                          minorTicksPerInterval: 5,
                          axisLineStyle: const AxisLineStyle(
                            color: Colors.white,
                            thickness: 0,
                          ),
                          axisLabelStyle: const GaugeTextStyle(
                            color: Colors.white,
                          ),
                          majorTickStyle: const MajorTickStyle(
                            color: Colors.white,
                            length: 12,
                          ),
                          minorTickStyle: const MinorTickStyle(
                            color: Colors.white,
                            length: 10,
                          ),
                          ranges: <GaugeRange>[
                            GaugeRange(
                                startValue: 0,
                                endValue: 50,
                                color: Colors.green),
                            GaugeRange(
                                startValue: 50,
                                endValue: 150,
                                color: Colors.orange),
                            GaugeRange(
                                startValue: 150,
                                endValue: 250,
                                color: Colors.red)
                          ],
                          pointers: <GaugePointer>[
                            NeedlePointer(
                              value: speed,
                              enableAnimation: true,
                              needleColor: Colors.red,
                              knobStyle: const KnobStyle(
                                knobRadius: 0.1,
                                color: Colors.red,
                              ),
                            )
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              widget: Text(
                                speed.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              angle: 90,
                              positionFactor: 0.5,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      DashboardDateContainer(
                        format: 'dd-MMM-yyyy',
                        title: 'Date',
                      ),
                      SizedBox(height: 10),
                      DashboardDateContainer(
                        format: 'hh:mm:ss aaa',
                        title: 'Time',
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const DashboardDataContainer(
                    text: '60 %',
                    title: 'Fuel',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: ScreenConfig.screenSizeHeight * 0.4,
              width: ScreenConfig.screenSizeWidth,
              child: GoogleMap(
                myLocationEnabled: true,
                scrollGesturesEnabled: true,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                compassEnabled: false,
                mapToolbarEnabled: false,
                trafficEnabled: true,
                buildingsEnabled: true,
                indoorViewEnabled: true,
                rotateGesturesEnabled: true,
                tiltGesturesEnabled: true,
                zoomGesturesEnabled: true,
                // markers: <Marker>{
                //   Marker(
                //       markerId: const MarkerId('one'),
                //       // icon: originIcon,
                //       position: LatLng(lat, long),
                //       infoWindow: const InfoWindow(title: 'Current location')),
                // },
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, long),
                  zoom: 20.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  Completer().complete(controller);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

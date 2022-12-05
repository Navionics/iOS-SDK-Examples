# Getting Started

## Step 1:  Get an application Token
Before you can begin working with Navionics Mobile SDK for iOS, you need to ensure that you have an application token.

* Login or register a new user on the Navionics Developer Portal
* Go to your developer console
* Select Credentials Management
* Generate and add your SSH key to your account
* Select App Management and add the Bundle Identifier of your app
* As soon as the token request will be processed, you will receive a notification by mail.

## Step 2:  Get the latest version of Xcode
To build a project using the Navionics Mobile SDK for iOS, you need version 8.0 or later of Xcode.


## Step 3:  Install the Navionics Mobile SDK for iOS

1. Download the SDK source files.
2. Unpack the source files.
3. Open your project, or create a new project. Drag the framework into your project.
	* `NavionicsMobileSDK.xcframework`
4. Right-click `NavionicsMobileSDK.xcframework` in your project, and select Show In Finder.
5. Drag the `NavionicsMobileSDK.bundle` from the `NavionicsMobileSDK.xcframework` folder into your project.
6. Open the `Build Phases` tab, and within Link Binary with Libraries, add the following frameworks:
	* `NavionicsMobileSDK.xcframework`
	* `CoreLocation.framework`
	* `WebKit.framework`
	* `CoreMotion.framework`
	* `libc++.tbd`
7. Open the `Build Settings` tab and set the `Enable Bitcode` option to `NO`



## Step 4:  Use your Token in your application

Add your token and your private key to your `Appdelegate` as follow:

1. Import the `NavionicsMobileSDK` header
```objective-c 
#import <NavionicsMobileSDK/NavionicsMobileSDK.h>
```
2. Add your token and your private key to your `application:didFinishLaunchingWithOptions:`
```objective-c
NMSSettings* settings = [NMSSettings settings];
settings.mode = NMSFrameworkModeSandbox;
settings.projectToken = @"YOUR-PROJECT-TOKEN";
settings.configurationToken = @"YOUR-CONFIGURATION-TOKEN";
settings.privateKey = @"-----BEGIN RSA PRIVATE KEY-----\nYOUR\nPRIVATE\nKEY\n-----END RSA PRIVATE KEY-----\n";
NSError* error = nil;
[NavionicsMobileServices initializeWithSettings:settings error:&error];
```
Note that your private key will have the following format:
```
-----BEGIN RSA PRIVATE KEY-----
YOUR
PRIVATE
KEY
-----END RSA PRIVATE KEY-----
```

Do not forget to add the new line character `\n`

How to use the Navionics Mobile SDK
================

## Add a map

You can add the ```NMSMapView``` in your storyboard or create it as follow:
```objective-c
NMSMapView* mapView = [NMSMapView mapWithFrame:frame];
```
Once your map has been created, you need to activate it.
```objective-c
[mapView activate];
```
Only one map view can be active at any given time. If you activate a new map, the previous one will be deactivated.

## Get and search map objects (POIs)
You can get ```NMSGeoObject``` by querying the map in a specific view ```CGPoint``` using
```objective-c
[NavionicsMobileServices geoObjectsAtPoint:mapViewPoint];
```
Or you can search them by using two kinds of searches. 
By name:
```objective-c
[NavionicsMobileServices searchGeoObjectsByName:nameToSearch];
```
and by category:
```objective-c
[NavionicsMobileServices searchGeoObjectsByCategory:NMSSearchCategoryRestaurant];
```

Implements your delegate conform to the ```NMSGeoObjectResultsDelegate``` protocol.
Set your delegate as geo object results delegate 
```objective-c
[NavionicsMobileServices setGeoObjectsResultsDelegate:myDelegate];
```
to get the results of the map querying and the search.
All the results will contains icon and name. If you need more detailed information, you can load the object details by using
```objective-c
-(void)loadDetailsWithCompletionBlock:(void (^)(NMSGeoObject* detailedObject))completion;
```

## Add your own content
You can use the following overlay objects to add your own content on the map
```objective-c
NMSCircle
NMSPolygon
NMSPolyline
NMSMarker
NMSGroundOverlay
```
Create your object and set its ```map```.

* Add a ```NMSCircle```.
	```objective-c
	NMSCircle* circle = [NMSCircle circleWithPosition:circleLocation radius:250];
	circle.fillColor = [UIColor redColor];
	circle.zIndex = 1;
	circle.strokeWidth = 2;
	circle.strokeColor = [UIColor colorWithRed:0.5 green:0.2 blue:0.8 alpha:0.5];
	circle.map = mapView;
	```

* Add a ```NMSPolygon```.
	```objective-c
	NMSMutablePath* path = [NMSMutablePath path];
	
	[path addCoordinate:CLLocationCoordinate2DMake(41.5943782,-70.3538668)];
	[path addCoordinate:CLLocationCoordinate2DMake(41.573444,-70.3862691)];
	[path addCoordinate:CLLocationCoordinate2DMake(41.5528769,-70.3494521)];
	[path addCoordinate:CLLocationCoordinate2DMake(41.5624133,-70.3352917)];
	
	NMSPolygon* polygon = [NMSPolygon polygonWithPath:path];
	polygon.fillColor = [UIColor colorWithRed:75.0f/255.0f green:159.0f/255.0f blue:101.0f/255.0f alpha:0.7f];
	polygon.strokeWidth = 5.0f;
	polygon.strokeColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
	polygon.map = mapView;
	```

* Add a ```NMSMarker```.
	```objective-c
	CLLocationCoordinate2D markerLocation = CLLocationCoordinate2DMake(41.6229011,-70.285697);
	NMSMarker* marker = [NMSMarker markerWithPosition:markerLocation];
	marker.image = [UIImage imageNamed:@"myMakerImage"];
	marker.anchor = CGPointMake(0.5, 0.5);
	marker.opacity = 0.8;
	marker.map = mapView;
	```

* Add a ```NMSPolyline```.
	```objective-c
	NMSMutablePath* path = [NMSMutablePath path];
	
	[path addCoordinate:CLLocationCoordinate2DMake(41.5698391,-70.0216346)];
	[path addCoordinate:CLLocationCoordinate2DMake(41.5417418,-70.0273104)];
	[path addCoordinate:CLLocationCoordinate2DMake(41.5208243,-69.9901994)];
	[path addCoordinate:CLLocationCoordinate2DMake(41.5396177,-69.9076818)];
	
	NMSPolyline* polyline = [NMSPolyline polylineWithPath:path];
	polyline.strokeColor = [UIColor greenColor];
	polyline.strokeWidth = 5.0;
	polyline.map = mapView;
	```

* Add a ```NMSGroundOverlay```.
	```objective-c
	CLLocationCoordinate2D first = CLLocationCoordinate2DMake(41.0,-70.0);
	CLLocationCoordinate2D second = CLLocationCoordinate2DMake(41.1,-70.1);
	NMSCoordinateBounds* bounds = [[[NMSCoordinateBounds alloc] initWithCoordinate:first coordinate:second] autorelease];
	
	NMSGroundOverlay* overlay = [NMSGroundOverlay groundOverlayWithBounds:bounds image:[UIImage imageNamed:@"myImage"]];
	overlay.opacity = 0.8;
	overlay.map = mapView;
	```


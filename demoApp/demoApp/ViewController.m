//
//  ViewController.m
//  demoApp
//
//  Copyright © 2017 Navionics. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NMSGeoObjectResultsDelegate,CLLocationManagerDelegate>
{
    NSMutableArray * mCircles;
    NSMutableArray * mPolygons;
    NSMutableArray * mMarkers;
    NSMutableArray * mPolylines;
    CLLocationManager* mLocationManager;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.mapView isKindOfClass:[NMSMapView class]])
        [self.mapView activate];
    
    mLocationManager = [[CLLocationManager alloc] init];
    mLocationManager.delegate = self;
    mLocationManager.headingFilter = 1;
    mLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    mLocationManager.distanceFilter = kCLDistanceFilterNone;
    mLocationManager.activityType = CLActivityTypeOtherNavigation;
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined)
    {
        if ([mLocationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            [mLocationManager requestAlwaysAuthorization];
    }
    
    self.plusButton.backgroundColor = [UIColor darkGrayColor];
    self.minusButton.backgroundColor = [UIColor darkGrayColor];
    self.circleButton.backgroundColor = [UIColor darkGrayColor];
    self.markerButton.backgroundColor = [UIColor darkGrayColor];
    self.polygonButton.backgroundColor = [UIColor darkGrayColor];
    self.polylineButton.backgroundColor = [UIColor darkGrayColor];
    self.gpsButton.backgroundColor = [UIColor darkGrayColor];
    self.downloadButton.backgroundColor = [UIColor darkGrayColor];
    self.loginButton.backgroundColor = [UIColor darkGrayColor];

    
    [self.plusButton addTarget:self action:@selector(plusButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.minusButton addTarget:self action:@selector(minusButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.circleButton addTarget:self action:@selector(circleButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.markerButton addTarget:self action:@selector(markerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.polygonButton addTarget:self action:@selector(polygonButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.polylineButton addTarget:self action:@selector(polylineButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.gpsButton addTarget:self action:@selector(gpsButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.downloadButton addTarget:self action:@selector(downloadButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];


    
    mCircles = [[NSMutableArray array] retain];
    mPolygons = [[NSMutableArray array] retain];
    mMarkers = [[NSMutableArray array] retain];
    mPolylines = [[NSMutableArray array] retain];
}

- (void)dealloc
{
    [mLocationManager stopUpdatingHeading];
    [mLocationManager stopUpdatingLocation];
    [mLocationManager release];
    [mCircles release];
    [mPolygons release];
    [mMarkers release];
    [mPolylines release];
    [_mapView release];
    [_plusButton release];
    [_minusButton release];
    [_circleButton release];
    [_polygonButton release];
    [_markerButton release];
    [_polylineButton release];
    [_gpsButton release];
    [_downloadButton release];
    [_loginButton release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [NavionicsMobileServices setGeoObjectsResultsDelegate:self];
    [self.mapView moveToLocation:CLLocationCoordinate2DMake(41.6229011,-70.285697) andZoom:4 animated:NO];

    
    NMSMapSettingsEdit* settings = [[NMSMapSettingsEdit alloc] init];
    settings.mapMode = NMSMapModeSonarCharts;
    settings.contoursDepthDensity = NMSContoursDepthDensityVeryHigh;
    settings.depthUnit = NMSDepthUnitFeet;
    self.mapView.settings = settings;
    [settings release];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusNotDetermined ||
        status == kCLAuthorizationStatusDenied ||
        status == kCLAuthorizationStatusRestricted)
    {
        [NavionicsMobileServices disableGPSServices];
    }
    else
    {
        [NavionicsMobileServices enableGPSServices];
    }
}

-(void)plusButtonPressed
{
    [self.mapView zoomInAnimated:YES];
}

-(void)minusButtonPressed
{
    [self.mapView zoomOutAnimated:YES];
}

-(void)circleButtonPressed
{
    if ([mCircles count] == 0)
    {
        self.circleButton.backgroundColor = [UIColor redColor];
        [self addCircle];
    }
    else
    {
        self.circleButton.backgroundColor = [UIColor darkGrayColor];
        [self removeCircle];
    }
}


-(void)markerButtonPressed
{
    if ([mMarkers count] == 0)
    {
        self.markerButton.backgroundColor = [UIColor redColor];
        [self addMarker];
    }
    else
    {
        self.markerButton.backgroundColor = [UIColor darkGrayColor];
        [self removeMarker];
    }
}


-(void)polygonButtonPressed
{
    if ([mPolygons count] == 0)
    {
        self.polygonButton.backgroundColor = [UIColor redColor];
        [self addPolygon];
    }
    else
    {
        self.polygonButton.backgroundColor = [UIColor darkGrayColor];
        [self removePolygon];
    }
}

-(void)polylineButtonPressed
{
    if ([mPolylines count] == 0)
    {
        self.polylineButton.backgroundColor = [UIColor redColor];
        [self addPolyline];
    }
    else
    {
        self.polylineButton.backgroundColor = [UIColor darkGrayColor];
        [self removePolyline];
    }
}

-(void)gpsButtonPressed
{
    switch (self.mapView.gpsMode) {
        case NMSGPSModeUnlinked:
        {
            self.mapView.gpsMode = NMSGPSModeNorthUp;
            break;
        }
        case NMSGPSModeNorthUp:
        {
            self.mapView.gpsMode = NMSGPSModeCompass;

            break;
        }
        case NMSGPSModeCompass:
        {
            self.mapView.gpsMode = NMSGPSModeCourseUp;
            break;
        }
        case NMSGPSModeCourseUp:
        {
            self.mapView.gpsMode = NMSGPSModeNorthUp;
            break;
        }
        case NMSGPSModeCourseUpUnlinked:
        {
            self.mapView.gpsMode = NMSGPSModeCourseUp;
            break;
        }
        default:
            break;
    }
}

-(void)downloadButtonPressed
{
    if ([self.downloadButton.backgroundColor isEqual:[UIColor darkGrayColor]])
    {
        if([NavionicsMobileServices enableDownloadAreaSelector])
            self.downloadButton.backgroundColor = [UIColor redColor];
    }
    else
    {
        [NavionicsMobileServices disableDownloadAreaSelectorAndConfirm:YES];
        self.downloadButton.backgroundColor = [UIColor darkGrayColor];
    }
}

-(void)loginButtonPressed
{
    [NavionicsMobileServices navionicsUser];
}

-(void)addCircle
{
    if ([mCircles count] == 0)
    {
        CLLocationCoordinate2D circleLocation = CLLocationCoordinate2DMake(41.814092,-70.5326246);
        NMSCircle* circle = [NMSCircle circleWithPosition:circleLocation radius:250];
        circle.fillColor = [UIColor redColor];
        circle.zIndex = 1;
        circle.map = self.mapView;
        [mCircles addObject:circle];

        [self.mapView moveToLocation:circleLocation andZoom:7.0 animated:YES];
    }
}

-(void)removeCircle
{
    if ([mCircles count] != 0)
    {
        for (NMSCircle* myCircle in mCircles)
        {
            myCircle.map = nil;
        }
        [mCircles removeAllObjects];
    }
}

-(void)addPolygon
{
    if ([mPolygons count] == 0)
    {
        NMSMutablePath* path = [NMSMutablePath path];
        
        [path addCoordinate:CLLocationCoordinate2DMake(41.5943782,-70.3538668)];
        [path addCoordinate:CLLocationCoordinate2DMake(41.573444,-70.3862691)];
        [path addCoordinate:CLLocationCoordinate2DMake(41.5528769,-70.3494521)];
        [path addCoordinate:CLLocationCoordinate2DMake(41.5624133,-70.3352917)];
        
        NMSPolygon* polygon = [NMSPolygon polygonWithPath:path];
        polygon.fillColor = [UIColor colorWithRed:75.0f/255.0f green:159.0f/255.0f blue:101.0f/255.0f alpha:0.7f];
        polygon.map = self.mapView;
        [mPolygons addObject:polygon];
        
        [self.mapView moveToLocation:CLLocationCoordinate2DMake(41.5943782,-70.3538668) andZoom:7.0 animated:YES];

    }
}

-(void)removePolygon
{
    if ([mPolygons count] != 0)
    {
        for (NMSPolygon* myPolygon in mPolygons)
        {
            myPolygon.map = nil;
        }
        [mPolygons removeAllObjects];
    }
}

-(void)addMarker
{
    if ([mMarkers count] == 0)
    {
        CLLocationCoordinate2D markerLocation = CLLocationCoordinate2DMake(41.6229011,-70.285697);

        NMSMarker* marker = [NMSMarker markerWithPosition:markerLocation];
        marker.map = self.mapView;
        marker.image = [UIImage imageNamed:@"marker_anchor"];
        marker.anchor = CGPointMake(0.5, 0.5);
        [mMarkers addObject:marker];
        
        [self.mapView moveToLocation:markerLocation andZoom:7.0 animated:YES];
    }
}

-(void)removeMarker
{
    if ([mMarkers count] != 0)
    {
        for (NMSMarker* myMarker in mMarkers)
        {
            myMarker.map = nil;
        }
        [mMarkers removeAllObjects];
    }
}

-(void)addPolyline
{
    if ([mPolylines count] == 0)
    {
        NMSMutablePath* path = [NMSMutablePath path];
        
        [path addCoordinate:CLLocationCoordinate2DMake(41.5698391,-70.0216346)];
        [path addCoordinate:CLLocationCoordinate2DMake(41.5417418,-70.0273104)];
        [path addCoordinate:CLLocationCoordinate2DMake(41.5208243,-69.9901994)];
        [path addCoordinate:CLLocationCoordinate2DMake(41.5396177,-69.9076818)];
        
        NMSPolyline* polyline = [NMSPolyline polylineWithPath:path];
        polyline.strokeColor = [UIColor greenColor];
        polyline.strokeWidth = 5.0;
        polyline.map = self.mapView;
        [mPolylines addObject:polyline];
        
        [self.mapView moveToLocation:CLLocationCoordinate2DMake(41.5698391,-70.0216346) andZoom:7.0 animated:YES];
    }
}

-(void)removePolyline
{
    if ([mPolylines count] != 0)
    {
        for (NMSPolyline* myPolyline in mPolylines)
        {
            myPolyline.map = nil;
        }
        [mPolylines removeAllObjects];
    }
}

- (void)geoObjectsAtPointDidReceiveResults:(NSArray<NMSGeoObject *> *)results
{
    for (NMSGeoObject* geoObject in results)
    {
        switch (geoObject.type) {
            case NMSGeoObjectTypeStandard:
            {
                NSLog(@"NMSGeoObjectTypeStandard - name = %@",(NSString*)[ ((NMSGeoObjectStandard*)geoObject).details objectForKey:@"Name"]);
                break;
            }
            case NMSGeoObjectTypeTide:
            {
                NSLog(@"NMSGeoObjectTypeTide - name = %@",(NSString*)[ ((NMSGeoObjectTide*)geoObject).details objectForKey:@"Name"]);
                break;
            }
            case NMSGeoObjectTypeCurrent:
            {
                NSLog(@"NMSGeoObjectTypeCurrent - name = %@",(NSString*)[ ((NMSGeoObjectCurrent*)geoObject).details objectForKey:@"Name"]);
                break;
            }
            case NMSGeoObjectTypePP:
            {
                NSLog(@"NMSGeoObjectTypePP - name = %@",(NSString*)[ ((NMSGeoObjectPP*)geoObject).details objectForKey:@"Name"]);
                break;
            }
            default:
                break;
        }
    }
}

- (void)searchGeoObjectDidReceiveResults:(NSArray<NMSGeoObject*>*)results withStatus:(NMSGeoObjectSearchStatus)status
{
    if (status == NMSGeoObjectSearchStart)
        NSLog(@"Search Start");
    else if (status == NMSGeoObjectSearchEnd)
    {
        NSLog(@"Search End");
        for (NMSGeoObject* geoObject in results)
        {
            switch (geoObject.type) {
                case NMSGeoObjectTypeStandard:
                {
                    NSLog(@"NMSGeoObjectTypeStandard - name = %@",(NSString*)[ ((NMSGeoObjectStandard*)geoObject).details objectForKey:@"Name"]);
                    break;
                }
                case NMSGeoObjectTypeTide:
                {
                    NSLog(@"NMSGeoObjectTypeTide - name = %@",(NSString*)[ ((NMSGeoObjectTide*)geoObject).details objectForKey:@"Name"]);
                    break;
                }
                case NMSGeoObjectTypeCurrent:
                {
                    NSLog(@"NMSGeoObjectTypeCurrent - name = %@",(NSString*)[ ((NMSGeoObjectCurrent*)geoObject).details objectForKey:@"Name"]);
                    break;
                }
                case NMSGeoObjectTypePP:
                {
                    NSLog(@"NMSGeoObjectTypePP - name = %@",(NSString*)[ ((NMSGeoObjectPP*)geoObject).details objectForKey:@"Name"]);
                    break;
                }
                default:
                    break;
            }
        }
    }
}

@end

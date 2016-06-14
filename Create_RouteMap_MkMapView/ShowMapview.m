//
//  ShowMapview.m
//  Create_RouteMap_MkMapView
//
//  Created by Sonitek Mac on 02/06/16.
//  Copyright © 2016 Sonitech. All rights reserved.
//

#import "ShowMapview.h"
#import "AddressAnnotation.h"

@interface ShowMapview (){
    CLLocationManager *locationManager;
}
@end

@implementation ShowMapview

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter =kCLDistanceFilterNone;

    CLLocationCoordinate2D Coordinate;
    Coordinate.latitude =51.5034070;
    Coordinate.longitude =-0.1275920;
    AddressAnnotation *addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:Coordinate];
    addAnnotation.mTitle=@"Hello Mayank";
    [self.mapView addAnnotation:addAnnotation];
    
    // look for the minimum and maximum coordinate
    NSArray *coordinates = [self.mapView valueForKeyPath:@"annotations.coordinate"];
    CLLocationCoordinate2D maxCoord = {-90.0f, -180.0f};
    CLLocationCoordinate2D minCoord = {90.0f, 180.0f};
    for(NSValue *value in coordinates)
    {
        CLLocationCoordinate2D coord = {0.0f, 0.0f};
        [value getValue:&coord];
        if(coord.longitude > maxCoord.longitude)
        {
            maxCoord.longitude = coord.longitude;
            NSLog(@"maxCoord.longitude ==>>%f  ",maxCoord.longitude);
        }
        if(coord.latitude > maxCoord.latitude)
        {
            maxCoord.latitude = coord.latitude;
        }
        if(coord.longitude < minCoord.longitude)
        {
            minCoord.longitude = coord.longitude;
        }
        if(coord.latitude < minCoord.latitude)
        {
            minCoord.latitude = coord.latitude;
        }
    }
    // create a region
    MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
    region.center.longitude = (minCoord.longitude + maxCoord.longitude) / 2.0;
    region.center.latitude = (minCoord.latitude + maxCoord.latitude) / 2.0;
    // calculate the span
    region.span.longitudeDelta = maxCoord.longitude - minCoord.longitude;
    region.span.latitudeDelta = maxCoord.latitude - minCoord.latitude;
    [self.mapView setRegion:region animated:YES];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
    annView.animatesDrop=TRUE;
    annView.canShowCallout = YES;
    if([[annotation title] isEqualToString:@"Current Location"])
    {
        annView.pinTintColor = [UIColor greenColor];
    }
    else
    {
        annView.pinTintColor = [UIColor purpleColor];
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton setTitle:annotation.title forState:UIControlStateNormal];
        [rightButton addTarget:self
                        action:@selector(showDetails:)
              forControlEvents:UIControlEventTouchUpInside];
        annView.rightCalloutAccessoryView = rightButton;
    }
    MKAnnotationView *annotationView = nil;
    annotationView=annView;
    return annotationView;
}

-(IBAction)showDetails:(id)sender
{
    NSLog(@"Show Route ==>>");
    NSString *urlString = [NSString stringWithFormat:@"http://maps.apple.com/?daddr=%f,%f,&saddr=%f,%f",51.5034070,-0.1275920,51.5000000,-0.1000000];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to Get Your Location" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertBtnOk=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                               {
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                               }];
    [alert addAction:alertBtnOk];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {
            [locationManager requestWhenInUseAuthorization];
        }
            break;
        default:
        {
            [locationManager startUpdatingLocation];
        }
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    if (currentLocation != nil) {
        NSString *curLat= [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        NSString *curLong = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        NSLog(@"Current Location Latitude is ==>>%@",curLat);
        NSLog(@"Current Location Longitude is ==>>%@",curLong);
    }
     [locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

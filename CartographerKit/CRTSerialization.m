//
//  CRTSerialization.m
//  CartographerKit
//
//  Created by iain on 11/10/2014.
//  Copyright (c) 2014 False Victories. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "CRTSerialization.h"

NSString * const kCRTJSONFeaturesName = @"features";

NSString * const kCRTJSONTypeName = @"type";
NSString * const kCRTJSONCoordinateName = @"coordinate";
NSString * const kCRTJSONLatitudeName = @"latitude";
NSString * const kCRTJSONLongitudeName = @"longitude";
NSString * const kCRTJSONPointsName = @"points";
NSString * const kCRTJSONRadiusName = @"radius";
NSString * const kCRTJSONRegionName = @"region";
NSString * const kCRTJSONLatitudeDeltaName = @"latitudeDelta";
NSString * const kCRTJSONLongitudeDeltaName = @"longitudeDelta";
NSString * const kCRTJSONPinColorName = @"pinColor";
NSString * const kCRTJSONStrokeColorName = @"strokeColor";
NSString * const kCRTJSONFillColorName = @"fillColor";
NSString * const kCRTJSONTitleName = @"title";
NSString * const kCRTJSONSubtitleName = @"subtitle";

NSString * const kCRTJSONTypeAnnotationName = @"annotation";
NSString * const kCRTJSONTypePolylineName = @"polyline";
NSString * const kCRTJSONTypePolygonName = @"polygon";
NSString * const kCRTJSONTypeCircleName = @"circle";

NSString * const kCRTJSONPinColorRedName = @"red";
NSString * const kCRTJSONPinColorGreenName = @"green";
NSString * const kCRTJSONPinColorPurpleName = @"purple";

#define UNSQUASH_R_F(v) ((v >> 24) / 255.)
#define UNSQUASH_G_F(v) (((v & (0xFF << 16)) >> 16) / 255.)
#define UNSQUASH_B_F(v) (((v & (0xFF << 8)) >> 8) / 255.)
#define UNSQUASH_A_F(v) ((v & 0xFF) / 255.)

@implementation CRTSerialization

static CLLocationCoordinate2D
coordinateFromJSON(NSDictionary *coordDict)
{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([coordDict[kCRTJSONLatitudeName] floatValue],
                                                                   [coordDict[kCRTJSONLongitudeName] floatValue]);
    return coordinate;
}

static CLLocationCoordinate2D *
pointArrayFromJSON(NSArray *pointsArray)
{
    CLLocationCoordinate2D *points = malloc(sizeof(CLLocationCoordinate2D) * pointsArray.count);
    
    NSInteger i = 0;
    for (NSDictionary *coordinateDictionary in pointsArray) {
        CLLocationCoordinate2D coordinate = coordinateFromJSON(coordinateDictionary);
        points[i++] = coordinate;
    };
    
    return points;
}

static NSColor *
colorFromSquashedColor(UInt32 squashedColor)
{
    CGFloat r = UNSQUASH_R_F(squashedColor);
    CGFloat g = UNSQUASH_G_F(squashedColor);
    CGFloat b = UNSQUASH_B_F(squashedColor);
    CGFloat a = UNSQUASH_A_F(squashedColor);
    
    return [NSColor colorWithCalibratedRed:r green:g blue:b alpha:a];
}

+ (void)enumerateShapesFromJSON:(NSDictionary *)jsonDict
                     usingBlock:(void (^)(MKShape *, NSDictionary *))block
{
    NSArray *featuresArray = jsonDict[kCRTJSONFeaturesName];
    
    for (NSDictionary *featureDict in featuresArray) {
        MKShape *shape;
        NSDictionary *properties;
        NSString *typeName;
        
        // Create the specific shape
        typeName = featureDict[kCRTJSONTypeName];
        if ([typeName isEqualToString:kCRTJSONTypeAnnotationName]) {
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.coordinate = coordinateFromJSON(featureDict[kCRTJSONCoordinateName]);
            
            shape = annotation;
            if (featureDict[kCRTJSONPinColorName]) {
                properties = @{kCRTJSONPinColorName: featureDict[kCRTJSONPinColorName]};
            }
        } else if ([typeName isEqualToString:kCRTJSONTypePolygonName]) {
            NSArray *pointArray = featureDict[kCRTJSONPointsName];
            CLLocationCoordinate2D *points = pointArrayFromJSON(pointArray);
            
            MKPolygon *polygon = [MKPolygon polygonWithCoordinates:points count:pointArray.count];
            
            free(points);
            
            shape = polygon;
            
            NSNumber *fillColor = featureDict[kCRTJSONFillColorName];
            NSNumber *strokeColor = featureDict[kCRTJSONStrokeColorName];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            if (fillColor) {
                dict[kCRTJSONFillColorName] = colorFromSquashedColor((UInt32)fillColor.integerValue);
            }
            
            if (strokeColor) {
                dict[kCRTJSONStrokeColorName] = colorFromSquashedColor((UInt32)strokeColor.integerValue);
            }
            properties = [dict copy];
        } else if ([typeName isEqualToString:kCRTJSONTypePolylineName]) {
            NSArray *pointArray = featureDict[kCRTJSONPointsName];
            CLLocationCoordinate2D *points = pointArrayFromJSON(pointArray);
            
            MKPolyline *polyline = [MKPolyline polylineWithCoordinates:points count:pointArray.count];
            
            free(points);
            
            shape = polyline;
            
            NSNumber *strokeColor = featureDict[kCRTJSONStrokeColorName];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            if (strokeColor) {
                dict[kCRTJSONStrokeColorName] = colorFromSquashedColor((UInt32)[strokeColor integerValue]);
            }
            
            properties = [dict copy];
        } else if ([typeName isEqualToString:kCRTJSONTypeCircleName]) {
            CLLocationCoordinate2D coordinate = coordinateFromJSON(featureDict[kCRTJSONCoordinateName]);
            CGFloat radius = [featureDict[kCRTJSONRadiusName] floatValue];
            MKCircle *circle = [MKCircle circleWithCenterCoordinate:coordinate radius:radius];
            
            shape = circle;
            
            NSNumber *fillColor = featureDict[kCRTJSONFillColorName];
            NSNumber *strokeColor = featureDict[kCRTJSONStrokeColorName];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            if (fillColor) {
                dict[kCRTJSONFillColorName] = colorFromSquashedColor((UInt32)fillColor.integerValue);
            }
            
            if (strokeColor) {
                dict[kCRTJSONStrokeColorName] = colorFromSquashedColor((UInt32)strokeColor.integerValue);
            }
            properties = [dict copy];
        } else {
            // Error.
            shape = nil;
            properties = nil;
        }
        
        // Set generic shape properties
        shape.title = featureDict[kCRTJSONTitleName];
        shape.subtitle = featureDict[kCRTJSONSubtitleName];

        block(shape, properties);
    }
}

@end

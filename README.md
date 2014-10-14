CartographerKit
===============

# Overview

Code for parsing Cartographer files.

# Setup

## Via [cocoapods](http://cocoapods.org)

Add the following line to your Podfile:

    pod 'CartographerKit'

Then run `pod install`

## Manually

Clone this repo and add files from the `CartographerKit` folder to your project.

# Usage

Import `CRTSerialization`:

    #import <CartographerKit/CRTSerialization.h>

First use a JSON parser (such as `NSJSONSerialization`) to convert your data into a JSON
object.

    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:@"demo.cartographer"];
    NSDictionary *crtDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

Next, use the `-enumerateShapesFromJSON:usingBlock:` method of CRTSerialization to iterate over
all the items in the file.

    [CRTSerialization enumerateShapesFromJSON:crtDict
                                   usingBlock:^(MKShape *shape, NSDictionary *properties) {
                                       <#code#>
                                   }];

# License

CartographerKit is released under the MIT license, see `LICENSE` for details.


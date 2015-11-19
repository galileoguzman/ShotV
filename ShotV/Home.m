//
//  ViewController.m
//  ShotV
//
//  Created by Galileo Guzman on 18/11/15.
//  Copyright © 2015 Galileo Guzman. All rights reserved.
//

#import "Home.h"
#import "ShowCell.h"


NSArray *shows;
NSMutableArray *nombreArray;

@interface Home ()

@end

@implementation Home


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    shows = [[NSArray alloc] init];
    shows =[NSArray arrayWithArray:[self getTvShows]];
    if(shows != nil){
        
        
        /***************************
         GET ACCESS TO OBJECTS IN ARRAY
         ***************************/
        /*
        NSLog(@"All fine");
        NSLog(@"Size of dictionary %lu", shows.count);
        
        NSLog(@"The first element %@", [shows objectAtIndex:0]);
        
        NSLog(@"The name of first element %@", [[shows objectAtIndex:0] valueForKey:@"name"]);
        
        
        for (id object in shows) {
            // do something with object
            
            NSLog(@"NAME %@", [object valueForKey:@"name"]);
        }*/
        NSLog(@"Datos recuperados");
    }else{
        NSLog(@"Ocurrio un error al recuperar los datos");
    }
    
    
    nombreArray = [NSMutableArray arrayWithObjects:
                   @"Galileo Guzmán",
                   @"Augusto Bustamante",
                   @"Osvaldo Alejandro",
                   @"José manuel chavez",
                   @"Jesus Hernandez",
                   @"Felipe velasco",
                   @"Ricardo Vera",
                   nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// CLEAN STRING WITH HTML TAGS
-(NSString *) stringByStrippingHTML:(NSString*) stringWithHtmlTags {
    NSRange r;
    NSString *s = stringWithHtmlTags;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

// IMAGES CROP
-(UIImage *) CropImageFromTop:(UIImage *)image
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, 35, image.size.width, image.size.height - 20));
    UIImage *cropimage = [[UIImage alloc] initWithCGImage:imageRef] ;
    CGImageRelease(imageRef);
    return cropimage;
}


//WEBSERVICES METHODS

- (NSDictionary *) getTvShows{
    @try {
        NSLog(@"REQUESTO TO API");
        
        //NSString *jsonRequest = [data JSONRepresentation];
        //NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
        
        //NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[jsonRequest length]];
        //set url
        NSURL *url = [NSURL URLWithString:@"http://api.tvmaze.com/shows"];
        
        
        //set  header properties
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"iOS Ulnax 1.0" forHTTPHeaderField:@"User-Agent"];
        
        //[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setURL:url];
        [request setHTTPMethod:@"GET"];
        //[request setHTTPBody:requestData];
        [NSURLRequest requestWithURL:url];
        NSError *error;
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        
        //Check post response
        if ([response statusCode] >=200 && [response statusCode] <305) {
            
            //get json response
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
            //NSLog(@"response received %@",jsonResponse);
            
            //return response
            return jsonResponse;
            
        }
        else {
            if(error){
                NSLog(@"Error response");
                return nil;
            }else{
                NSLog(@"Conect Fail");
                return nil;
            }
            return nil;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception");
        return nil;
    }
}


#pragma MARK TABLE METHODS
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(shows != nil){
        return shows.count;
    }else{
        return 1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 142;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**********************************************************
     INIT UITABLEVIEWCELL FROM NIB FILE
     ***********************************************************/
    static NSString *CellIdentifier = @"cellShow";
    ShowCell *cell = (ShowCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"ShowCell" bundle:nil] forCellReuseIdentifier:@"cellShow"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellShow"];
    }
    
    cell.selectionStyle         = UITableViewCellSelectionStyleNone;
    
    
    /**********************************************************
     GET IMAGE FROM PUBLIC API ROUTE
     ***********************************************************/
    NSString *urlImage = [[[shows objectAtIndex:indexPath.row] valueForKey:@"image"] valueForKey:@"medium"];
    
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString: urlImage]];
    UIImage *imgShow = [UIImage imageWithData:data];
    cell.imgShow.image = [self CropImageFromTop:imgShow];
    //cell.imgShow.layer.contentsRect = CGRectMake(0.1, 0.1, 0.25, 0.25);
    
    
    /**********************************************************
     GET INFORMATION FROM ARRAY AND SET THE TEXT INFO
     ***********************************************************/
    cell.lblShowName.text = [[shows objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.lblSummary.text = [self stringByStrippingHTML:[[shows objectAtIndex:indexPath.row] valueForKey:@"summary"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Row selected %@", [shows objectAtIndex:indexPath.row]);
    
}

- (void)scrollViewDidScroll: (UIScrollView *)scroll {
    // UITableView only moves in one direction, y axis
    CGFloat currentOffset = scroll.contentOffset.y;
    CGFloat maximumOffset = scroll.contentSize.height - scroll.frame.size.height;
    
    // Change 10.0 to adjust the distance from bottom
    if (maximumOffset - currentOffset <= 10.0) {
        //[self methodThatAddsDataAndReloadsTableView];
    }
}

@end

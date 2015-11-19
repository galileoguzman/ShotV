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

@interface Home ()

@end

@implementation Home


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if([[self getTvShows] count] > 0){
        shows = [[NSArray alloc] init];
        shows =[NSArray arrayWithArray:[self getTvShows]];
        
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
    }else{
        NSLog(@"Ocurrio un error al recuperar los datos");
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return shows.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"showCell";
    ShowCell *cell = (ShowCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //NSLog(@"%@", [[shows objectAtIndex:indexPath.row] valueForKey:@"name"]);
    
    //cell.lblShowName.text = [[shows objectAtIndex:indexPath.row] valueForKey:@"name"];
    //cell.imgPersonaje.image = [UIImage imageNamed:imagenesArray[indexPath.row]];
    //Agregar un borde fino al UIImage
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end

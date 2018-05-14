//
//  DSMapViewController.m
//  DS_lottery
//
//  Created by pro on 2018/4/27.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSMapViewController.h"
#import "DSShopPointAnnotation.h"
#import "DSShopAnnotationView.h"
@interface DSMapViewController ()<MAMapViewDelegate,AMapSearchDelegate>
@property (nonatomic, strong) MAMapView        * mapView;

@property (nonatomic, strong) MAUserLocation   * userInfomation;

@property (nonatomic, strong) MAAnnotationView * userLocationAnnotationView;
@property (nonatomic, strong) AMapSearchAPI    * search;
@property (nonatomic, strong) NSMutableArray   * imageUrlArr;
@end

@implementation DSMapViewController

- (void)dealloc
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _longitude = 0;
        _imageUrlArr = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.typeName;

     [self navLeftItem:[DSFuntionTool leftNavBackTarget:self Item:@selector(leftBackAction)]];

    //视图布局
    [self layoutView];

    //提示
    if(![DSFuntionTool isBlankString:self.hudText]){
        [self showMessagetext:self.hudText];
    }
}

/* 布局 */
-(void)layoutView{
    self.userInfomation = nil;
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, self.view.width, PhoneScreen_HEIGHT - Navgationbar_HEIGHT - Tabbarbottom_HEIGHT)];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollow];

    //没有坐标就加载，自动获取周边的数据添加
    if(self.longitude != 0){
        DSShopPointAnnotation * location = [[DSShopPointAnnotation alloc]init];
        location.url = self.imageUrl;
        location.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
        [self.mapView addAnnotation:location];
    }
}

-(void)searchRequest{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:self.userInfomation.location.coordinate.latitude longitude:self.userInfomation.location.coordinate.longitude];
    request.keywords            = @"投注站";
    request.radius = 5000;
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    [self.search AMapPOIAroundSearch:request];
}

#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{

}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        DSShopPointAnnotation * location = [[DSShopPointAnnotation alloc]init];
        NSString * imgUrl = @"";
        if(obj.images.count){
            AMapImage * img = [obj.images firstObject];
            imgUrl = img.url;
        }
        location.url = imgUrl;
        location.coordinate = CLLocationCoordinate2DMake(obj.location.latitude, obj.location.longitude);
        [self.mapView addAnnotation:location];
    }];
}

#pragma mark - 地图代理协议
/* 监听获取当前的地理位置坐标 */
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation){
        //如果定位信息不为空
        if (userLocation != nil) {
            //是否是第一次定位
            if (self.userInfomation == nil) {
                self.userInfomation = userLocation;
                //定位到当前位置，缩放到合适比例

                if(self.longitude == 0){
                    [self.mapView setCenterCoordinate: CLLocationCoordinate2DMake(self.userInfomation.location.coordinate.latitude,self.userInfomation.location.coordinate.longitude) animated:YES];
                    [self searchRequest];
                }else{
                    [self.mapView setCenterCoordinate: CLLocationCoordinate2DMake(self.latitude,self.longitude) animated:YES];
                }
                [self.mapView setZoomLevel:14 animated:YES];
            }else{
                self.userInfomation = userLocation;
            }

        }
    }
}

/* 获取当前的定位标注View */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isMemberOfClass:[DSShopPointAnnotation class]]) {
        DSShopPointAnnotation* annot = (DSShopPointAnnotation *)annotation;
        static NSString * reuseIndetifier = @"annotationUser";
        DSShopAnnotationView * annotationView = (DSShopAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil){
            annotationView = [[DSShopAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        [annotationView.headerImg sd_setImageWithURL:[NSURL URLWithString:annot.url] placeholderImage:nil];
        return annotationView;
    }
    return nil;
}

#pragma mark - 点击事件
-(void)leftBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

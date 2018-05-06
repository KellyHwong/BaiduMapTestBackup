//
//  ViewController.swift
//  BaiduMapTestBackup
//
//  Created by 黄衎 on 2018/5/6.
//  Copyright © 2018 Huang Kan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BMKMapViewDelegate, BMKLocationServiceDelegate {
    var _mapView: BMKMapView?
    var locationService = BMKLocationService()
    override func viewDidLoad() {
        super.viewDidLoad()
        _mapView = BMKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        //以下_mapView为BMKMapView对象
        _mapView?.showsUserLocation = true//显示定位图层
        _mapView?.userTrackingMode = BMKUserTrackingModeNone //设置定位的状态为普通定位模式
        //初始化BMKLocationService
        locationService.allowsBackgroundLocationUpdates = true
        //启动LocationService
        locationService.startUserLocationService()
        
        // 要先关闭，再打开，等于是刷新
        _mapView?.showsUserLocation = false
        // 跟随模式，直接定位到当前位置
        _mapView?.userTrackingMode = BMKUserTrackingModeFollow
        _mapView?.showsUserLocation = true
        self.view.addSubview(_mapView!)
    }
    
    //实现相关delegate 处理位置信息更新
    //处理方向变更信息
    /**
     *用户方向更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {
        print("heading is \(userLocation.heading)")
        _mapView?.updateLocationData(userLocation)
    }
    
    /**
     *用户位置更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdate(_ userLocation: BMKUserLocation!) {
        print("didUpdateUserLocation lat:\(userLocation.location.coordinate.latitude) lon:\(userLocation.location.coordinate.longitude)")
        _mapView?.updateLocationData(userLocation)
    }
    
    /**
     *在地图View停止定位后，会调用此函数
     *@param mapView 地图View
     */
    func didStopLocatingUser() {
        print("didStopLocatingUser")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.viewWillAppear(animated)
        locationService.delegate = self
        _mapView?.delegate = self
        _mapView?.viewWillAppear()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationService.delegate = self
        _mapView?.delegate = nil
        _mapView?.viewWillDisappear()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


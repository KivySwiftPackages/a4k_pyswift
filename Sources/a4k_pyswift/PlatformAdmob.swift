//
//  AdmobBackend.swift
//  PySwiftBackend
//
//  Created by CodeBuilder on 23/07/2025.
//

import PySwiftKit
import PySerializing
import PySwiftObject
import PyUnpack
import PySwiftWrapper
import UIKit
import GoogleMobileAds

@PyClass
final class AdmobBackend {
    
    
    private var listener: AdmobListener?
    
    private var banner: BannerAd?
    private var interstitialAd: InterstitialAd?
    private var rewardedAd: RewardedAd?
    
    @PyInit
    init(callback: PyPointer) {
        
        if callback != Py_None {
            listener = try? GADListener(object: callback)
        }
    }
    
    @PyMethod
    func load_banner(ad_unit: String, top: Bool) {
        banner = BannerAd.new(ad_unit: ad_unit)
        banner?.show(delegate: listener, top: top)
    }
    
    @PyMethod
    func show_banner() {
        banner?.show(delegate: listener)
    }
    
    @PyMethod
    func hide_banner() {
        banner?.disable()
    }
    
    @PyMethod
    func load_interstitial(ad_unit: String) {
        interstitialAd = InterstitialAd.new(ad_unit: ad_unit)
    }
    
    @PyMethod
    func show_interstitial() {
        interstitialAd?.show(delegate: listener)
    }
    
    @PyMethod
    func load_rewarded(ad_unit: String) {
        rewardedAd = .init(ad_unit: ad_unit)
    }
    
    @PyMethod
    func show_rewarded() {
        rewardedAd?.show(delegate: listener)
    }
}

fileprivate var launchedAdmob = false
public func launchAdmob() throws {
    if launchedAdmob { return }
    try GADMobileAds.sharedInstance().start()
    launchedAdmob.toggle()
}

//
//  RewardedAd.swift
//  Admob4Kivy_iOS
//


import GoogleMobileAds
import PySwiftKit
import PySerializing
import PySwiftObject
import PySwiftWrapper

final class RewardedAd: NSObject {
    
    var ad: GADRewardedAd?
    var ad_unit: String
    weak var listener: AdmobListener?
    
    init(ad_unit: String) {
        self.ad_unit = ad_unit
    }
    
    
}

extension RewardedAd: AdmobClass {
    func show(delegate: AdmobListener?) {
        listener = delegate
        
        Task {
            do {
                ad = try await GADRewardedAd.load(withAdUnitID: ad_unit, request: .init())
                ad?.fullScreenContentDelegate = self
                await MainActor.run {
                    guard let kivy = kivy_viewController else {return}
                    ad?.present(fromRootViewController: kivy) {
                        
                    }
                }
                
            } catch let err {
                
            }
        }
    }
    
    func disable() {
        ad = nil
    }
    
    static func new(ad_unit: String) -> Self {
        .init(ad_unit: ad_unit)
    }
}


extension RewardedAd: GADFullScreenContentDelegate {
    func adDidRecordClick(_ ad: any GADFullScreenPresentingAd) {
        listener?.adDidRecordClick?(ad)
    }
    
    func adDidRecordImpression(_ ad: any GADFullScreenPresentingAd) {
        listener?.adDidRecordImpression?(ad)
    }
    
    func adWillPresentFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        listener?.adWillPresentFullScreenContent?(ad)
    }
    
    func adWillDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        listener?.adWillDismissFullScreenContent?(ad)
    }
    
    func adDidDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        listener?.adDidDismissFullScreenContent?(ad)
        self.ad = nil
    }
    
    func ad(_ ad: any GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        listener?.ad?(ad, didFailToPresentFullScreenContentWithError: error)
        self.ad = nil
        
    }
}

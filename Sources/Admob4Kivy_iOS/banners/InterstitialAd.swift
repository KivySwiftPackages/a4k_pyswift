//
//  InterstitialAd.swift
//  PySwiftBackend
//



import GoogleMobileAds
import PySwiftKit
import PySerializing
import PySwiftObject
import PySwiftWrapper


final class InterstitialAd: AdmobClass {
	
	var banner: GADInterstitialAd?
    @PyProperty let adUnitID: String
	
    
	init(ad_unit: String) {
        adUnitID = ad_unit
	}
    
    static func new(ad_unit: String) -> Self {
        Self.init(ad_unit: ad_unit)
    }
	
    @PyMethod
    func show(delegate: AdmobListener? = nil) {
		let request = GADRequest()
		GADInterstitialAd.load(
			withAdUnitID: adUnitID,
			request: request,
			completionHandler: { [self] ad, error in
				if let error = error {
					print("Failed to load interstitial ad with error: \(error.localizedDescription)")
					return
				}
				
				ad?.fullScreenContentDelegate = delegate
				
				guard let kivy = kivy_viewController else {return}
				banner = ad
				banner?.present(fromRootViewController: kivy)
			}
		)
		
	}
    
    func disable() {
        
    }
}

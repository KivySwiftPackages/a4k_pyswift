//
//  AdmobListener.swift
//  PySwiftBackend
//
import GoogleMobileAds
import PySwiftKit
import PySerializing
import PySwiftObject
import PyUnpack
import PySwiftWrapper
import UIKit

@PyContainer
final class GADListener: NSObject, AdmobListener {
    
    func _dispatch(args: [PyPointer?], kw: [String: PyPointer]? = nil) {
        let gil = PyGILState_Ensure()
        
        let kwargs = kw?.pyPointer
        
        guard let result = PyObject_VectorcallDict(py_target, args, args.count, kwargs) else {
            PyErr_Print()
            args.forEach(Py_DecRef)
            if let kwargs { Py_DecRef(kwargs) }
            PyGILState_Release(gil)
            return
        }
        
        Py_DecRef(result)
        args.forEach(Py_DecRef)
        if let kwargs { Py_DecRef(kwargs) }
        
        PyGILState_Release(gil)
    }
    
    
}

extension GADListener: GADBannerViewDelegate {
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        _dispatch(args: ["bannerViewDidReceiveAd".pyPointer])
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: any Error) {
        
    }
    
    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
        
    }
    
    func bannerViewDidRecordClick(_ bannerView: GADBannerView) {
        
    }
    
    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        
    }
    
    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        
    }
    
    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
        
    }
}

extension GADListener: GADFullScreenContentDelegate {
    func adDidRecordImpression(_ ad: any GADFullScreenPresentingAd) {
        
    }
    func adDidRecordClick(_ ad: any GADFullScreenPresentingAd) {
        
    }
    func adDidDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        
    }
    func adWillDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        
    }
    func adWillPresentFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        
    }
    func ad(_ ad: any GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        
    }
}

extension GADListener: GADMediationInterstitialAdEventDelegate {
    func reportImpression() {
        
    }
    
    func reportClick() {
        
    }
    
    func willPresentFullScreenView() {
        
    }
    
    func didFailToPresentWithError(_ error: any Error) {
        
    }
    
    func willDismissFullScreenView() {
        
    }
    
    func didDismissFullScreenView() {
        
    }
    
    
}

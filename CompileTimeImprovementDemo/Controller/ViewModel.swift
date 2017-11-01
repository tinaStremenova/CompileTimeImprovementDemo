//
//  ViewModel.swift
//  CompileTimeImprovementDemo
//
//  Created by Martina Stremenova on 22/10/2017.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation
import UIKit

class ViewModel {
    
    private var apiManager = APIManager()
    private var appInfo:AppInfo?
    
    init() {
        self.apiManager.download(dataCompletion: { json in
            self.appInfo = AppInfo(json: json)
        })
    }
    
    // MARK - String concatenation examples - - - - - - - -
    
    // [TIME]: 16 ms
    var title:String {
        return "Title: " + (self.appInfo?.title ?? "no title")
    }
    
    // [TIME]: under 1 ms
    // + 3 ms from function _makeTitle()
    var optimizedTitle:String {
        // - calculating value in function instead of closure
        // - concatenating string differently
        return self._makeTitle()
    }
    
    // [TIME]: 3ms
    private func _makeTitle() -> String {
        
        // Use of ternary conditional operator - 6 ms
        // return self.appInfo == nil ? "Title: no title" : "Title: \(self.appInfo!.title)"
        
        // use 'if condition' or 'guard let' - 3ms
        if let title = self.appInfo?.title {
            return "Title: \(title)"
        }
        
        return "Title: no title"
    }
    
    
    // MARK - Precomputation examples - - - - - - - - - - -
    
    // [TIME]: 160ms
    var subtitle:String {
        
        // [TIME]: Compiler error
        // return "Subtitle:" + (self.appInfo?.subtitle ?? "no subtitile") +
        // "\nUsers:" + (self.appInfo != nil ?  String(describing: self.appInfo!.users) : "unknown") +
        // "\nStars:" + (self.appInfo != nil ?  String(describing: self.appInfo!.stars) : "unknown")
        
        // [TIME]: 160ms
        return "Subtitle: \((self.appInfo?.subtitle ?? "no subtitile"))\nUsers: \(self.appInfo != nil ?  String(describing: self.appInfo!.users) : "unknown")\nStars:\(self.appInfo != nil ?  String(describing: self.appInfo!.stars) : "unknown")"
    }
    
    // [TIME]: 109ms
    var optimizedSubtitle:String {
        
        // First check for nil before getting the value
        // Then rather use \() for concatenating result strings and conversions to string
        
        if let subtitle = self.appInfo?.subtitle,
            let users = self.appInfo?.users,
            let stars = self.appInfo?.stars {
            return "Subtitle: \(subtitle)\nUsers: \(String(describing: users))\nStars: \(String(format: "%2f", stars))"
        }
        
        return "Subtitle: no subtitle"
    }
    
    // Multiline string
    
    // [TIME]: 11 - 14 ms
    var optimizedDescription: String {
        return "This is description written\nby concatenating strings.\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. \(String(12000)) ratirngs from \(String(describing: self.appInfo?.users)) users.\n\(String(87)) float integer icecream cat \(String(22)) dogs.\n\(String(123)) lorem ipsum bacon ham salamy \(String(12)) popcorn."
    }
    
    // [TIME]: 8 - 9 ms
    var description:String {
        return """
        This is description written
        by multiline string option in new Swift 4!
        Woohoo!
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
        Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        \(String(12000)) ratirngs from \(String(describing: self.appInfo?.users)) users.
        \(String(87)) float integer icecream cat \(String(22)) dogs.
        \(String(123)) lorem ipsum bacon ham salamy \(String(12)) popcorn.
        """
    }
    
    
    
    // MARK: - Complex expressions - - - - - - - - - - - -
    
    // [TIME]: 33ms
    var appPopularity:String {
        return self.appInfo == nil ? "not sure" :
            (self.appInfo!.users < 1000 ? "Not really" : "Very popular!")
    }
    
    // [TIME]: 25 ms
    // Check for nil before using the value
    var optimizedAppPopularity:String {
        guard let numberOfUsers = self.appInfo?.users else { return "not sure" }
        // almost whole compile time now takes up ternary conditional operator
        return numberOfUsers < 1000 ? "Not really" : "Very popular!"
    }
    
    // [TIME]: 12 - 13 ms
    var appQuality: String {
        guard let stars = self.appInfo?.stars,
            let users = self.appInfo?.users else { return "Unknown" }

        // this actually calculates nonsense
        return stars.advanced(by: 5.0) > 5
            && stars.distance(to: 4.0) == 1
            && users > 5000
            || users > 10000 && stars > 4 ?
                "Very good app. No bugs!" : "Just delete it"

    }
    
    
    // [TIME]: 9 - 11 ms
    var optimizedAppQuality: String {
        guard let stars = self.appInfo?.stars,
            let users = self.appInfo?.users else { return "Unknown" }

        // pre-computation
        let isGoodByNonsenseCalculaton = stars.advanced(by: 5.0) > 5
            && stars.distance(to: 4.0) == 1
            && users > 5000

        let isGoodByValidCalculation = users > 200 && stars > 4

        return isGoodByNonsenseCalculaton
            || isGoodByValidCalculation ?
                "Very good app. No bugs!" : "Just delete it"

    }
    
}


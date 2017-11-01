//
//  DataSource.swift
//  CompileTimeImprovementDemo
//
//  Created by Martina Stremenova on 16/10/2017.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

// Fake API Manager for downloading and uploading data from imaginary backend
struct APIManager {
    
    // [TIME] under 1 ms
    private var json = {
        return  ["title" : "Amazing App",
                 "subtitle" : "Best App Ever",
                 "image_name" : "catImage",
                 "number_of_stars" : 4.5,
                 "number_of_users" : 2568,
                 "reviews" : [
                    ["username" : "user123",
                     "review": "Great App!",
                     "stars" : 4
                    ],
                    ["username" : "user123",
                     "review": "Great App!",
                     "stars" : 4
                    ],
                    ["username" : "user123",
                     "review": "Great App!",
                     "stars" : 4
                    ],
                    ["username" : "user123",
                     "review": "Great App!",
                     "stars" : 4
                    ],
                    ["username" : "user123",
                     "review": "Great App!",
                     "stars" : 4
                    ],
                    ["username" : "user123",
                     "review": "Great App!",
                     "stars" : 4
                    ],
                    ["username" : "user123",
                     "review": "Great App!",
                     "stars" : 4
                    ],
                    ["username" : "user123",
                     "review": "Great App!",
                     "stars" : 4
                    ],
                    ["username" : "user123",
                     "review": "Great App!",
                     "stars" : 4
                    ]
            ]]
    }()
    
    func download(dataCompletion: (JSON) -> Void) {
        
        // [TIME] 83 ms
        dataCompletion(["title" : "Amazing App",
                        "subtitle" : "Best App Ever",
                        "image_name" : "catImage",
                        "number_of_stars" : 4.5,
                        "number_of_users" : 2568,
                        "reviews" : [
                            ["username" : "user123",
                             "review": "Great App!",
                             "stars" : 4
                            ], ["username" : "user123",
                             "review": "Great App!",
                             "stars" : 4 ],
                            ["username" : "user123",
                             "review": "Great App!",
                             "stars" : 4 ],
                            ["username" : "user123",
                             "review": "Great App!",
                             "stars" : 4 ],
                            ["username" : "user123",
                             "review": "Great App!",
                             "stars" : 38 ],
                            ["username" : "user123",
                             "review": "Great App!",
                             "stars" : 4 ],
                            ["username" : "user123",
                             "review": "Great App!",
                             "stars" : 4 ],
                            ["username" : "user123",
                             "review": "Great App!",
                             "stars" : 4 ],
                            ["username" : "user123",
                             "review": "Great App!",
                             "stars" : 4 ]]])
        
        
        // [TIME] under 1 ms
        // rather prepare collection in advance and then use it as parameter
        // dataCompletion(self.json)
    }
    
    func upload(data:JSON) {
        // just kidding, we're not uploading anything :)
        print(data)
    }
}

struct AppInfo {
    
    let title:String
    let subtitle:String
    let imageName:String
    let stars: Double
    let users: Int
    
    init(json: JSON) {
        
        self.title = json["title"] as! String
        self.subtitle = json["subtitle"] as! String
        self.imageName = json["image_name"] as! String
        self.stars = json["number_of_stars"] as! Double
        self.users = json["number_of_users"] as! Int
    }
}

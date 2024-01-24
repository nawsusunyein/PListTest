//
//  AppConfig.swift
//  PListTest
//
//  Created by Naw Su Su Nyein on 25/01/2024.
//  Copyright © 2024 Naw Su Su Nyein. All rights reserved.
//

import Foundation

struct AppConfig {
    static let baseURL = getBaseURL()
    
    static func getBaseURL() -> String {
        #if DEV
            return "www.dev.com"
        #elseif STAGING
            return "www.staging.com"
        #elseif QA
            return "www.qa.com"
        #endif
        return ""
    }
}

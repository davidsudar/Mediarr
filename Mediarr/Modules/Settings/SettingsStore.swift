//
//  SettingsStore.swift
//  Mediarr
//
//  Created by David Sudar on 11/7/2022.
//

import SwiftUI
import Combine

final class SettingsStore: ObservableObject {
    private enum Keys {
        static let sonarrHost = "sonarr_host"
        static let sonarrPort = "sonarr_port"
        static let sonarrApiKey = "sonarr_api_key"
        static let radarrHost = "radarr_host"
        static let radarrPort = "radarr_port"
        static let radarrApiKey = "radarr_api_key"
        static let transmissionHost = "transmission_host"
        static let transmissionPort = "transmission_port"
        static let transmissionUsername = "transmission_username"
        static let transmissionPassword = "transmission_password"
        static let sabnzbdHost = "sabnzbd_host"
        static let sabnzbdPort = "sabnzbd_port"
        static let sabnzbdUsername = "sabnzbd_username"
        static let sabnzbdPassword = "sabnzbd_password"
        static let sabnzbdApiKey = "sabnzbd_api_key"
        static let nasHost = "nas_host"
        static let nasPort = "nas_port"
        static let nasUsername = "nas_username"
        static let nasPassword = "nas_password"
    }

    private let cancellable: Cancellable
    private let defaults: UserDefaults

    let objectWillChange = PassthroughSubject<Void, Never>()

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        defaults.register(defaults: [
            Keys.sonarrHost: "",
            Keys.sonarrPort: 8989,
            Keys.sonarrApiKey: "",
            Keys.radarrHost: "",
            Keys.radarrPort: 7878,
            Keys.radarrApiKey: "",
            Keys.transmissionHost: "",
            Keys.transmissionPort: 9091,
            Keys.transmissionUsername: "",
            Keys.transmissionPassword: "",
            Keys.sabnzbdHost: "",
            Keys.sabnzbdPort: 6789,
            Keys.sabnzbdUsername: "sabnzbd",
            Keys.sabnzbdPassword: "tegbzn6789",
            Keys.sabnzbdApiKey: "",
            Keys.nasHost: "192.168.1.2",
            Keys.nasPort: 5000,
            Keys.nasUsername: "sudar",
            Keys.nasPassword: "Avids2233#"
            ])

        cancellable = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .map { _ in () }
            .subscribe(objectWillChange)
    }

    var sonarrHost: String {
        set { defaults.set(newValue, forKey: Keys.sonarrHost) }
        get { defaults.string(forKey: Keys.sonarrHost) ?? "" }
    }

    var sonarrPort: Int {
        set { defaults.set(newValue, forKey: Keys.sonarrPort) }
        get { defaults.integer(forKey: Keys.sonarrPort)}
    }

    var sonarrApiKey: String {
        set { defaults.set(newValue, forKey: Keys.sonarrApiKey) }
        get { defaults.string(forKey: Keys.sonarrApiKey) ?? "" }
    }
    var radarrHost: String {
        set { defaults.set(newValue, forKey: Keys.radarrHost) }
        get { defaults.string(forKey: Keys.radarrHost) ?? "" }
    }

    var radarrPort: Int {
        set { defaults.set(newValue, forKey: Keys.radarrPort) }
        get { defaults.integer(forKey: Keys.radarrPort)}
    }

    var radarrApiKey: String {
        set { defaults.set(newValue, forKey: Keys.radarrApiKey) }
        get { defaults.string(forKey: Keys.radarrApiKey) ?? "" }
    }
    
    var transmissionHost: String {
        set { defaults.set(newValue, forKey: Keys.transmissionHost) }
        get { defaults.string(forKey: Keys.transmissionHost) ?? "" }
    }
    var transmissionPort: Int {
        set { defaults.set(newValue, forKey: Keys.transmissionPort) }
        get { defaults.integer(forKey: Keys.transmissionPort)}
    }

    var transmissionUsername: String {
        set { defaults.set(newValue, forKey: Keys.transmissionUsername) }
        get { defaults.string(forKey: Keys.transmissionUsername) ?? ""}
    }

    var transmissionPassword: String {
        set { defaults.set(newValue, forKey: Keys.transmissionPassword) }
        get { defaults.string(forKey: Keys.transmissionPassword) ?? "" }
    }
    var sabnzbdHost: String {
        set { defaults.set(newValue, forKey: Keys.sabnzbdHost) }
        get { defaults.string(forKey: Keys.sabnzbdHost) ?? "" }
    }
    var sabnzbdPort: Int {
        set { defaults.set(newValue, forKey: Keys.sabnzbdPort) }
        get { defaults.integer(forKey: Keys.sabnzbdPort)}
    }

    var sabnzbdUsername: String {
        set { defaults.set(newValue, forKey: Keys.sabnzbdUsername) }
        get { defaults.string(forKey: Keys.sabnzbdUsername) ?? ""}
    }

    var sabnzbdPassword: String {
        set { defaults.set(newValue, forKey: Keys.sabnzbdPassword) }
        get { defaults.string(forKey: Keys.sabnzbdPassword) ?? "" }
    }
    
    var sabnzbdApiKey: String {
        set { defaults.set(newValue, forKey: Keys.sabnzbdApiKey) }
        get { defaults.string(forKey: Keys.sabnzbdApiKey) ?? "" }
    }
    
    var nasHost: String {
        set { defaults.set(newValue, forKey: Keys.nasHost) }
        get { defaults.string(forKey: Keys.nasHost) ?? "" }
    }
    var nasPort: Int {
        set { defaults.set(newValue, forKey: Keys.nasPort) }
        get { defaults.integer(forKey: Keys.nasPort)}
    }

    var nasUsername: String {
        set { defaults.set(newValue, forKey: Keys.nasUsername) }
        get { defaults.string(forKey: Keys.nasUsername) ?? ""}
    }

    var nasPassword: String {
        set { defaults.set(newValue, forKey: Keys.nasPassword) }
        get { defaults.string(forKey: Keys.nasPassword) ?? "" }
    }
}


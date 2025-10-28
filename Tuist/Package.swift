// swift-tools-version: 6.0
import PackageDescription

#if TUIST
import struct ProjectDescription.PackageSettings
import ProjectDescriptionHelpers

let packageSettings = PackageSettings(
    productTypes: [
        SPMDependency.unspAuthorization.name: resolvedFramework(),
        SPMDependency.unspMainFlow.name: resolvedFramework(),
        
        SPMDependency.helpersSharedUnsp.name: resolvedFramework(),
        SPMDependency.snapKitWrapper.name: resolvedFramework(),
        SPMDependency.coreKit.name: resolvedFramework(),
        SPMDependency.loggingKit.name: resolvedFramework(),
        SPMDependency.keychainStorageKit.name: resolvedFramework(),
        SPMDependency.networkKit.name: resolvedFramework(),
    ]
)
#endif


let package = Package(
    name: "UnspApp",
    dependencies: [
        .make(from: SPMDependency.helpersSharedUnsp),
        .make(from: SPMDependency.snapKitWrapper),
        .make(from: SPMDependency.coreKit),
        .make(from: SPMDependency.loggingKit),
        .make(from: SPMDependency.keychainStorageKit),
        .make(from: SPMDependency.networkKit),
        
        .make(from: SPMDependency.unspAuthorization),
        .make(from: SPMDependency.unspMainFlow),
    ]
)

/// MARK: - Dependencies
fileprivate enum SPMDependency {
    static let unspAuthorization = PackageModel(
        name: "UnspAuthorization",
        url: "https://github.com/TimurkaevMalik/UnspAuthorization.git",
        requirement: .version(.init(1, 5, 0))
    )
    
    static let unspMainFlow = PackageModel(
        name: "UnspMainFlow",
        url: "https://github.com/TimurkaevMalik/UnspMainFlow.git",
        requirement: .version(.init(1, 5, 0))
    )
    
    static let snapKitWrapper = PackageModel(
        name: "SnapKitWrapper",
        url: "https://github.com/TimurkaevMalik/SnapKitWrapper.git",
        requirement: .version(.init(5, 8, 0))
    )
    
    static let loggingKit = PackageModel(
        name: "LoggingKit",
        url: "https://github.com/TimurkaevMalik/LoggingKit.git",
        requirement: .version(.init(1, 2, 0))
    )
    
    static let keychainStorageKit = PackageModel(
        name: "KeychainStorageKit",
        url: "https://github.com/TimurkaevMalik/KeychainStorageKit.git",
        requirement: .version(.init(1, 9, 0))
    )
    
    static let coreKit = PackageModel(
        name: "CoreKit",
        url: "https://github.com/TimurkaevMalik/CoreKit.git",
        requirement: .version(.init(2, 15, 0))
    )
    
    static let networkKit = PackageModel(
        name: "NetworkKit",
        url: "https://github.com/TimurkaevMalik/NetworkKit.git",
        requirement: .version(.init(1, 7, 0))
    )
    
    static let helpersSharedUnsp = PackageModel(
        name: "HelpersSharedUnsp",
        url: "https://github.com/TimurkaevMalik/HelpersSharedUnsp.git",
        requirement: .version(.init(1, 1, 0))
    )
}

fileprivate struct PackageModel: Sendable {
    let name: String
    let url: String
    let requirement: Requirement
    
    init(name: String, url: String, requirement: Requirement) {
        self.name = name
        self.url = url
        self.requirement = requirement
    }
    
    public enum Requirement: Sendable{
        case version(Version)
        case branch(String)
        
        var string: String {
            switch self {
                
            case .version(let version):
                return version.stringValue
                
            case .branch(let string):
                return string
            }
        }
    }
}

fileprivate extension Version {
    var stringValue: String {
        let major = "\(major)"
        let minor = "\(minor)"
        let patch = "\(patch)"
        
        return major + "." + minor + "." + patch
    }
    
    init(string: String) {
        self.init(stringLiteral: string)
    }
}

fileprivate extension Package.Dependency {
    static func make(from package: PackageModel) -> Package.Dependency {
        let url = package.url
        let requirement = package.requirement.string
        
        switch package.requirement {
            
        case .version:
            return .package(url: url, from: .init(string: requirement))
        case .branch:
            return .package(url: url, branch: requirement)
        }
    }
}

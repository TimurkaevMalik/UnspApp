// swift-tools-version: 6.0
import PackageDescription

#if TUIST
import struct ProjectDescription.PackageSettings

let packageSettings = PackageSettings(
    productTypes: [
        SPMDependency.unspAuthorization.name: .staticLibrary,
        SPMDependency.unspMainFlow.name: .staticLibrary,
        
        SPMDependency.helpersSharedUnsp.name: .staticLibrary,
        SPMDependency.snapKit.name: .staticLibrary,
        SPMDependency.coreKit.name: .staticLibrary,
        SPMDependency.loggingKit.name: .staticLibrary,
        SPMDependency.keychainStorageKit.name: .staticLibrary,
        SPMDependency.networkKit.name: .staticLibrary,
    ]
)
#endif


let package = Package(
    name: "UnspApp",
    dependencies: [
        .make(from: SPMDependency.unspAuthorization),
        .make(from: SPMDependency.unspMainFlow),
        
        .make(from: SPMDependency.helpersSharedUnsp),
        .make(from: SPMDependency.snapKit),
        .make(from: SPMDependency.coreKit),
        .make(from: SPMDependency.loggingKit),
        .make(from: SPMDependency.keychainStorageKit),
        .make(from: SPMDependency.networkKit)
    ]
)

/// MARK: - Dependencies
fileprivate enum SPMDependency {
    static let unspAuthorization = PackageModel(
        name: "UnspAuthorization",
        url: "https://github.com/TimurkaevMalik/UnspAuthorization.git",
        requirement: .version(.init(1, 1, 0))
    )
    
    static let unspMainFlow = PackageModel(
        name: "UnspMainFlow",
        url: "https://github.com/TimurkaevMalik/UnspMainFlow.git",
        requirement: .version(.init(1, 0, 0))
    )
    
    static let snapKit = PackageModel(
        name: "SnapKit",
        url: "https://github.com/SnapKit/SnapKit.git",
        requirement: .version(.init(5, 7, 0))
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
        requirement: .branch("main")
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

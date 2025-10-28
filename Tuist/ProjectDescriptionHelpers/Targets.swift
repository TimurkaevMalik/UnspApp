//
//  Targets.swift
//  Manifests
//
//  Created by Malik Timurkaev on 25.09.2025.
//

import ProjectDescription

public enum Targets {
    public static let appTarget = Target.target(
        name: ProjectConstants.appName,
        destinations: .iOS,
        product: .app,
        bundleId: ProjectConstants.bundleID,
        infoPlist: .extendingDefault(
            with: [
                applicationSceneManifest: .dictionary(defaultSceneManifest),
                launchStoryboardName: .string("LaunchScreen")
            ]),
        sources: [Source.appSources, Source.appLifecycle],
        resources: [Resource.appResources],
        dependencies: [
            .target(name: SPMDependency.unspAuthorization.name),
            .target(name: SPMDependency.unspMainFlow.name),
            
            .external(name: SPMDependency.keychainStorageKit.name),
            .external(name: SPMDependency.helpersSharedUnsp.name),
            .external(name: SPMDependency.snapKitWrapper.name),
            .external(name: SPMDependency.coreKit.name),
            .external(name: SPMDependency.loggingKit.name),
            .external(name: SPMDependency.networkKit.name)
        ]
    )
    
    public static let authTarget = Target.target(
        name: SPMDependency.unspAuthorization.name,
        destinations: .iOS,
        product: resolvedFramework(),
        bundleId: "dev.tuist\(SPMDependency.unspAuthorization.name)",
        infoPlist: .default,
        sources: [ 
            "Tuist/.build/checkouts/UnspAuthorization/UnspAuthorization/Sources/**"
        ],
        dependencies: [
            .external(name: SPMDependency.keychainStorageKit.name),
            .external(name: SPMDependency.helpersSharedUnsp.name),
            .external(name: SPMDependency.snapKitWrapper.name),
            .external(name: SPMDependency.coreKit.name),
            .external(name: SPMDependency.loggingKit.name),
            .external(name: SPMDependency.networkKit.name)
        ],
    )
    
    public static let mainFlowTarget = Target.target(
        name: SPMDependency.unspMainFlow.name,
        destinations: .iOS,
        product: resolvedFramework(),
        bundleId: "dev.tuist\(SPMDependency.unspMainFlow.name)",
        infoPlist: .default,
        sources: [
            "Tuist/.build/checkouts/UnspMainFlow/UnspMainFlow/Sources/**"
        ],
        dependencies: [
            .external(name: SPMDependency.keychainStorageKit.name),
            .external(name: SPMDependency.helpersSharedUnsp.name),
            .external(name: SPMDependency.snapKitWrapper.name),
            .external(name: SPMDependency.coreKit.name),
            .external(name: SPMDependency.loggingKit.name),
            .external(name: SPMDependency.networkKit.name)
        ],
    )
}

/// MARK: - Helpers
fileprivate enum Source {
    typealias SourceLiteral = SourceFilesList.ArrayLiteralElement
    
    static let appSources: SourceLiteral = "\(ProjectConstants.appName)/Sources/**"
    static let appLifecycle: SourceLiteral = "\(ProjectConstants.appName)/AppLifecycle/**"
}

fileprivate enum Resource {
    typealias ResourceLiteral = ResourceFileElements.ArrayLiteralElement
    
    static let appResources: ResourceLiteral = "\(ProjectConstants.appName)/Resources/**"
}

Pod::Spec.new do |spec|
    spec.name         = 'EquationKit'
    spec.version      = '0.0.1'
    spec.ios.deployment_target = "10.0"
    spec.osx.deployment_target = "10.9"
    spec.tvos.deployment_target = "9.0"
    spec.watchos.deployment_target = "2.0"
    spec.license      = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
    spec.summary      = 'Differentiate and evaluate multivariate polynomials in pure Swift'
    spec.homepage     = 'https://github.com/Sajjon/EquationKit'
    spec.author       = 'Alex Cyon'
    spec.source       = { :git => 'https://github.com/Sajjon/EquationKit', :tag => 'v' + String(spec.version) }
    spec.source_files = 'sources/*.swift'
    spec.social_media_url = 'https://twitter.com/alexcyon'
end
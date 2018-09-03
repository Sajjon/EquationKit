Pod::Spec.new do |s|
    s.name                      = 'EquationKit'
    s.version                   = '0.0.6'
    s.ios.deployment_target     = "10.0"
    s.osx.deployment_target     = "10.9"
    s.tvos.deployment_target    = "9.0"
    s.watchos.deployment_target = "2.0"
    s.license                   = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
    s.summary                   = 'Differentiate and evaluate multivariate polynomials in pure Swift'
    s.homepage                  = 'https://github.com/Sajjon/EquationKit'
    s.author                    = 'Alex Cyon'
    s.source                    = { :git => 'https://github.com/Sajjon/EquationKit.git', :tag => s.version.to_s }
    s.source_files              = 'Source/**/*.swift'
    s.resources                 = 'Support/**/*.swift'
    s.social_media_url          = 'https://twitter.com/alexcyon'
end
Pod::Spec.new do |s|
s.name             = 'tippecanoe-swift'
s.version          = '1.15.4'
s.summary          = 'Tippecanoe library with swift bindings'

s.homepage         = 'https://github.com/cropio/tippecanoe-swift'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Evgeny Kalashnikov' => 'lumyk@me.com' }
s.source           = { :git => 'https://github.com/cropio/tippecanoe-swift.git', :tag => s.version.to_s }

s.ios.deployment_target = '10.0'
s.source_files = 'Sources/*.swift', 'Sources/tippecanoe/**/*.{h,c,cpp,hpp}'
s.private_header_files = 'Sources/tippecanoe/**/*.{h,hpp}'
s.libraries = 'sqlite3', 'z', 'c++'
s.preserve_paths  = 'Sources/tippecanoe/module.modulemap'
s.pod_target_xcconfig = {
  'SWIFT_INCLUDE_PATHS' => '${PODS_TARGET_SRCROOT}/Sources/tippecanoe/**',
  'LIBRARY_SEARCH_PATHS' => '${PODS_TARGET_SRCROOT}/Sources/tippecanoe',
}

end

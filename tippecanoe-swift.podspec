Pod::Spec.new do |s|
  s.name             = 'tippecanoe-swift'
  s.version          = `git describe --abbrev=0 --tags`
  s.summary          = 'Tippecanoe library with swift bindings'

  s.homepage         = 'https://github.com/cropio/tippecanoe-swift'
  s.author           = { 'Evgeny Kalashnikov' => 'lumyk@me.com' }
  s.source           = { :git => 'https://github.com/cropio/tippecanoe-swift.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.2'
  s.source_files = 'Sources/**/*.{swift,cpp,hpp}'
  s.public_header_files = 'Sources/CBindings/include/*.{hpp}'
  s.libraries = 'sqlite3', 'z', 'c++'
  s.prepare_command = "sh install.sh"
  s.pod_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => '${PODS_TARGET_SRCROOT}/Sources/tippecanoe',
    'OTHER_CFLAGS' => '-DTARGET_OS_IPHONE=1',
    'GCC_OPTIMIZATION_LEVEL' => '3',
    'GCC_WARN_INHIBIT_ALL_WARNINGS' => 'YES'
  }

  s.subspec 'tippecanoe' do |s|
    s.exclude_files = 'Sources/tippecanoe/main.cpp'
    s.source_files = [
      'Sources/tippecanoe/*.{c,h,cpp,hpp}',
      'Sources/tippecanoe/{catch,jsonpull,milo,protozero,mapbox}/**/*.{c,h,cpp,hpp}'
    ]
    #need for moving other headers to project headers
    s.public_header_files = 'Sources/tippecanoe/version.hpp'
    s.private_header_files = 'Sources/tippecanoe/*.{h,hpp}'
  end
end

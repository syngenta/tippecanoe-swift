Pod::Spec.new do |s|
s.name             = 'tippecanoe-swift'
s.version          = '1.1.0'
s.summary          = 'Tippecanoe library with swift bindings'

s.homepage         = 'https://github.com/cropio/tippecanoe-swift'
s.author           = { 'Evgeny Kalashnikov' => 'lumyk@me.com' }
s.source           = { :git => 'https://github.com/cropio/tippecanoe-swift.git', :tag => s.version.to_s }

s.ios.deployment_target = '10.0'
s.swift_version = '5.2'
s.source_files = 'Sources/*.{swift,cpp,hpp}'
s.libraries = 'sqlite3', 'z', 'c++'
s.prepare_command = "sh install.sh"
s.pod_target_xcconfig = {
  'HEADER_SEARCH_PATHS' => '${PODS_TARGET_SRCROOT}/Sources/tippecanoe',
  'OTHER_CFLAGS' => '-DTARGET_OS_IPHONE=1',
  'GCC_OPTIMIZATION_LEVEL' => '3',
  'GCC_WARN_INHIBIT_ALL_WARNINGS' => 'YES'
}

s.subspec 'tippecanoe' do |ss|
  ss.source_files = [
    'Sources/tippecanoe/*.{c,h,cpp,hpp}',
    'Sources/tippecanoe/{catch,jsonpull,milo,protozero}/**/*.{c,h,cpp,hpp}'
  ]
  ss.private_header_files = [
    'Sources/tippecanoe/*.{h,hpp}',
    'Sources/tippecanoe/{catch,jsonpull,milo,protozero}/**/*.{h,hpp}'
  ]
  ss.exclude_files = [
    'Sources/tippecanoe/config.hpp',
    'Sources/tippecanoe/protozero/version.hpp'#,
    # 'Sources/tippecanoe/geometry.hpp'
  ]

  ss.subspec 'mapbox' do |ss|
    ss.source_files = 'Sources/tippecanoe/mapbox/*.{c,h,cpp,hpp}'
    ss.private_header_files = 'Sources/tippecanoe/mapbox/*.{h,hpp}'
    ss.exclude_files = [
      'Sources/tippecanoe/mapbox/geometry/snap_rounding.hpp',
      # 'Sources/tippecanoe/mapbox/geometry.hpp',
      'Sources/tippecanoe/mapbox/geometry/point.hpp',
      'Sources/tippecanoe/mapbox/geometry/wagyu/config.hpp'
    ]
    ss.subspec 'geometry' do |ss|
      ss.source_files = 'Sources/tippecanoe/mapbox/geometry/**/*.{c,h,cpp,hpp}'
      ss.private_header_files = 'Sources/tippecanoe/mapbox/geometry/**/*.{h,hpp}'
    end
  end
end
end

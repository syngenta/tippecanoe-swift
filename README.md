# tippecanoe-swift

[![Build Status](https://travis-ci.org/cropio/tippecanoe-swift.svg?branch=master)](https://travis-ci.org/cropio/tippecanoe-swift) [![codecov](https://codecov.io/gh/cropio/tippecanoe-swift/branch/master/graph/badge.svg)](https://codecov.io/gh/cropio/tippecanoe-swift)

Tippecanoe library with swift bindings. Tippecanoe version 1.36.0

## Instalation
For installation you can use cocoapods

```ruby
pod 'tippecanoe-swift'
```

For using pods you need to add custom source

```ruby
source 'https://github.com/cropio/cocoapods-specs.git'
```

## Use

### Rendering

For creating **mbtiles**, you need **geoJson** file.
GeoJson struct must be like this (one feature on one line for parallel rendering):

```json
{ "type": "Feature", "properties": {}, "geometry": {"type": "Polygon","coordinates": [ [ [ 30.997678041458126, 50.61926693879273 ], [ 30.998557806015015, 50.61817778516343 ], [ 31.002130508422848, 50.61930097443724 ], [ 31.001336574554443, 50.620362874173026 ], [ 30.997678041458126, 50.61926693879273 ] ]] } }
{ "type": "Feature", "properties": {}, "geometry": {"type": "Polygon","coordinates": [ [ [ 31.006894111633297, 50.628653036173056 ], [ 31.00822448730469, 50.62772744196726 ], [ 31.008889675140384, 50.62789078344531 ], [ 31.008374691009518, 50.62872109385136 ], [ 31.007966995239258, 50.62917027205732 ], [ 31.006894111633297, 50.628653036173056 ] ]] } }
```
One **Feature** for one line (<span style="color:red">**It is important!**</span>)

Using in swift
```swift
// path to geoJson file
guard let input = Bundle.main.path(forResource: "polygons", ofType: "json") else {
    return
}

let manager = TippecanoeManager()

// output path
let output = NSTemporaryDirectory().appending("out.mbtiles")
let options = TippecanoeOptions(
    input: input,
    output: output,
    maxzoom: 10, // default 13
    minzoom: 0, // default 0
    fullDetail: 12, // default 12
    lowDetail: 12, // default 12
    minimumDetail: 7, // default 7
    layer: "polygons",
    rewrite: true, // default true
    dropRate: .rg, // default .default
    baseZoom: .Bg, // default .default
    noStat: true, // default true
    noTileCompression: false, // default false
    parallel: true, // default false (file structure must be one feature on one line)
    quiet: true // default true
)

manager.render(with: options, progress: { progress in
    print(progress) // return render progress 0 - 100
}, completion: { result in
    switch result {
    case .success:
        print("done - \(output)")
    case .failure(let error):
        print("failure - \(error)")
    }
})
```

### Join

```swift
let manager = TippecanoeManager()

let input1 = NSTemporaryDirectory().appending("input1.mbtiles")
let input2 = NSTemporaryDirectory().appending("input2.mbtiles")
let output = NSTemporaryDirectory().appending("joined.mbtiles")

let options = TileJoinOptions(input1: input1, input2: input2, output: output)

manager.join(with: options) { result in
    switch result {
    case .success:
        print("done - \(output)")
    case .failure(let error):
        print("failure - \(error)")
    }
}
```

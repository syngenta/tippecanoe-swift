# tippecanoe-swift

[![Build Status](https://travis-ci.org/cropio/tippecanoe-swift.svg?branch=master)](https://travis-ci.org/cropio/tippecanoe-swift) [![codecov](https://codecov.io/gh/cropio/tippecanoe-swift/branch/master/graph/badge.svg)](https://codecov.io/gh/cropio/tippecanoe-swift)

Tippecanoe library with swift bindings

### Instalation
For installation you can use cocoapods

```ruby
pod 'tippecanoe-swift'
```

For using pods you need to add custom source

```ruby
source 'https://github.com/cropio/cocoapods-specs.git'
```

### Use

For creating **mbtiles**, you need **geoJson** file.
GeoJson struct must be like this:

```json
{ "type": "Feature", "properties": {}, "geometry": {"type": "Polygon","coordinates": [ [ [ 30.997678041458126, 50.61926693879273 ], [ 30.998557806015015, 50.61817778516343 ], [ 31.002130508422848, 50.61930097443724 ], [ 31.001336574554443, 50.620362874173026 ], [ 30.997678041458126, 50.61926693879273 ] ]] } }
{ "type": "Feature", "properties": {}, "geometry": {"type": "Polygon","coordinates": [ [ [ 31.006894111633297, 50.628653036173056 ], [ 31.00822448730469, 50.62772744196726 ], [ 31.008889675140384, 50.62789078344531 ], [ 31.008374691009518, 50.62872109385136 ], [ 31.007966995239258, 50.62917027205732 ], [ 31.006894111633297, 50.628653036173056 ] ]] } }
```
One **Feature** for one line (<span style="color:red">**It is important!**</span>)

Using in swift
```swift
// path to geoJson file
guard let input = Bundle.main.path(forResource: "poligons", ofType: "json") else {
    return
}

// output path
let output = NSTemporaryDirectory().appending("out.mbtiles")
let tpc = Tippecanoe(input: input, output: output)

tpc.render(progress: { progress in
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

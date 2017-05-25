// REQUIRES: objc_interop
// RUN: rm -rf %t.mod && mkdir -p %t.mod
// RUN: %target-swift-frontend -emit-module -o %t.mod/Cities.swiftmodule %S/Inputs/Cities.swift -module-name Cities -parse-as-library
// RUN: rm -rf %t && mkdir -p %t && %target-swift-frontend -c -update-code -disable-migrator-fixits -primary-file %s  -I %t.mod -api-diff-data-file %S/API.json -emit-migrated-file-path %t/rename-func-decl.swift.result -o %t/rename-func-decl.swift.remap -o /dev/null
// RUN: diff -u %S/rename-func-decl.swift.expected %t/rename-func-decl.swift.result

import Cities

class MyCities : MoreCities {
  func setZooLocation(x ix: Int, y iy: Int, z iz: Int) {}
}
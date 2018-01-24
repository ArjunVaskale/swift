// RUN: %target-swift-frontend %s -emit-ir -g -o - | %FileCheck %s
// RUN: %target-swift-frontend %s -emit-ir -g -o - | %FileCheck %s --check-prefix=CHECK2

// UNSUPPORTED: OS=watchos

func use<T>(_ t: T) {}

public func f(_ i : Int?)
{
  // CHECK: define {{.*}}@"$S4main1fyySiSgF"
  // CHECK1: %debug.copy = alloca %TSiSg
  // CHECK1: @llvm.dbg.declare(metadata %TSiSg* %debug.copy
  // CHECK1: @llvm.dbg.declare(metadata {{(i32|i64)}}* %val.addr, {{.*}}, !dbg ![[DBG0:.*]]
  // CHECK1: ![[F:.*]] = distinct !DISubprogram(name: "f",
  // CHECK1: ![[BLK:.*]] = distinct !DILexicalBlock(scope: ![[F]],
  // CHECK1: ![[DBG0]] = !DILocation(line: [[@LINE+2]],
  // CHECK1: ![[DBG1]] = !DILocation(line: 0, scope: ![[BLK]])
  guard let val = i else { return }
  use(val)
}

// With large type optimizations the string is passed indirectly on i386 so
// there is no shadow copy happening.
// UNSUPPORTED: CPU=i386

public func g(_ s : String?)
{
  // CHECK2: define {{.*}}@"$S4main1gyySSSgF"
  // CHECK2: %debug.copy = alloca %TSSSg
  // CHECK2: @llvm.dbg.declare(metadata %TSSSg*
  // CHECK2: %debug.copy1 = alloca %TSS
  // CHECK2: @llvm.dbg.declare(metadata %TSS*
  // CHECK2: ![[G:.*]] = distinct !DISubprogram(name: "g"
  guard let val = s else { return }
  use(val)
}

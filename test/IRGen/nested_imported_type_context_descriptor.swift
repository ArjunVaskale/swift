// RUN: %target-swift-frontend -emit-ir %s -import-objc-header %S/Inputs/nested_imported_type_context_descriptor.h | %FileCheck %s
// REQUIRES: objc_interop

// Nominal type descriptors for the imported type X and both of its nested
// anonymous struct should get emitted as ODR.

// CHECK-DAG: @"$SSo1XVMn" = linkonce_odr hidden constant
// CHECK-DAG: @"$SSo1XV32__Unnamed_struct_nestedTypeFieldVMn" = linkonce_odr hidden constant
// CHECK-DAG: @"$SSo1XV37__Unnamed_struct_otherNestedTypeFieldVMn" = linkonce_odr hidden constant

public func force_metadata() {
  print(X().nestedTypeField)
  print(X().otherNestedTypeField)
}

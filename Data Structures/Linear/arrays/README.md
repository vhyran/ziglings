# Arrays in Zig

This document provides an overview of working with arrays in the Zig programming language, including both static and dynamic arrays, and demonstrates common operations such as initialization, iteration, and memory management.

---

## Introduction to Arrays

An array in Zig is a fixed-size or dynamically allocated collection of elements of the same type. Arrays are a core feature of the language and support both compile-time and runtime operations.

---

## Static Arrays

### Definition:
A static array has a fixed size known at compile time. Its memory is allocated on the stack.

### Example:
```zig
const array: [5]i32 = [_]i32{1, 2, 3, 4, 5};

pub fn main() void {
    for (array) |item, index| {
        std.debug.print("array[{}] = {}\n", .{index, item});
    }
}
```

### Key Features:
- Fixed size.
- Memory allocated on the stack.
- Can be initialized with default values using `_` syntax.

---

## Dynamic Arrays

### Definition:
A dynamic array has a size determined at runtime. Its memory is allocated on the heap.

### Example:
```zig
const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var array = try allocator.alloc(i32, 5);
    defer allocator.free(array);

    // Initialize array
    for (array) |*, index| {
        array[index] = index + 1;
    }

    // Print array elements
    for (array) |item, index| {
        std.debug.print("array[{}] = {}\n", .{index, item});
    }
}
```

### Key Features:
- Size determined at runtime.
- Memory allocated on the heap.
- Requires explicit memory management with allocators.

---

## Memory Management

When working with dynamic arrays, it is essential to manage memory properly to avoid memory leaks.

### Allocating Memory:
```zig
var array = try allocator.alloc(i32, size);
```

### Freeing Memory:
```zig
defer allocator.free(array);
```

Use the `defer` statement to ensure that memory is freed when it is no longer needed.

---

## Example Code

Here is a comprehensive example demonstrating static and dynamic arrays:

```zig
const std = @import("std");

pub fn main() !void {
    // Static array
    const staticArray = [_]i32{10, 20, 30, 40, 50};
    for (staticArray) |item, index| {
        std.debug.print("staticArray[{}] = {}\n", .{index, item});
    }

    // Dynamic array
    const allocator = std.heap.page_allocator;
    var dynamicArray = try allocator.alloc(i32, 5);
    defer allocator.free(dynamicArray);

    for (dynamicArray) |*, index| {
        dynamicArray[index] = index * 10;
    }

    for (dynamicArray) |item, index| {
        std.debug.print("dynamicArray[{}] = {}\n", .{index, item});
    }
}
```

---

## Testing Arrays

### Writing Tests:
The following test validates the functionality of a dynamic array:

```zig
const std = @import("std");
const expect = std.testing.expect;

pub fn testDynamicArray() void {
    const allocator = std.testing.allocator;
    var array = try allocator.alloc(i32, 3);
    defer allocator.free(array);

    array[0] = 100;
    array[1] = 200;
    array[2] = 300;

    try expect(array[0] == 100);
    try expect(array[1] == 200);
    try expect(array[2] == 300);
}
```

### Running Tests:
Run the tests using the Zig test framework:
```sh
zig test file_name.zig
```

---

## Conclusion

Arrays in Zig are versatile and powerful. Static arrays are great for fixed-size collections, while dynamic arrays provide flexibility for runtime operations. Proper memory management is crucial when working with dynamic arrays. With the knowledge from this document, you can efficiently implement and test arrays in your Zig programs.


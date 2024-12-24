# Singly and Doubly Linked List Implementation in Zig

This project demonstrates the implementation of both singly and doubly linked lists in the Zig programming language. The code provides functionality to create, append, prepend, print, and free nodes in these data structures.

## Features

### Singly Linked List

- **Node Creation:** Nodes contain an integer value and a pointer to the next node.
- **Append:** Add a new node to the end of the list.
- **Print:** Display the list in forward order.
- **Free:** Release memory allocated for the nodes.

### Doubly Linked List

- **Node Creation:** Nodes contain an integer value and pointers to the previous and next nodes.
- **Append:** Add a new node to the end of the list.
- **Prepend:** Add a new node to the beginning of the list.
- **Print:** Display the list in forward and reverse order.
- **Free:** Release memory allocated for the nodes.

## Code Overview

### Singly Linked List

#### Node Structure
```zig
const Node = struct {
    value: i32,
    next: ?*Node,
};
```

#### Node Management

- **Append Node**
  ```zig
  pub fn append(head: ?*Node, value: i32, allocator: *const std.mem.Allocator) !?*Node {
      const new_node = try allocator.create(Node);
      new_node.* = Node{ .value = value, .next = null };
      if (head == null) {
          return new_node;
      }

      var current = head;
      while (current) |current_node| {
          if (current_node.next == null) {
              current_node.next = new_node;
              break;
          }
          current = current_node.next;
      }
      return head;
  }
  ```

- **Free List**
  ```zig
  pub fn freeList(head: ?*Node, allocator: *const std.mem.Allocator) void {
      var current = head;
      while (current) |node| {
          const next = node.next;
          allocator.destroy(node);
          current = next;
      }
  }
  ```

#### Printing the List
```zig
pub fn printList(head: ?*Node) void {
    var current = head;
    while (current) |node| {
        std.debug.print("{} -> ", .{node.value});
        current = node.next;
    }
    std.debug.print("null\n", .{});
}
```

### Doubly Linked List

#### Node Structure
```zig
const Node = struct {
    value: i32,
    prev: ?*Node,
    next: ?*Node,
};
```

#### Node Management

- **Create Node**
  ```zig
  pub fn createNode(value: i32, allocator: *std.mem.Allocator) !*Node {
      const node = try allocator.create(Node);
      node.* = Node{ .value = value, .prev = null, .next = null };
      return node;
  }
  ```

- **Free List**
  ```zig
  pub fn freeList(head: ?*Node, allocator: *std.mem.Allocator) void {
      var current = head;
      while (current) |node| {
          const next = node.next;
          allocator.destroy(node);
          current = next;
      }
  }
  ```

#### List Operations

- **Append Node**
  ```zig
  pub fn append(head: ?*Node, value: i32, allocator: *std.mem.Allocator) !?*Node {
      const new_node = try createNode(value, allocator);
      if (head == null) {
          return new_node;
      }

      var current = head;
      while (current.*.next) |next_node| {
          current = next_node;
      }

      current.*.next = new_node;
      new_node.*.prev = current;
      return head;
  }
  ```

- **Prepend Node**
  ```zig
  pub fn prepend(head: ?*Node, value: i32, allocator: *std.mem.Allocator) !*Node {
      const new_node = try createNode(value, allocator);
      if (head != null) {
          head.*.prev = new_node;
          new_node.*.next = head;
      }
      return new_node;
  }
  ```

#### Printing the List

- **Print Forward**
  ```zig
  pub fn printList(head: ?*Node) void {
      var current = head;
      while (current) |node| {
          std.debug.print("{} <-> ", .{node.value});
          current = node.next;
      }
      std.debug.print("null\n", .{});
  }
  ```

- **Print Reverse**
  ```zig
  pub fn printReverse(head: ?*Node) void {
      var current = head;
      if (current == null) return;

      // Go to the last node
      while (current.*.next) |next_node| {
          current = next_node;
      }

      // Print in reverse order
      while (current) |node| {
          std.debug.print("{} <-> ", .{node.value});
          current = node.prev;
      }
      std.debug.print("null\n", .{});
  }
  ```

### Testing

#### Singly Linked List Test
```zig
test "singly linked list" {
    const allocator = std.testing.allocator;

    var head: ?*Node = null;

    head = try append(head, 10, allocator);
    head = try append(head, 20, allocator);
    head = try append(head, 30, allocator);

    const expected = [_]i32{ 10, 20, 30 };
    var index: usize = 0;

    var current = head;
    while (current) |node| {
        try std.testing.expect(node.value == expected[index]);
        current = node.next;
        index += 1;
    }
    try std.testing.expect(index == 3);

    printList(head);
    freeList(head, allocator);
}
```

#### Doubly Linked List Test
```zig
test "doubly linked list" {
    const allocator = std.testing.allocator;

    var head: ?*Node = null;

    head = try append(head, 10, allocator);
    head = try append(head, 20, allocator);
    head = try append(head, 30, allocator);

    head = try prepend(head, 5, allocator);

    var current = head;
    const expected = [_]i32{ 5, 10, 20, 30 };
    var index: usize = 0;

    while (current) |node| {
        try std.testing.expect(node.value == expected[index]);
        current = node.next;
        index += 1;
    }
    try std.testing.expect(index == 4);

    printList(head);
    printReverse(head);
    freeList(head, allocator);
}
```

## How to Run

1. Install [Zig](https://ziglang.org/).
2. Save the code into a `.zig` file.
3. Run the tests:
   ```bash
   zig test <filename>.zig
   ```
4. Observe the output, including the traversal of the lists.

## Example Output

### Singly Linked List
```
10 -> 20 -> 30 -> null
```

### Doubly Linked List
```
5 <-> 10 <-> 20 <-> 30 <-> null
30 <-> 20 <-> 10 <-> 5 <-> null
```


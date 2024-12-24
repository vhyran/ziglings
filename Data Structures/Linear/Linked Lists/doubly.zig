const std = @import("std");

const Node = struct {
    value: i32,
    prev: ?*Node, // Pointer to the previous node
    next: ?*Node, // Pointer to the next node
};

pub fn createNode(value: i32, allocator: *std.mem.Allocator) !*Node {
    const node = try allocator.create(Node);
    node.* = Node{ .value = value, .prev = null, .next = null };
    return node;
}

pub fn freeList(head: ?*Node, allocator: *std.mem.Allocator) void {
    var current = head;
    while (current) |node| {
        const next = node.next;
        allocator.destroy(node);
        current = next;
    }
}

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

pub fn prepend(head: ?*Node, value: i32, allocator: *std.mem.Allocator) !*Node {
    const new_node = try createNode(value, allocator);
    if (head != null) {
        head.*.prev = new_node;
        new_node.*.next = head;
    }
    return new_node;
}

pub fn printList(head: ?*Node) void {
    var current = head;
    while (current) |node| {
        std.debug.print("{} <-> ", .{node.value});
        current = node.next;
    }
    std.debug.print("null\n", .{});
}

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

test "doubly linked list" {
    const allocator = std.testing.allocator;

    var head: ?*Node = null;

    // Append values
    head = try append(head, 10, allocator);
    head = try append(head, 20, allocator);
    head = try append(head, 30, allocator);

    // Prepend a value
    head = try prepend(head, 5, allocator);

    // Verify values
    var current = head;
    const expected = [_]i32{ 5, 10, 20, 30 };
    var index: usize = 0;

    while (current) |node| {
        try std.testing.expect(node.value == expected[index]);
        current = node.next;
        index += 1;
    }
    try std.testing.expect(index == 4);

    // Print the list
    printList(head);

    // Print in reverse
    printReverse(head);

    // Free the list
    freeList(head, allocator);
}

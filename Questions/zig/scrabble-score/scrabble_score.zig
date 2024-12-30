pub fn score(s: []const u8) u32 {
    var result: u32 = 0;
    for (s) |c| {
        result += switch (c) {
            'A', 'a', 'E', 'e', 'I', 'i', 'O', 'o', 'U', 'u', 'L', 'l', 'N', 'n', 'R', 'r', 'S', 's', 'T', 't' => 1,
            'D', 'd', 'G', 'g' => 2,
            'B', 'b', 'C', 'c', 'M', 'm', 'P', 'p' => 3,
            'F', 'f', 'H', 'h', 'V', 'v', 'W', 'w', 'Y', 'y' => 4,
            'K', 'k' => 5,
            'J', 'j', 'X', 'x' => 8,
            'Q', 'q', 'Z', 'z' => 10,
            else => 0,
        };
    }
    return result;
}

pub const ComputationError = error{
    IllegalArgument,
};

pub fn steps(number: usize) !usize {
    if (number < 1) {
        return ComputationError.IllegalArgument;
    }
    var input = number;
    var answer: usize = 0;
    while (input > 1) {
        input = switch (input % 2) {
            0 => input / 2,
            else => 3 * input + 1,
        };
        answer += 1;
    }
    return answer;
}

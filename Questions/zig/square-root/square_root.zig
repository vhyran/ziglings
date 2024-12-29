pub fn squareRoot(radicand: usize) usize {
    if (radicand == 0 or radicand == 1) {
        return radicand;
    }
    var low: usize = 1;
    var high: usize = radicand;
    var result: usize = 0;
    while (low <= high) {
        const mid = (low + high) / 2;
        const midSquare = mid * mid;
        if (midSquare == radicand) {
            return mid;
        } else if (midSquare < radicand) {
            low = mid + 1;
            result = mid;
        } else {
            high = mid - 1;
        }
    }
    return result;
}

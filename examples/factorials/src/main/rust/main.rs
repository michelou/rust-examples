// https://oopscenities.net/2023/02/22/factorial-in-rust-vs-factorial-in-c/

fn factorial(n : i32) -> i32 {
    if n <= 1 {
        return n;
    }

    return n * factorial(n - 1);
}

fn non_recursive_factorial(mut n : i32) -> i32 {
    let mut r = 1;

    while n >= 1 {
        r *= n;
        n -= 1;
    }

    return r;
}

fn factorial_with_for(n : i32) -> i32 {
    let mut r = 1;

    for i in 2..n + 1 {
        r *= i;
    }

    return r;
}

fn main() {
    let n = 10;
    println!("factorial({}) = {}", n, factorial(n));
    println!("non_recursive_factorial({}) = {}", n, non_recursive_factorial(n));
    println!("factorial_with_for({}) = {}", n, factorial_with_for(n));
}

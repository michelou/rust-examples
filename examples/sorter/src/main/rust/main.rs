extern crate rand;
extern crate rayon;

//use rand::Rng;
use rayon::prelude::*;

fn main() {
    let rng = rand::rng();
    let mut numbers: Vec<i8> = rng.gen_iter().take(10).collect();
    println!("random numbers: {:?}", numbers);

    numbers.par_sort(); // now sorting in parallel threads!
    println!("sorted numbers: {:?}", numbers);
}

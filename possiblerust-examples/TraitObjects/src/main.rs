use std::f64::consts::PI;

/// Defines how to get the area of a shape.
trait Area {
    fn area(&self) -> f64;
}

/// A rectangular shape with a width and height.
struct Rectangle {
    width: f64,
    height: f64,
}

impl Area for Rectangle {
    // Area for a rectangle is width times height.
    fn area(&self) -> f64 {
        self.width * self.height
    }
}

/// A circular shape with a radius.
struct Circle {
    radius: f64,
}

impl Area for Circle {
    // Area for a circle is PI * r^2
    fn area(&self) -> f64 {
        PI * self.radius * self.radius
    }
}

fn main() {
    // Make a `Vec` that holds trait objects based on the `Area`
    // trait. This lets the `Vec` hold different concrete types
    // by putting them behind a pointer, which hides what type
    // is actually there, and dispatches to the correct method
    // implementations at runtime!
    let shapes: Vec<Box<dyn Area>> = vec![
        Box::new(Rectangle { width: 2.0, height: 3.0 }),
        Box::new(Circle { radius: 4.0 })
    ];

    for shape in &shapes {
        println!("{}", shape.area());
    }
}

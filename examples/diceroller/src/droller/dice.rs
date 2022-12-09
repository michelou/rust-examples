use crate::droller::Die;
use paste::paste;

macro_rules! gen_dice_fn_for {
    ( $( $x:expr ),* ) => {
        paste! {
            $(
            #[allow(dead_code)]
            pub fn [<d$x>]() -> Die {
                Self::new($x)
            }
            )*
        }
    };
}

impl Die {
    pub fn new(faces: u8) -> Die {
        if faces == 0 { panic!("Value must be strictly positive {}", faces); }
        Die { faces }
    }
    gen_dice_fn_for![2, 4, 6, 8, 10, 12, 20, 30, 100];
}

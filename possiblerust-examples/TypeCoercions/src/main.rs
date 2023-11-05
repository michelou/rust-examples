// https://www.possiblerust.com/guide/what-can-coerce-and-where-in-rust

// Turn off some warnings about unreachable code.
#![allow(unreachable_code)]
#![allow(unused_variables)]
#![allow(dead_code)]

/////////////////////////// Downgrade Coercions //////////////////////////////

struct RefHolder<'a> {
    x: &'a i64,
}

impl<'a> RefHolder<'a> {
    fn new(x: &'a i64) -> RefHolder<'a> {
        RefHolder { x }
    }
}

fn print_num(y: &i64) {
    println!("y: {}", y);
}

fn main_downgrade_coercions() {
    // Create `x`
    let mut x = 10;

    // Make sure `y` is `&mut i64`.
    let y = &mut x;

    // Package the downgraded reference into a struct.
    let z = RefHolder::new(y);
    
    // Print `y` downgrading it to an `&i64`.
    print_num(y);
    
    // Use the `z` reference again.
    println!("z.x: {}", z.x);
}

/////////////////////////////// Deref Coercions //////////////////////////////

pub trait Deref {
    type Target: ?Sized;

    /*pub*/ fn deref(&self) -> &Self::Target;
}

pub trait DerefMut: Deref {
    /*pub*/ fn deref_mut(&mut self) -> &mut Self::Target;
}

/////////////////////////// Raw Pointer Coercions ////////////////////////////

#[derive(Debug)]
struct PtrHandle {
    ptr: *const i32,
}

fn main_raw_pointer_coercions() {
    let mut x = 5;
    let ptr = &mut x as *mut i32;

    // The coercion happens on this line, where
    // a `*mut i32` is set as the value for a field
    // with type `*const i32`, coercing to that type.
    let handle = PtrHandle { ptr };

    println!("{:?}", handle);
}

/////////////////////// Reference Pointer Coercions //////////////////////////

// Notice that these coercions work when
// generic types are present too.
#[derive(Debug)]
struct ConstHandle<T> {
    ptr: *const T,
}

#[derive(Debug)]
struct MutHandle<T> {
    ptr: *mut T,
}

fn main_reference_pointer_coercions() {
    let mut x = 5;

    let c_handle = ConstHandle {
        // Coercing `&i32` into `*const i32`
        ptr: &x,
    };

    let m_handle = MutHandle {
        // Coercing `&mut x` into `*mut i32`
        ptr: &mut x,
    };

    println!("{:?}", c_handle);
    println!("{:?}", m_handle);
}

//////////////////////// Function Pointer Coercions //////////////////////////

// This function takes in a function pointer, _not_ a generic type
// which implements one of the function traits (`Fn`, `FnMut`, or
// `FnOnce`).
fn takes_func_ptr(f: fn(i32) -> i32) -> i32 {
    f(5)
}

fn main_function_pointer_coercions() {
    let my_func = |n| n + 2;

    // The coercion happens here, and is possible because `my_func`
    // doesn't capture any variables from its environment.
    println!("{}", takes_func_ptr(my_func));
}

////////////////////////////// Subtype Coercions /////////////////////////////

struct FnHolder {
    f: fn(&'static str) -> i32,
}

fn number_for_name<'a>(name: &'a str) -> i32 {
    match name {
        "Jim" => 32,
        _ => 5,
    }
}

fn main_subtype_coercions() {
    // Voila! A subtype coercion! In this case coercing a
    // lifetime in a contravariant context (the lifetime in
    // the function pointer type parameter) from `'a` to `'static`.
    //
    // `'static` is longer than `'a`, which in this case is safe
    // because it's always fine to make the function _less_ accepting.
    //
    // Once it's been assigned into the `FnHolder` type, it'll only
    // accept string literals (which have a `'static` lifetime).
    let holder = FnHolder { f: number_for_name };
    
    // The extra parentheses are part of the syntax for calling
    // functions as fields, to disambiguate between this and
    // calling a method on the `FnHolder` type.
    println!("{}", (holder.f)("Jim"));
}

//////////////////////////////// Never Coercions /////////////////////////////

struct Value {
    x: bool,
    y: String,
}

fn never() -> ! {
    // `loop`s without some way to exit
    // like this have the `!` type, because
    // the expression (and, in this case,
    // the containing function) will never
    // terminate / return.
    loop {}
}

fn main_never_coercions() {
    let x = never();
    
    let v = Value {
        x: todo!("uhhh I haven't gotten to this"),
        y: unimplemented!("oh, not this either"),
    };
    
    // This program compiles because `never`,
    // `todo!`, and `unimplemented!` all return
    // the `!` type, which coerces into any type.
}

//////////////////////////////// Slice Coercions /////////////////////////////

#[derive(Debug)]
struct SliceHolder<'a> {
    slice: &'a [i32],
}

fn main_slice_coercions() {
    let nums = [1, 2, 3, 4, 5];
    
    // It may not look like, but there's a coercion here!
    //
    // The type of `&nums` is `&[i32; 5]`, which is coerced
    // into `&[i32]` to match the `slice` field on `SliceHolder`.
    let holder = SliceHolder { slice: &nums };
    
    println!("{:#?}", holder);
}

//////////////////////////// Trait Object Coercions //////////////////////////

trait HasInt {
    fn get(&self) -> i32;
}

struct IntHolder {
    x: i32,
}

impl HasInt for IntHolder {
    fn get(&self) -> i32 {
        self.x
    }
}

fn print_int(x: &dyn HasInt) {
    println!("{}", x.get());
}

fn main_trait_object_coercions() {
    let holder = IntHolder { x: 5 };
    // The coercion happens here, from `&IntHolder`
    // into `&dyn HasInt`.
    print_int(&holder);
}

/////////////////////////////////// Main /////////////////////////////////////


fn main() {
    main_downgrade_coercions();
    main_raw_pointer_coercions();
    main_reference_pointer_coercions();
    main_function_pointer_coercions();
    main_subtype_coercions();
    //main_never_coercions();
    main_slice_coercions();
    main_trait_object_coercions();
}

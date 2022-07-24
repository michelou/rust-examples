use std::path::{Path, PathBuf};
use std::error::Error as StdError;
use std::fs::File;
use std::io::{self, Read as _};

type Error = Box<dyn StdError + Send + Sync + 'static>;

// Copied from https://doc.rust-lang.org/src/std/fs.rs.html#198-203
fn initial_buffer_size(file: &File) -> usize {
    // Allocate one extra byte so the buffer doesn't need to grow before the
    // final `read` call at the end of the file.  Don't worry about `usize`
    // overflow because reading will fail regardless in that case.
    file.metadata().map(|m| m.len() as usize + 1).unwrap_or(0)
}

// Adapted from code in https://steveklabnik.com/writing/are-out-parameters-idiomatic-in-rust
pub fn read_to_string<P: AsRef<Path>>(path: P) -> io::Result<String> {
    let mut file = File::open(path.as_ref())?;
    let mut string = String::with_capacity(initial_buffer_size(&file));
    file.read_to_string(&mut string)?;
    Ok(string)
}

fn main() -> Result<(), Error> {
    let file_path =
    if std::env::consts::OS == "windows" {
        "C:\\Temp\\file.txt"
    } else {
        "/tmp/file.txt"
    };
    let _res = std::fs::write(file_path, "Hello John");
    let path0 = {
        let mut path = PathBuf::new();
        path.push("C:\\");
        path.push("temp");
        path.push("file.txt");
        path
    };
    println!("path: {}", path0.to_str().unwrap());

    let mut contents = read_to_string(path0)?;

    println!("{}", contents);

    let path = {
        let mut path = PathBuf::new();
        path.push("some");
        path.push("path");
        path.push("with");
        path.push("a");
        path // the path is now 'some/path/with/a/file.txt'
    };
    println!("path: {}", path.to_str().unwrap());

    contents = read_to_string(path)?;

    println!("{}", contents);

    Ok(())
}

# <span id="top">Book <i>Rust by Example</i></span> <span style="size:30%;"><a href="../README.md">⬆</a></span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://www.rust-lang.org/" rel="external"><img src="../docs/images/rust-logo-blk.svg" width="120" alt="Rust project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This repository gathers <a href="https://www.rust-lang.org/" rel="external">Rust</a> code examples from the online book <a href="https://doc.rust-lang.org/rust-by-example/" rel="external">"Rust by Example"</a> (RBE).<br/>
  It also includes several <a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting">batch files</a> for experimenting with <a href="https://www.rust-lang.org/" rel="external">Rust</a> on a Windows machine.
  </td>
  </tr>
</table>

## <span id="01_Display">`01_Display` Example</span>

This example has the following directory structure :

<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tree" rel="external">tree</a> /a /f . | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr" rel="external">findstr</a> /v /b [A-Z]</b>
|   <a href="./01_Display/build.bat">build.bat</a>
|   <a href="./01_Display/Cargo.toml">Cargo.toml</a>
|   <a href="./01_Display/rustfmt.toml">rustfmt.toml</a>
\---<b>src</b>
        <a href="./01_Display/src/main.rs">main.rs</a>
</pre>

Command [`cargo run`](./01_Display/Cargo.toml) executes the [Rust][rust_lang] program [`main.rs`](./01_Display/src/main.rs) :

<pre style="font-size:80%;">
<b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/" rel="external">cargo</a> clean &amp; <a href="https://doc.rust-lang.org/cargo/commands/" rel="external">cargo</a> run</b>
   Compiling _01_Display v1.0.0 (R:\rust-by-example\01_Display)
    Finished dev [unoptimized + debuginfo] target(s) in 2.81s
     Running `target\debug\main.exe`
Compare structures:
Display: (0, 14)
Debug: MinMax(0, 14)
The big range is (-300, 300) and the small is (-3, 3)
Compare points:
Display: x: 3.3, y: 7.2
Debug: Point2D { x: 3.3, y: 7.2 }
</pre>

## <span id="01_Formatting">`01_Formatting` Example</span>

This example has the following directory structure :

<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tree">tree</a> /a /f . | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr">findstr</a> /v /b [A-Z]</b>
|   <a href="./01_Formatting/build.bat">build.bat</a>
|   <a href="./01_Formatting/Cargo.toml">Cargo.toml</a>
\---<b>src</b>
        <a href="./01_Formatting/src/main.rs">main.rs</a>
</pre>

Command [`build run`](./01_Formatting/build.bat) executes the [Rust][rust_lang] program [`main.rs`](./01_Formatting/src/main.rs) :

<pre style="font-size:80%;">
<b>&gt; <a href="./01_Formatting/build.bat">build</a> -verbose clean run</b>
Compile 1 Rust source file to directory "target"
Dublin: 53.348°N 6.260°W
Oslo: 59.950°N 10.750°E
Vancouver: 49.250°N 123.100°W
Color { red: 128, green: 255, blue: 90 }
Color { red: 0, green: 3, blue: 254 }
Color { red: 0, green: 0, blue: 0 }
</pre>

## <span id="01_HelloWorld">`01_HelloWorld` Example</span>

This example has the following directory structure :

<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr" rel="external">tree</a> /a /f . | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr" rel="external">findstr</a> /v /b [A-Z]</b>
|   <a href="./01_HelloWorld/build.bat">build.bat</a>
|   <a href="./01_HelloWorld/Cargo.toml">Cargo.toml</a>
\---<b>src</b>
        <a href="./01_HelloWorld/src/main.rs">main.rs</a>
</pre>

Command [`build run`](./01_HelloWorld/build.bat) executes the [Rust][rust_lang] program [`main.rs`](./01_HelloWorld/src/main.rs) :

<pre style="font-size:80%;">
<b>&gt; <a href="./01_HelloWorld/build.bat">build</a> -verbose clean run</b>
Delete directory "target"
Compile 1 Rust source files to directory "target"
Hello World!
</pre>

Command [`cargo run`](./01_HelloWorld/Cargo.toml) executes the [Rust][rust_lang] program [`main.rs`](./02_HelloWorld/src/main.rs) :

<pre style="font-size:80%;">
<b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/" rel="external">cargo</a> clean & <a href="https://doc.rust-lang.org/cargo/commands/" rel="external">cargo</a> run</b>
     Removed 0 files
   Compiling _01_HelloWorld v1.0.0 (L:\rust-by-example\01_HelloWorld)
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.43s
     Running `target\debug\main.exe`
Hello World!
</pre>

<!--=======================================================================-->

## <span id="02_Literals">`02_Literals` Example</span> [**&#x25B4;**](#top)

This example has the following directory structure :

<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tree" rel="external">tree</a> /a /f . | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr">findstr</a> /v /b [A-Z]</b>
|   <a href="./02_Literals/build.bat">build.bat</a>
|   <a href="./02_Literals/Cargo.toml">Cargo.toml</a>
\---<b>src</b>
        <a href="./02_Literals/src/main.rs">main.rs</a>
</pre>

Command `cargo run` executes the Rust program [`main.rs`](./02_Literals/src/main.rs) :

<pre style="font-size:80%;">
<b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/" rel="external">cargo</a> clean && <a href="https://doc.rust-lang.org/cargo/commands/" rel="external">cargo</a> run</b>
   Compiling _02_Primitives v1.0.0 (R:\rust-by-example\02_Literals)
    Finished dev [unoptimized + debuginfo] target(s) in 2.53s
     Running `target\debug\main.exe`
1 + 2 = 3
1 - 2 = -1
true AND false is false
true OR false is true
NOT true is false
0011 AND 0101 is 0001
0011 OR 0101 is 0111
0011 XOR 0101 is 0110
1 << 5 is 32
0x80 >> 2 is 0x20
One million is written as 1000000
</pre>

<!--=======================================================================-->

## <span id="02_Primitives">`02_Primitives` Example</span>

<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tree" rel="external">tree</a> /a /f . | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr" rel="external">findstr</a> /v /b [A-Z]</b>
|   <a href="./02_Primitives/build.bat">build.bat</a>
|   <a href="./02_Primitives/Cargo.toml">Cargo.toml</a>
\---<b>src</b>
        <a href="./02_Primitives/src/main.rs">main.rs</a>
</pre>

Command [`build run`](./02_Primitives/build.bat) executes the Rust program [`main.rs`](./02_Primitives/src/main.rs) :

<pre style="font-size:80%;">
<b>&gt; <a href="./02_Primitives/build.bat">build</a> -verbose clean run</b>
Compile 1 Rust source files to directory "target"
[...]
warning: value assigned to `mutable` is never read
  --> R:\rust-by-example\02_Primitives\src\main.rs:27:5
   |
27 |     mutable = true as i32;
   |     ^^^^^^^
   |
   = help: maybe it is overwritten before being read?

warning: 4 warnings emitted

inferred_type: 4294967296
mutable: true
</pre>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/January 2025* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[cargo_cli]: https://doc.rust-lang.org/cargo/commands/cargo.html
[rust_lang]: https://www.rust-lang.org/
[rustc_cli]: https://man.archlinux.org/man/rustc.1.en

# <span id="top">Rust Resources</span> <span style="font-size:90%;">[↩](README.md#top)</span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://www.rust-lang.org/" rel="external"><img src="./docs/images/rust-logo-blk.svg" width="120" alt="Rust project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This document gathers <a href="https://www.rust-lang.org/" rel="external">Rust</a> related resources that caught our attention.
  </td>
  </tr>
</table>

## <span id="articles">Articles</span>

- [**fasterthanli**](https://fasterthanli.me/articles) articles :
  - [Proc macro support in rust-analyzer for nightly rustc versions][article_proc_macro], July 2022.
  - [When rustc explodes][article_explodes], July 2022.
  - [Some mistakes Rust doesn't catch][article_mistakes], February 2022.
  - [Why is my Rust build so slow?][article_slow_build], December 2021.
  - [A half-hour to learn Rust][article_half_hour], January 2020.
- [**fettblog.eu**](https://fettblog.eu/articles) articles by Stefan Baumgartner :
  - [Refactoring in Rust: Introducing Traits][article_baumgartner_traits], March 2023.
  - [Rust: Tiny little traits](https://fettblog.eu/rust-tiny-little-traits/), April 2022.
  - [Idiomatic Rust][article_baumgartner_idiomatic], December 2021.
  - [Serverless Rust][article_baumgartner_serverless], December 2021.
  - [Error handling in Rust][article_baumgartner_error], September 2021.
- [**Red Hat** Developer](https://developers.redhat.com/) articles :
  - [How to create C binding for a Rust library][article_ge] by Gris Ge, September 2022.
  - [How Rust makes Rayon's data parallelism magical][article_stone_2021] by Josh Stone, April 2021.
  - [Speed up your Python using Rust](https://developers.redhat.com/blog/2017/11/16/speed-python-using-rust#) by Bruno Rocha, November 2017.
  - [Getting started with rust-toolset][article_stone_2017] by Josh Stone, November 2017.
- [Intro to Rust: The Modern-Day, Safe Low-Level Programming Language][article_novak] by Marcus Novak, December 2020.
- [The rustwasmc tool](https://www.secondstate.io/articles/rustwasmc/) by Second State, 2020.<br/>(GitHub project: [`second-state/rustwasmc`](https://github.com/second-state/rustwasmc))
- [Introduction to Rust][article_dreimanis] by Gints Dreimanis, August 2020.
- [**opensource.com**](https://opensource.com/) articles :
  - [How to read and write files in Rust](https://opensource.com/article/23/1/read-write-files-rust) by Stephan Avenwedde, January 2023.
  - [Introducing Rust calls to C library functions](https://opensource.com/article/22/11/rust-calls-c-library-functions) by Marty Kalin, November 2022.
  - [Asynchronous programming in Rust](https://opensource.com/article/22/10/asynchronous-programming-rust) by Stephan Avenwedde, October 2022.
  - [Manage your Rust toolchain using rustup](https://opensource.com/article/22/6/rust-toolchain-rustup) by Gaurav Kamathe, June 2022.

  - [Why I'm enjoying learning Rust as a Java programmer][article_bursell] by Mike Bursell, May 2020.
  - [Getting started with the Rust package manager, Cargo](https://opensource.com/article/20/3/rust-cargo) by Gaurav Kamathe, March 2020.
- [Getting started with Cargo][article_cargo] by Gaurav Kamathe, March 2020.
- [Oxide: The Essence of Rust][article_oxide] by Aaron Weiss &amp; al., March 2019.
- [Making a *-sys crate](https://kornel.ski/rust-sys-crate) by Kornel.

## <span id="blogs">Blogs</span> [**&#x25B4;**](#top)

- [Procedural Macros in Rust](https://www.freecodecamp.org/news/procedural-macros-in-rust/) by Anshul Sanghi, April 2024.
- [How I reduced (incremental) Rust compile times by up to 40%](https://www.coderemote.dev/blog/faster-rust-compiler-macro-expansion-caching/), March 2024.
- [Nicholas's Blog posts](https://nnethercote.github.io/) :
  - [How to speed up the Rust compiler in March 2024](https://nnethercote.github.io/2024/03/06/how-to-speed-up-the-rust-compiler-in-march-2024.html), March 2024.
  - [Back-end parallelism in the Rust compiler](https://nnethercote.github.io/2023/07/11/back-end-parallelism-in-the-rust-compiler.html), July 2023.
  - [How to speed up the Rust compiler one last time][blog_nethercote], September 2020.
- [Ferrous Systems Blog posts](https://ferrous-systems.com/blog) :
  - [Allocation-free decoding with traits and high-ranked trait bounds](https://ferrous-systems.com/blog/rustls-borrow-checker-p2/), February 2024.
  - [Using `mem::take` to reduce heap allocations](https://ferrous-systems.com/blog/rustls-borrow-checker-p2/), February 2024.
- [Michael's Blog posts]() :
  - [My Best and Worst Deadlock in Rust](https://www.snoyman.com/blog/2024/01/best-worst-deadlock-rust/), January 2024.
  - [Owned values and Futures in Rust](https://www.snoyman.com/blog/owned-values-and-futures/), September 2023.
- [**Weekly Rust Trivia**](https://www.thorsten-hans.com/tags/weekly-rust-trivia) by Thorsten Hans :
  - [How to use pattern matching][blog_hans_patmat], August 2023.
  - [How to share state between threads][blog_hans_threads], July 2023.
  - [How to write a function-like macro][blog_hans_macro], July 2023.
- [Why Rust is the most admired language among developers][blog_verdi] by Sara Verdi, August 2023.
- [Microsoft is busy rewriting core Windows code in Rust][blog_claburn] by Thomas Claburn, April 2023.
- [Rust : Concepts That We Should Know](https://www.adservio.fr/post/rust-concepts-that-we-should-know), April 2023.
- [C++ vs. Rust: Factorial](https://oopscenities.net/2023/02/22/factorial-in-rust-vs-factorial-in-c/) by [Oopscene](https://twitter.com/oopscene), February 2023.
- [How Rust went from a side project to the world’s most-loved programming language][blog_thompson] by Clive Thompson, February 2023.
- [Rust's Vector][blog_fraenkel_9] by Nicolas Fränkel, August 2021.
- [diceroller, a sample Rust project][blog_fraenkel_8] by Nicolas Fränkel, July 2021.
- [Rust and the JVM][blog_fraenkel_7] by Nicolas Fränkel, July 2021.
- [pretzelhammer's Rust blog](https://github.com/pretzelhammer/rust-blog/tree/master#pretzelhammers-rust-blog-) :
  - [Tour of Rust's Standard Library Traits](https://github.com/pretzelhammer/rust-blog/blob/master/posts/tour-of-rusts-standard-library-traits.md), March 2021.
  - [Sizedness in Rust](https://github.com/pretzelhammer/rust-blog/blob/master/posts/sizedness-in-rust.md), July 2020.
  - [Common Rust Lifetime Misconceptions](https://github.com/pretzelhammer/rust-blog/blob/master/posts/common-rust-lifetime-misconceptions.md), May 2020.
  - [Learning Rust in 2020](https://github.com/pretzelhammer/rust-blog/blob/master/posts/learning-rust-in-2020.md), May 2020.
- [PingCAP Blog](https://en.pingcap.com/blog/) :
  - [A Few More Reasons Rust Compiles Slowly](https://en.pingcap.com/blog/reasons-rust-compiles-slowly/) by Brian Anderson, June 2020.
  - [Rust’s Huge Compilation Units](https://en.pingcap.com/blog/rust-huge-compilation-units/) by Brian Anderson, June 2020.
  - [Generics and Compile-Time in Rust](https://en.pingcap.com/blog/generics-and-compile-time-in-rust/) by Brian Anderson, June 2020.
  - [The Rust Compilation Model Calamity](https://en.pingcap.com/blog/rust-compilation-model-calamity/) by Brian Anderson, January 2020.
- [C++ Is Faster and Safer Than Rust: Benchmarked by Yandex][blog_roman] by Roman, May 2020.
- &#128077; [Why Discord is switching from Go to Rust][blog_howarth] by Jesse Howarth, February 2020.
- [What is Rust and why is it so popular?](https://stackoverflow.blog/2020/01/20/what-is-rust-and-why-is-it-so-popular/) by Jake Goulding, January 2020.
- [varkor's blog](https://varkor.github.io/blog/) :
  - [Idiomatic monads in Rust](https://varkor.github.io/blog/2019/03/28/idiomatic-monads-in-rust.html), March 2019.
  - [Monadic do notation in Rust: Part I](https://varkor.github.io/blog/2018/11/10/monadic-do-notation-in-rust-part-i.html), November 2018.
  - [Feasible functors in Rust](https://varkor.github.io/blog/2018/08/28/feasible-functors-in-rust.html), August 2018.
  - [Existential types in Rust](https://varkor.github.io/blog/2018/07/03/existential-types-in-rust.html), July 2018.
- [Rust Compiler Internals : Mid-level Intermediate Representation (MIR)][blog_kanishkar] by Kanishkar J, December 2019.
- [Using Rust in Windows](https://msrc-blog.microsoft.com/2019/11/07/using-rust-in-windows/), November 2019.
- [Using C Libraries in Rust](https://medium.com/dwelo-r-d/using-c-libraries-in-rust-13961948c72a) by Jeff Hinter, August 2019.
- [Functional Programming Jargon in Rust](https://functional.works-hub.com/learn/functional-programming-jargon-in-rust-1b555) by Jason Shin, July 2019.
- [10 Key Learnings in Rust after 30,000 Lines of Code][blog_nahum] by Dotan Nahum, April 2019.
- [Existential types in Rust][blog_vaktor] by Vaktor, July 2018.
- [Getting started with Rust on the command line](https://asquera.de/blog/2018-01-20/getting-started-with-rust-on-the-command-line/), January 2018.
- [Using C libraries in Rust: make a sys crate][blog_kornelski] by Pornel Kornelski.
- [Fearless Concurrency with Rust][blog_turon] by Aaron Turon, April 2015.

## <span id="books">Books</span> [**&#x25B4;**](#top)

- [The Little Book of Rust Macros](https://veykril.github.io/tlborm/) by Lukas Wirth, July 2024.
- [The Rust Performance Book](https://nnethercote.github.io/perf-book/title-page.html) (online) by Nicholas Nethercote and others, November 2022.
<!-- ISBN 13 (since 2007)
  Registration group: 93 = India
  The last number is the check number (X = 10).
-->
- [Mastering Rust][book_uzayr], by Sufyan bin Uzayr, November 2022.<br/><span style="font-size:80%;">(CRC Press, ISBN 978-1-0323-1901-8, 318 pages)</span>
- [Rust Crash Course](https://bpbonline.com/products/rust-crash-course) by Abhishek Kumar, July 2022.<br/><span style="font-size:80%;">([BPB Online][bpb_online], ISBN 978-93-5551-095-2, 328 pages)</span>
- [Learn Rust Programming](https://https://bpbonline.com/products/learn-rust-programming) by Claus Matzinger, July 2022.<br/><span style="font-size:80%;">([BPB Online][bpb_online], ISBN 978-93-5551-154-6, 268 pages)</span>
 - [Zero to Production in Rust][book_palmieri] by Luca Palmieri, March 2022.<br/><span style="font-size:80%;">(ISBN 979-8847211437, 610 pages)</span>
 - [Beginning Rust][book_milanesi] (2<sup>nd</sup> Ed.) by Carlo Milanesi, 2022.<br/><span style="font-size:80%;">(Apress, ISBN 978-1-4842-7208-4, 413 pages)</span>
- [Rust in Action][book_mcnamara] by Tim McNamara, June 2021.<br/><span style="font-size:80%;">(Manning, ISBN 978-1-6172-9455-6, 456 pages)</span>
- [Programming Rust][book_blandy] (2<sup>nd</sup> Ed.) by Jim Blandy, June 2021.</br><span style="font-size:80%;">(O'Reilly, ISBN 978-1-4920-5259-3, ? pages)</span>
 - [Beginning Rust Programming][book_messier] by Ric Messier, March 2021.<br/><span style="font-size:80%;">(Wiley, ISBN 978-1-119-71297-8, 416 pages)</span>
- [The Rust Programming Language][book_klabnik] by Steve Klabnik and Carol Nichols, August 2019.<br/><span style="font-size:80%;">(No Strach Press, ISBN 978-1-7185-0044-0, 526 pages)</span>
- [Rust Programming Cookbook][book_matzinger] by Claus Matzinger, 2019.<br/><span style="font-size:80%;">(Packt, ISBN 978-1-7895-3066-7, 444 pages)</span>
- [Mastering Rust][book_sharma] (2<sup>nd</sup> Ed.) by Rahul Sharma and Vesa Kaihlavirta, January 2019.<br/><span style="font-size:80%;">(Packt, ISBN 978-1-7893-4657-2, 554 pages)</span>

## <span id="forums">Forums</span>

- [Linux Hint](https://linuxhint.com/) &ndash; [Rust Lang](https://linuxhint.com/category/rust/).
- [Read Rust](https://readrust.net/) collects interesting posts related to the [Rust programming language](https://www.rust-lang.org/).
- [Rust Zulip Chat](https://rust-lang.zulipchat.com/) &ndash; discussions on [Rust][rust_lang] compiler, language, libraries and more.
- [Build exe file for Windows](https://users.rust-lang.org/t/build-exe-file-for-windows/19469), 2018.


## <span id="news">News</span> [**&#x25B4;**](#top)

- [Rust Blog](https://blog.rust-lang.org/) by the Rust Team :
  - [Announcing Rust 1.82.0](https://blog.rust-lang.org/2024/10/17/Rust-1.82.0.html), October 2024 ([*release notes*](https://doc.rust-lang.org/nightly/releases.html#version-1820-2024-10-17)).
  - [Announcing Rust 1.81.0](https://blog.rust-lang.org/2024/09/05/Rust-1.81.0.html), September 2024  ([*release notes*](https://doc.rust-lang.org/nightly/releases.html#version-1810-2024-09-05)).
  - [Announcing Rust 1.80.1](https://blog.rust-lang.org/2024/08/08/Rust-1.80.1.html), August 2024 (*[release notes](https://github.com/rust-lang/rust/releases/tag/1.80.1)*).
  - [Announcing Rust 1.80.0](https://blog.rust-lang.org/2024/07/25/Rust-1.80.0.html), July 2024 (*[release notes](https://github.com/rust-lang/rust/releases/tag/1.80.0)*).
  - [Announcing Rust 1.77.2](https://blog.rust-lang.org/2024/04/09/Rust-1.77.2.html), April 2024 (*[release notes](https://github.com/rust-lang/rust/releases/tag/1.77.2)*).
  - [Announcing Rust 1.77.0](https://blog.rust-lang.org/2024/03/21/Rust-1.77.0.html), March 2024 (*[release notes](https://github.com/rust-lang/rust/releases/tag/1.77.0)*).
  - [Announcing Rust 1.74.1](https://blog.rust-lang.org/2023/12/07/Rust-1.74.1.html), December 2023 (*[release notes](https://github.com/rust-lang/rust/releases/tag/1.74.1)*).
  - [Announcing Rust 1.73.0](https://blog.rust-lang.org/2023/10/05/Rust-1.73.0.html), October 2023 (*[release notes](https://github.com/rust-lang/rust/releases/tag/1.73.0)*).
  - [Announcing Rust 1.72.1](https://blog.rust-lang.org/2023/09/19/Rust-1.72.1.html), September 2023 (*[release notes](https://github.com/rust-lang/rust/releases/tag/1.72.1)*).
  - [Announcing Rust 1.72.0](https://blog.rust-lang.org/2023/08/24/Rust-1.72.0.html), August 2023 (*[release notes](https://github.com/rust-lang/rust/releases/tag/1.72.0)*)
  - [Announcing Rust 1.71.0](https://blog.rust-lang.org/2023/07/13/Rust-1.71.0.html), July 2023 (*[release notes](https://github.com/rust-lang/rust/releases/tag/1.71.0)*).
  - [Announcing Rust 1.70.0](https://blog.rust-lang.org/2023/06/01/Rust-1.70.0.html), June 2023 (*[release notes](https://github.com/rust-lang/rust/releases/tag/1.70.0)*).
  - [Announcing Rust 1.69.0](https://blog.rust-lang.org/2023/04/20/Rust-1.69.0.html), April 2023 (*[release notes](https://github.com/rust-lang/rust/releases/tag/1.69.0)*).
  - [Announcing Rust 1.68.0](https://blog.rust-lang.org/2023/03/09/Rust-1.68.0.html), March 2023 (*[release notes](https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1680-2023-03-09)*)
  - [Announcing Rust 1.67.0](https://blog.rust-lang.org/2023/01/26/Rust-1.67.0.html), January 2023 (*[release notes](https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1670-2023-01-26)*).
  - [Announcing Rust 1.66.0](https://blog.rust-lang.org/2022/12/15/Rust-1.66.0.html), December 2022 (*[release notes](https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1660-2022-12-15)*).
  - [Announcing Rust 1.65.0](https://blog.rust-lang.org/2022/11/03/Rust-1.65.0.html), November 2022 (*[release notes](https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1650-2022-11-03)*).
  - [Announcing Rust 1.64.0](https://blog.rust-lang.org/2022/09/22/Rust-1.64.0.html), September 2022 (*[release notes](https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1640-2022-09-22)*).
  - [Announcing Rust 1.63.0](https://blog.rust-lang.org/2022/08/11/Rust-1.63.0.html), August 2022 (*[release notes](https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1630-2022-08-11)*).
  <!--
  - [Announcing Rust 1.62.1](https://blog.rust-lang.org/2022/07/19/Rust-1.62.1.html), July 2022.
  -->
  - [Announcing Rust 1.62.0](https://blog.rust-lang.org/2022/06/30/Rust-1.62.0.html), June 2022 (*[release notes](https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1620-2022-06-30)*).
  - [Announcing Rust 1.61.0](https://blog.rust-lang.org/2022/05/19/Rust-1.61.0.html), May 2022 (*[release notes](https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1610-2022-05-19)*).
  - [Announcing Rust 1.60.0](https://blog.rust-lang.org/2022/04/07/Rust-1.60.0.html), April 2022 (*[release notes](https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1600-2022-04-07)*).
  - [Announcing Rust 1.59.0](https://blog.rust-lang.org/2022/02/24/Rust-1.59.0.html), February 2022 (*[release notes](https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1590-2022-02-24)*).
  - [Announcing Rust 1.58.0](https://blog.rust-lang.org/2022/01/13/Rust-1.58.0.html), January 2022 (*[release notes](https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1580-2022-01-13)*).
  - [Announcing Rust 1.57.0](https://blog.rust-lang.org/2021/12/02/Rust-1.57.0.html), December 2021 (*[release notes](https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1570-2021-12-02)*).
  - [Announcing Rust 1.56.0](https://blog.rust-lang.org/2021/10/21/Rust-1.56.0.html), October 2021 (*[release notes](https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1560-2021-10-21)*).
  - [Announcing Rust 1.55.0](https://blog.rust-lang.org/2021/09/09/Rust-1.55.0.html), September 2021 (*[release notes](https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1550-2021-09-09)*).
  - [Announcing Rust 1.38.0](https://blog.rust-lang.org/2019/09/26/Rust-1.38.0.html), September 2019 (*[release notes](https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1380-2019-09-26)*).
- [**reddit**](https://www.reddit.com/) [r/rust](https://www.reddit.com/r/rust/) - The Rust Programming Language.
- [Rust Magazine](https://rustmagazine.org/).
- [This Week in Rust][news_this_week].

## <span id="papers">Papers</span>

- [Rust: The Programming Language for Safety and Performance][paper_bugden] by William Bugden and Ayman Alahmar, June 2022.
- [Leveraging Rust types for modular specification and verification](paper_astrauskas) by Vytautas Astrauskas et al., December 2018.
- [Patina: A Formalization of the Rust Programming Language][paper_reed] by Eric Reed, February 2015.

## <span id="projects">Projects</span> [**&#x25B4;**](#top)

- [Druid](https://github.com/linebender/druid) &ndash; a data-first Rust-native UI toolkit.
- [`Miri`](https://rustrepo.com/repo/rust-lang-miri) &ndash; an experimental interpreter for Rust's [mid-level intermediate representation][rust_mir] (MIR).
- [`Redox`](https://www.redox-os.org/) &ndash; a Unix-like Operating System written in [Rust][rust_lang].
- [`ripgrep`][github_ripgrep] &ndash; recursively searches directories for a regex pattern.
- [Rust for Windows](https://github.com/microsoft/windows-rs).
- [`Simphonia`](https://github.com/pdeljanov/Symphonia) &ndash; a multimedia format demuxing, tag reading, and audio decoding library.
- [`winapi-rs`][github_winapi_rs] &ndash; [Rust][rust_lang] bindings to Windows API.

## <span id="training">Training and Tutorials</span> [**&#x25B4;**](#top)

- [100 Exercices To Learn Rust](https://rust-exercises.com/100-exercises/).
- [Rust Cookbook](https://rust-lang-nursery.github.io/rust-cookbook/intro.html).
- [24 days of Rust](https://zsiciarz.github.io/24daysofrust/index.html) by Zbigniew Siciarz, 2023.
- [Rust for the Polyglot Programmer](https://www.chiark.greenend.org.uk/~ianmdlvl/rust-polyglot/) by Ian Jackson and contributors, 2021.
- [A Not so Short Introduction to the Rust Programming Language][tutorial_mueller] by Kasper Müller, November 2021.
- [learn-rust Series](https://dev.to/cthutu/series/13395) by Matt Davies.
  - [Rust #8: Strings](https://dev.to/cthutu/rust-8-strings-53o), August 2021.
  - [Rust #7: Command-Line interfaces](https://dev.to/cthutu/rust-7-command-line-interfaces-4084), August 2021.
  - [Rust #6: Exploring crates](https://dev.to/cthutu/rust-6-exploring-crates-3p6i), July 2021.
  - [Rust #5: Naming conventions](https://dev.to/cthutu/rust-5-naming-conventions-3cjf), July 2021.
  - [Rust #4: Options and Results (Part 2)](https://dev.to/cthutu/rust-4-options-and-results-part-2-5aca), July 2021.
  - [Rust #3: Options, Results and Errors (Part 1)](https://dev.to/cthutu/rust-3-options-results-and-errors-part-1-4d52), July 2021.
  - [Rust #2: Lifetimes, Owners and Borrowers, OH MY! ](https://dev.to/cthutu/rust-2-lifetimes-owners-and-borrowers-oh-my-3fem), June 2021.
  - [Rust #1: Creating your development environment](https://dev.to/cthutu/rust-1-creating-your-development-environment-55bi), June 2021.
- [ferrous systems](https://ferrous-systems.com/) : [Rust Training Programs](https://ferrous-systems.com/training/).
- [Rust Latam &ndash; Rust procedural macros](https://github.com/dtolnay/proc-macro-workshop) by David Tolnay, March 2019.
- [A Gentle Introduction To Rust][tutorial_donovan] by Steve Donovan, 2018.
- [Rust for Haskell Programmers](https://mmhaskell.com/rust).
- [Rust Language Cheat Sheet](https://cheats.rs/).
- [Working with Rust](https://mkaz.blog/working-with-rust/) by Marcus Kazmeierczak.
- [24 Days of Rust](https://siciarz.net/24-days-rust-conclusion-2016/) by Zbigniew Siciarz, December 2016.
  - [Day 1 - cargo subcommands](https://siciarz.net/24-days-rust-cargo-subcommands/)
  - [Day 5 - environment variables](https://siciarz.net/24-days-rust-environment-variables/)
  - [Day 8 - serde](https://siciarz.net/24-days-rust-serde/)

## <span id="tools">Tools and Frameworks</span> [**&#x25B4;**](#top)

- [Actix](https://github.com/actix/actix) &ndash; an Actor framework for [Rust][rust_lang].
- [cargo-ramdisk](https://github.com/PauMAVA/cargo-ramdisk) &ndash; a RAMdisk for faster [Rust][rust_lang] compilation (*Unix only*).
- [Clap](https://clap.rs/) &ndash; a fast and modern CLI framework for [Rust][rust_lang].
- [Clippy](https://github.com/rust-lang/rust-clippy) &ndash; a collection of lints to catch common mistakes and improve your Rust code.
- [diesel](https://github.com/diesel-rs/diesel) &ndash; a safe, extensible ORM and Query Builder for [Rust][rust_lang]. 
- [fleet](https://fleet.rs/) &ndash; a build tool which makes your [Rust][rust_lang] builds up to 5x faster.
- [Fast and safe HTTP for the Rust language](https://hyper.rs/) &ndash; a fast and safe HTTP for [Rust][rust_lang].
- [Lapce](https://github.com/lapce/lapce) &ndash; a lightning-fast and powerful code editor written in [Rust][rust_lang].
- [**nannou**](https://github.com/nannou-org/nannou) &ndash; an open-source creative-coding toolkit for [Rust][rust_lang].
- [redb](https://github.com/cberner/redb) &ndash; an embedded key-value database in pure [Rust][rust_lang]. 
- [rust.analyzer](https://rust-analyzer.github.io/) &ndash; an implementation of [Language Server Protocol](https://microsoft.github.io/language-server-protocol/) for the [Rust][rust_lang] programming language.
- [Rust for Windows](https://github.com/microsoft/windows-rs) &ndash; Rust bindings for the Windows API. 

## <span id="videos">Videos</span>

- [Rust at Microsoft][youtube_levick] by Ryan Levick, May 2020 (0h44).
- [Rust Programming Techniques][youtube_cameron] by Nicholas Cameron, January 2018 (1h32).
- [Rust Concurrency Explained][youtube_crichton] by Alex Crichton, 2017.
- [The Rust Programming Language][youtube_turon] bye Aaron Turon, March 2015 (1h05).

<!--
## <span id="footnotes">Footnotes</span>

<a name="footnote_01">[1]</a> ***Installation settings*** [↩](#anchor_01)

<pre style="margin:0 0 1em 20px; font-size:80%;">
<b>&gt; type %USERPROFILE%\.rustup\settings.toml</b>
default_host_triple = "x86_64-pc-windows-msvc"
default_toolchain = "stable"
profile = "default"
version = "12"

[overrides]
</pre>
-->

***

*[mics](https://lampwww.epfl.ch/~michelou/)/October 2024* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[article_baumgartner_error]: https://fettblog.eu/rust-error-handling/
[article_baumgartner_idiomatic]: https://fettblog.eu/slides/idiomatic-rust/
[article_baumgartner_serverless]: https://fettblog.eu/slides/serverless-rust/
[article_baumgartner_traits]: https://fettblog.eu/refactoring-rust-introducing-traits/
[article_bursell]: https://opensource.com/article/20/5/rust-java
[article_cargo]: https://opensource.com/article/20/3/rust-cargo
[article_dreimanis]: https://serokell.io/blog/rust-guide
[article_ge]: https://developers.redhat.com/articles/2022/09/05/how-create-c-binding-rust-library
[article_explodes]: https://fasterthanli.me/articles/when-rustc-explodes
[article_half_hour]: https://fasterthanli.me/articles/a-half-hour-to-learn-rust
[blog_hans_macro]: https://www.thorsten-hans.com/weekly-rust-trivia-function-like-macros/
[blog_hans_patmat]: https://www.thorsten-hans.com/weekly-rust-trivia-pattern-matching/
[blog_hans_threads]: https://www.thorsten-hans.com/weekly-rust-trivia-share-state-between-threads/
[article_mistakes]: https://fasterthanli.me/articles/some-mistakes-rust-doesnt-catch
[article_novak]: https://www.wwt.com/article/intro-to-rust-the-modern-day-safe-low-level-programming-language
[article_oxide]: https://arxiv.org/abs/1903.00982
[article_proc_macro]: https://fasterthanli.me/articles/proc-macro-support-in-rust-analyzer-for-nightly-rustc-versions
[article_slow_build]: https://fasterthanli.me/articles/why-is-my-rust-build-so-slow
[article_stone_2017]: https://developers.redhat.com/blog/2017/11/01/getting-started-rust-toolset-rhel#
[article_stone_2021]: https://developers.redhat.com/blog/2021/04/30/how-rust-makes-rayons-data-parallelism-magical
[book_blandy]: https://www.oreilly.com/library/view/programming-rust-2nd/9781492052586/
[blog_claburn]: https://www.theregister.com/2023/04/27/microsoft_windows_rust/
[blog_fraenkel_7]: https://blog.frankel.ch/start-rust/7/
[blog_fraenkel_8]: https://blog.frankel.ch/start-rust/8/
[blog_fraenkel_9]: https://blog.frankel.ch/start-rust/9/
[blog_howarth]: https://blog.discord.com/why-discord-is-switching-from-go-to-rust-a190bbca2b1f
[blog_kanishkar]: https://kanishkarj.github.io/rust-internals-mir
[blog_kornelski]: https://kornel.ski/rust-sys-crate
[blog_nahum]: https://jondot.medium.com/my-key-learnings-after-30-000-loc-in-rust-a553e6403c19
[blog_nethercote]: https://blog.mozilla.org/nnethercote/2020/09/08/how-to-speed-up-the-rust-compiler-one-last-time/
[blog_roman]: https://pvs-studio.com/en/blog/posts/0733/
[blog_thorsten]: https://www.thorsten-hans.com/working-with-environment-variables-in-rust/
[blog_turon]: https://blog.rust-lang.org/2015/04/10/Fearless-Concurrency.html
[blog_vaktor]: https://varkor.github.io/blog/2018/07/03/existential-types-in-rust.html
[blog_verdi]: https://github.blog/2023-08-30-why-rust-is-the-most-admired-language-among-developers/
[bpb_online]: https://bpbonline.com
[book_klabnik]: https://github.com/rust-lang/book
[book_matzinger]: https://www.packtpub.com/product/rust-programming-cookbook/9781789530667
[book_mcnamara]: https://www.manning.com/books/rust-in-action
[book_messier]: https://www.wiley.com/en-us/Beginning+Rust+Programming-p-9781119712978
[book_milanesi]: https://link.springer.com/book/10.1007/978-1-4842-7208-4
[book_palmieri]: https://www.amazon.com/Zero-Production-Rust-introduction-development/dp/B0BHLDMFDQ
[book_sharma]: https://www.packtpub.com/product/mastering-rust-second-edition/9781789346572
[blog_thompson]: https://www.technologyreview.com/2023/02/14/1067869/rust-worlds-fastest-growing-programming-language/
[book_uzayr]: https://www.routledge.com/Mastering-Rust-A-Beginners-Guide/Uzayr/p/book/9781032319018
[github_ripgrep]: https://github.com/BurntSushi/ripgrep
[github_winapi_rs]: https://github.com/retep998/winapi-rs/
[news_this_week]: https://this-week-in-rust.org/
[paper_astrauskas]: https://www.research-collection.ethz.ch/handle/20.500.11850/311092
[paper_bugden]: https://arxiv.org/abs/2206.05503
[paper_reed]: https://dada.cs.washington.edu/research/tr/2015/03/
[rust_downloads]: https://www.rust-lang.org/tools/install
[rust_lang]: https://www.rust-lang.org/
[rust_mir]: https://github.com/rust-lang/rfcs/blob/master/text/1211-mir.md
[rust_relnotes]: https://github.com/rust-lang/rust/blob/master/RELEASES.md
[tutorial_donovan]: https://stevedonovan.github.io/rust-gentle-intro/
[tutorial_mueller]: https://towardsdatascience.com/a-not-so-short-introduction-to-the-rust-programming-language-2e8542a06b76
[youtube_cameron]: https://youtu.be/vqavdUGKeb4
[youtube_crichton]: https://youtu.be/Dbytx0ivH7Q
[youtube_levick]: https://youtu.be/NQBVUjdkLAA
[youtube_turon]: https://youtu.be/O5vzLKg7y-k

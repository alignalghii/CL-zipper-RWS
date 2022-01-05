# A zpper-based implematation of a combinatory logic programming language with lazy evaluation and further extensibility

## Project goals and objectives

This project is intended to show present Haskell features,
and additionally it is intended to be a base project to present the use of monad tansformers in the future.

Haskell tutorials and articles usually present monad transformers based on small example projects for **interpreters**.
A small embedded language is presented — usually a language of a small pocket calculator software — whose capabilities are augmented gradually by logging (tracing), error reporting, variable usage, confoguration optioning etc.

The main idea is that all these additional features can be added rather seamlessly and in a modular way to the basic calculator functionality, which can be kept easily readable and simple.

This project is inteded to provide a somewhat more complex base project. It is an interpreter, but not of a simple pocket calculator language, but a Turing-complete algorithmic language. It is one of the simples in this category: it is essentially an implementation of **combinatory logic**.

Combinatory logic is a similar theoretical framework as lambda calculus.

This project does not contain monad transformers yet. It provides a starting point, an apropos on which the use of monad transformers can be exemplified later in future.

In its current stage, it can reduce (evaluate) so-called coboinatory logic terms. The evaluation of these terms can be regarded as the operation of a pure lazy functional programming language. As a computer language, it is Turing-complete, but this tiny interpreter is minimalistic.

Features to be added in future:
 * error reporting,
 * tracing information
 * User options configurable (e.g. execution runaway check limit, evaluation strategy, the set of base combinators etc.)
 * an execution-step counting to limit runaway (infinitely running) „programs” (combinatory logic term evaluation processes).

The main advantage of the vision of the whole project: comninatory logic provides a very well balanced trade-off:
 * it is simple enough to exemplify a pure interpreter_ mathmatically it is a very pure and a well-described theory is underlying it.
 * still, it is complicated enough to provide need and meaning to advanced features implemantable via monad transformers: it can provide good apropos for non-trivial use cases of the most important monad transformer examples.

Monad transformers are sometimes regarded as theoretically suspicious and ugly, still, the question of a „purer” alternative remains open.
The Utrecht University\'s UUAGC is an interesting approach to provide surprizing modularity, a maybe stronger „glue” than that of monads and monad transformers.
In any case, learning deep underlying theories like category theory or martin-Löf type theory (dependent types) seems to provide wide horizons and prospects for future.

Another objective is to present techniques of „conventional”, „imperative” programming languages to implement core Haskell techniques. Any familiary algebraic data type can be implemented in languages like PHP or JavaScript via a technique called „case objects” (originally made popular in the Scala community). Furthermore, Haskell typeclasses — among them the most often used monads — can be implemented by PHP or JavaScript **trait** constructs over these case objects. Samples for all these can be found in the `doc` map of this project.

By using these, the entire project could be reimplemente in HP or JavaScript, and so the project can be given a web application user interface. Of course, Haskell itself provides its own ecosystem: for example, Scotty among the simplest ones.

# stack-notebook
You say `stack ghci`, I say `stack notebook`

-----------------

In theory: _Wanna' hack around with Haskell? Just_
````
## first...
git clone https://github.com/habemus-papadum/stack-notebook

## and this will walk you through the rest
stack-notebook/stack-notebook

## Afterwards, when you want to repl, this will work:
cd /to/a/stack/project # or not, to use stack's global project
stack notebook
````

In reality: _Well, you know...  Very much a WIP._

----------

## Theory of Operation
* one `ihaskell` is built, on demand, by `stack`, per `lts` snapshot -- they live in
 `~/.stack/.stack_notebook/IHaskells/<snapshot>/IHaskell`
* when running `stack` notebook for projectA,
  the `GHC_PACKAGE_PATH` of the `ihaskell` (of the matching lts) is added
  to the projectA's `GHC_PACKAGE_PATH`
* `python3`+`jupyter`+`zeromq` is provided by `miniconda`; `pango`+`cairo`+`magic` has been
  replaced / removed, so macOs and windows users have a chance.


#### Caveats
* `ihaskell` is provided by a downstream [fork](https://github.com/habemus-papadum/IHaskell)
 (to provide stability while this script is being designed/built)
* the provided the `ihaskell` may not build with old `lts` snapshots -- it should be
  easy to resolve this by using known good old versions of `ihaskell` but
  will not be addressed within the scope of the exploration
* A thousand other things....
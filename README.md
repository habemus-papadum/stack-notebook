# stack-notebook
You say `stack ghci`, I say `stack notebook`

-----------------

In theory: _Wanna' hack around with Haskell? Just_
````
git clone https://github.com/habemus-papadum/stack-notebook

## and, then this will walk you through the rest
stack-notebook/stack-notebook

## Afterwards, this will work:
cd /to/a/stack/project # or not, to use stack's global project
stack notebook
````

In reality: _Well, you know... Very much a WIP._

----------

## Theory of Operation
* one `ihaskell` is built, on demand, by `stack`, per `lts` snapshot -- they live in
 `~/.stack/.stack_notebook/<snapshot>/IHaskell`
* when running `stack` notebook for projectA,
  the `GHC_PACKAGE_PATH` of the `ihaskell` (of the matching `lts`) is added
  to the projectA's `GHC_PACKAGE_PATH`
* `python3`+`jupyter`+`zeromq` is provided by `miniconda`; IHaskell's `pango`+`cairo`+`magic` deps 
  has been replaced/removed, so macOs and windows users have a chance.


#### Caveats
* if you've never used `stack` on your box before, you want to go get lunch while everything is installing.
* `ihaskell` is provided by a downstream [fork](https://github.com/habemus-papadum/IHaskell)
* the provided `ihaskell` may not build with old `lts` snapshots -- it should be
  easy to resolve this by using known good old versions of `ihaskell` but
  will not be addressed within the scope of this exploration
* ihaskell-display-widgets may not be working.
* lts-nightly could be tough.  
* A thousand other things....

#### Use by date
As I write this, it is Oct. 15, 2017 -- If you are still relying on the repo 2-3 months from now,
you are asking for trouble...

#### In truth
On two occasions (months apart) I tried to use IHaskell, and on both occasions felt "This is a really 
great tool, that may sadly go under used, and and if so, for no good reason."  This script is an attempt
to show, rather than opine about, to the maintainers of `IHaskell`, `stack`, etc how close they could be (or that
I'm just an idiot, or both... :smile:) 
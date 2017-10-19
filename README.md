# stack-notebook
_You say `stack ghci`, I say `stack notebook`..._

-----------------

## In theory 
_Wanna' hack around with Haskell?_

Then try:
````
git clone https://github.com/habemus-papadum/stack-notebook

## and then: 
stack-notebook/stack-notebook

## If you put the script on your path, then you can lose the dash: 
export PATH=${PATH}/stack-notebook
stack notebook
````

## In reality 
_Well, you know... Very much a WIP._

## New to Haskell?
Truth be told, this script may not be for you. This is more of an exploration of how I wish the notebook process could work someday.  And even though it does seem to be robust enough on my boxes and Travis, I wouldn't be surprised if it fails miserably on yours, or suddenly stops working every few months.  One could easily fall down the rabbit hole trying to track down fixes if you are new to stack, jupyter, {I}Haskell, cabal, etc.  But, if you do end up giving it a shot, whether you have :+1: or :-1: experience, feel free to open an issue and let me know how it went. 

## Caveats
* If you've never used `stack` on your box before, you want to go get lunch while everything is installing.
* `IHaskell` is provided by a downstream [fork](https://github.com/habemus-papadum/IHaskell).  The fork and this repo are meant
  to be short lived.
* Only Linux and macOs are supported.  The upstream IHaskell has never supported windows, and while my fork takes some
  small steps to make it more feasible, I don'r really know how hard it would be to get it all the way to the finish line.  
* The provided `Ihaskell` may not build with old `lts` snapshots -- it should be
  easy to resolve this by using known good old versions of `ihaskell` but
  will not be addressed within the scope of this exploration
* Only really tested on `lts-9.9`
* test displays
* travis time to first notebook
* ihaskell-display-widgets may not be working.
* zeromq, gmp  
* A thousand other things....


## Theory of Operation
* one `ihaskell` is built, on demand, by `stack`, per `lts` snapshot -- they live in
 `~/.stack_notebook/<snapshot>/IHaskell`
* when running `stack notebook` within a `stack` `projectA`,
  the `GHC_PACKAGE_PATH` of `ihaskell` (of the matching `lts`) is added to the projectA's `GHC_PACKAGE_PATH` before launching jupyter -- I've considered several permuations, alternatives and so far I feel like this is the clear winner.  Discuss general pattern 
* `python3`+`jupyter`+`zeromq` is provided by `miniconda`; IHaskell's `pango`+`cairo`+`magic` deps 
  has been replaced/removed, so macOs have to do nothing and windows users have a chance someday.  


#### Use by date
As I write this, it is Oct. 15, 2017 -- If you are still relying on the repo 3-4 months from now,
you are asking for trouble...

## todo 
* zeromq logic -- check if zeromq exists, if not test if system provides zeromq 
* proper interpose
* cache travis, actual travis test?
* linux -- clean box for zeromq, gmp
* prompt for long operations

* test chart, custom project, internals
* fleshout caveats

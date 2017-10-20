# stack-notebook [![Travis](https://travis-ci.org/habemus-papadum/stack-notebook.svg?branch=master)](https://travis-ci.org/habemus-papadum/stack-notebook)
_You say `stack ghci`, I say `stack notebook`..._

---------------

This repo aims to provide a convenient installer/launcher for [IHaskell](https://github.com/gibiansky/IHaskell)

------------------

## In theory 
_Wanna' hack around with Haskell?_

Then try:
```bash
$ git clone https://github.com/habemus-papadum/stack-notebook
$ stack-notebook/stack-notebook
```
If you put the script on your path, then you can lose the dash: 
```bash
export PATH=${PWD}/stack-notebook:${PATH}
stack notebook
```
Interacting with an existing stack project is particularly easy:
```bash
cd /to/you/stack/project && stack notebook
```
Now you can load modules defined in the project into notebooks. 

----------------

The script installs whatever is needed (within reason...) on demand.  

----------------

If you are interested in workflow that combines a literate environment with
REPL-like interactivity, then while `emacs` might be best in the long run, `stack notebook`
can get you started with a potentially easier learning curve. 

## In reality 
_Well, you know... Very much a WIP._

## New to Haskell?
Truth be told, this script may not be for you. This is more of an exploration of how I wish the notebook process could work someday.  And even though it does seem to be robust enough on my boxes and Travis, I wouldn't be surprised if it fails miserably on yours, or suddenly stops working every few months.  One could easily fall down the rabbit hole trying to track down fixes if you are new to stack, jupyter, {I}Haskell, cabal, etc.  But, if you do end up giving it a shot, whether you have :+1: or :-1: experience, feel free to open an issue and let me know how it went. 

## Caveats
* If you've never used `stack` on your box before, you want to go get lunch while everything is installing. Travis([![Travis](https://travis-ci.org/habemus-papadum/stack-notebook.svg?branch=master)](https://travis-ci.org/habemus-papadum/stack-notebook)) says "time to first notebook" can be around 45 minutes. 
* `IHaskell` is provided by a downstream [fork](https://github.com/habemus-papadum/IHaskell).  The fork and this repo are meant
  to be short lived.
* Only Linux and macOs are supported.  The upstream IHaskell has never supported windows, and while my fork takes some
  small steps to make it more feasible, I don'r really know how hard it would be to get it all the way to the finish line.  
* The provided `IHaskell` may not build with old `lts` snapshots -- it should be
  easy to resolve this by bisecting on old versions of `ihaskell` but
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
* `python3`+`jupyter` is provided by `miniconda`; IHaskell's `pango`+`cairo`+`magic` deps 
  has been replaced/removed.  


#### Use by date
As I write this, it is Oct. 15, 2017 -- If you are still relying on the repo 3-4 months from now,
you are asking for trouble...

## todo 

* fleshout caveats, theory, instructions
* doc time to first notebook
* doc project repl
* doc piping

* displays 
  * Chart not working
  * Test SVG backend
* internals

* squash commits
* post -- stack, stack mailing list  


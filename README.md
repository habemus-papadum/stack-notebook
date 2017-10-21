# stack-notebook [![Travis](https://travis-ci.org/habemus-papadum/stack-notebook.svg?branch=master)](https://travis-ci.org/habemus-papadum/stack-notebook)
_You say `stack ghci`, I say `stack notebook`..._

---------------

This repo aims to provide a convenient installer/launcher for [IHaskell](https://github.com/gibiansky/IHaskell). If you are interested in a workflow that combines a literate style with REPL-like interactivity, then, while `emacs` might be best in the long run, `stack notebook`can get you started with a potentially easier learning curve (_or not, open an issue and let me know_).  The script installs whatever is needed (_within reason_) on demand.  
 
------------------

## In theory... 
_Wanna' hack around with Haskell?_

Then try:
```bash
$ git clone https://github.com/habemus-papadum/stack-notebook
$ stack-notebook/stack-notebook
```
If you put the script on your path, then you can lose the dash: 
```bash
$ export PATH=${PWD}/stack-notebook:${PATH}
$ stack notebook
```
Interacting with an existing stack project is particularly easy:
```bash
$ cd /to/your/stack/project && stack notebook
```
Now your project code can be used from within your notebooks. 

----------------

## In reality... 
_Well, you know... Very much a WIP._

## New to Haskell?
Truth be told, this script may not be for you. This is more of an exploration of how I wish the notebook process could work someday.  And even though it does seem to be robust enough on my boxes and Travis, I wouldn't be surprised if it fails miserably on yours, or suddenly stops working every few months.  One could easily fall down the rabbit hole trying to track down fixes if you are new to stack, jupyter, {I}Haskell, cabal, etc.  But, if you do end up giving it a shot, whether you have :+1: or :-1: experience, feel free to open an issue and let me know how it went. 

## Caveats
* While IHaskell is quite nice, it might not be mature enough to convince you to abandon you tried and true tools.  This script is a baby step towards better user experience, but it is in now way a complete solution.  It may be a step backwards...  
* If you've never used `stack` on your box before, you will want to go get lunch while everything is installing. "Time to first notebook" can be around 45 minutes!  But, after that, launches for any project on the same 'lts' should take about 3 seconds.  Every time you switch to a new 'lts', 'IHaskell' is rebuilt, taking at least 5 minutes, but up to the full 45 minutes depending on how well you have exercised the new 'lts'. (These timings are for "travis-like" machines.)  
* `IHaskell` is provided by a downstream [fork](https://github.com/habemus-papadum/IHaskell).  The fork and this repo are meant to be short lived.  
* Only Linux and macOs are supported.  The upstream IHaskell has never supported windows, and while my fork takes some small steps to make it more feasible, I don't really know how hard it would be to get it all the way to the finish line.  
* The provided `IHaskell` may not build with old `lts` snapshots -- it should be easy to resolve this by bisecting on old versions of `ihaskell` but that is not in the scope of this exploration.
* Only really tested on `lts-9.9`
* A thousand other things....


## Theory of Operation
* one `ihaskell` is built, on demand, per `lts` snapshot -- they live in
 `~/.stack_notebook/<snapshot>/IHaskell`
* When running `stack notebook` for a `stack` `projectA`,  the `GHC_PACKAGE_PATH` of `ihaskell` (of the matching `lts`) is added to the projectA's `GHC_PACKAGE_PATH` before launching kernels. Depending on the internals of IHaskell, this may not be necessary, but give that IHaskell is "lts pure", this should be safe.    
* There is one jupyter kernel created for each project+lts pair (a kernel basically just a json file). 
* `python3`+`jupyter` is provided by `miniconda`. Users must BYOZMQ, but the script tries to break it to them gently. IHaskell's `pango`+`cairo`+`magic` deps has been replaced/removed.
* Do scan through the script if you want to no more details.   

## Advanced usage
`stack notebook` just executes whatever is piped into `STDIN`.  A plain `stack notebook` is equivalent to `echo "jupyter notebook" | stack notebook`.  This can used to render notebooks, list and  delete kernels, and so forth.  See the `.travis.yml` for ideas.    

#### Use by date
As I write this, it is Oct. 15, 2017 -- If you are still relying on the repo 3-4 months from now,
you are asking for trouble...

## todo 
* Chart not working


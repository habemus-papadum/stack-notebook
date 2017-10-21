# stack-notebook [![Travis](https://travis-ci.org/habemus-papadum/stack-notebook.svg?branch=master)](https://travis-ci.org/habemus-papadum/stack-notebook)
_You say `stack ghci`, I say `stack notebook`..._

---------------

This repo aims to provide a convenient installer/launcher for [IHaskell](https://github.com/gibiansky/IHaskell). 

If you are interested in a workflow that combines a literate style with a REPL-like interactivity, then, while `emacs` might already be there, `stack notebook` may be worth a look (or _not_, open an issue and let me know, but do understand that all compliments and credits go to the IHaskell team).  

The script installs whatever is needed (_within reason_) on demand. 
 
------------------

## In Theory 
_Wanna' hack around with Haskell?_

Then try:
```bash
git clone https://github.com/habemus-papadum/stack-notebook
stack-notebook/stack-notebook
```
If you put the script on your path, then you can lose the dash: 
```bash
export PATH=${PWD}/stack-notebook:${PATH}
stack notebook
```
Interacting with an existing stack project is particularly easy:
```bash
cd /to/your/stack/project && stack notebook
```
Now your project code can be used from within your notebooks.  Have a browse through simple
example [project](https://github.com/habemus-papadum/stack-notebook/tree/master/test/test-project) with a corresponding simple [notebook](https://github.com/habemus-papadum/stack-notebook/blob/master/test/test-project/TestProjectNotebook.ipynb).    

----------------

## In Reality 
_Well, you know... Very much a WIP._

## New to Haskell?
Truth be told, this script may not be for you. This is more of an exploration of how I wish the notebook process could work someday.  And even though it does seem to be getting robust enough on my boxes and Travis, I wouldn't be surprised if it fails miserably on yours, or suddenly stops working every few months.  One could easily fall down the rabbit hole trying to track down fixes if you are new to stack, jupyter, conda, {I}Haskell, cabal, etc.  But, if you do end up giving it a shot, whether you have :+1: or :-1: experience, feel free to open an issue and let me know how it went.  I can't promise to help fix your problems, but I will apologize if `stack notebook` ruins your day.  

## Caveats
* While IHaskell is quite nice, it might not be mature enough to convince you to abandon your tried and true tools.  This script is a baby step towards better user experience, but it is in no way a complete solution.  It may be a step backwards...  
* If you've never used `stack` on your box before, you will want to go get lunch while everything is installing. "Time to first notebook" can be around 45 minutes!  But, after that, launches for any project on the same 'lts' should take about 3 seconds.  Every time you switch to a new 'lts', 'IHaskell' is rebuilt, taking at least 5 minutes, but up to the full 45 minutes depending on how well you have exercised the new 'lts'. (These timings are for "travis-like" machines.)  
* `IHaskell` is provided by a downstream [fork](https://github.com/habemus-papadum/IHaskell).  The fork and this repo are meant to be short lived.  
* Only Linux and macOs are supported.  The upstream IHaskell has never supported windows, and while my fork takes some small steps to make it more feasible, I don't really know how hard it would be to get it all the way to the finish line.  
* The provided `IHaskell` may not build with old `lts` snapshots -- it should be easy to resolve this by bisecting on old versions of `IHaskell` but that is not in the scope of this exploration.
* Only really tested on `lts-9.9`
* A thousand other things...


## Theory of Operation
* one `IHaskell` is built, on demand, per `lts` snapshot -- they live in
 `~/.stack_notebook/<snapshot>/IHaskell`
* When running `stack notebook` for a `stack` `projectA`,  the path to the `pkg-db` of the `stack notebook` provided `IHaskell` matching the project's `lts` is inserted into the second position of projectA's normal `GHC_PACKAGE_PATH` (so there are 4 directories in the path in total) before launching kernels. Depending on the internals of `IHaskell`, this may not be necessary, but given that `IHaskell` is "lts pure", this should be safe.    
* There is one jupyter kernel created for each `stack`+`lts` pair (a jupyter kernel is basically just a json file and takes no time to create). 
* `python3`+`jupyter` is provided by `miniconda`. Users must BYOZMQ, but the script tries to break it to them gently. IHaskell's `pango`+`cairo`+`magic` deps has been replaced/removed.
* Do scan through the script if you want to know more details.   

## Advanced usage
`stack notebook` just executes whatever is piped into `STDIN`.  A plain `stack notebook` invocation is equivalent to `echo "jupyter notebook" | stack notebook`.  This can be used to render notebooks, list and delete kernels, and so forth.  See the `.travis.yml` for ideas.    

#### Use by date
As I write this, it is Oct. 15, 2017 -- If you are still relying on the repo 3-4 months from now,
you are asking for trouble...

#### TODO 
* Chart not working


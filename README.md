# stack-notebook [![Travis](https://travis-ci.org/habemus-papadum/stack-notebook.svg?branch=master)](https://travis-ci.org/habemus-papadum/stack-notebook)
_You say `stack ghci`, I say `stack notebook`..._

##

This repo aims to provide a convenient installer/launcher for [IHaskell](https://github.com/gibiansky/IHaskell) notebooks using the [Haskell Stack Tool](https://docs.haskellstack.org/en/stable/README/). 
##

If you are interested in a workflow consisting of the literate style and REPL-like interactivity offered by IHaskell notebooks, then, `stack notebook` might help get you started with a minimum of fuss (or _not_, open an [issue](https://github.com/habemus-papadum/stack-notebook/issues) and let me know, but do understand that all compliments and credits go to the IHaskell team).

## 

## In Theory 
_Wanna' hack around with Haskell?_

##

Then try:
```bash
git clone https://github.com/habemus-papadum/stack-notebook
stack-notebook/stack-notebook
```
Put the script on your path, and you can lose the dash: 
```bash
export PATH=${PWD}/stack-notebook:${PATH}
stack notebook
```
Interacting with an existing `stack` project is particularly easy:
```bash
cd /to/your/stack/project && stack notebook
```
Now you can tinker around with your code using IHaskell notebooks.  Have a browse through a simple example [project](https://github.com/habemus-papadum/stack-notebook/tree/master/test/test-project) with a corresponding simple [notebook](https://github.com/habemus-papadum/stack-notebook/blob/master/test/test-project/TestProjectNotebook.ipynb).

##
 
`stack-notebook`'s core organizing principle, is _simplicity_, perhaps to a fault.  There is only one, self contained `bash` script and it takes no arguments.  Using the current directory as its frame of reference, it does its best to infer what you mean and then does it. The script installs whatever is needed (_within reason_) on demand, and in a way that is as efficient as possible.  If you regret this ever happened, `rm -rf ~/.stack-notebook` and be on your merry way.   

##

## In Reality 
_Well, you know... Very much a WIP._

## Hints
* `stack notebook` tries to make it easy to create notebooks that can use code from a local `stack` project.  You will inevitably want to make changes to your project code visible to your running notebooks.  One method would be to:
  * At the terminal, rebuild the project: `stack build `, perhaps with `--fast` or `--file-watch`
  * In the notebook, perform the `Kernel`->`Restart & Run All` menu action (which can be assigned a keyboard shortcut).
   
  While this can be overkill and a little inelegant, it is a useful, safe starting point from which you can then optimize.
* Teach your OS to provide [quicklooks](https://github.com/tuxu/nbviewer-app) for `jupyter` notebooks.  
* Squeal with that delight that web based scm providers will render notebooks on demand.  Teachers can just `git push` notebooks.  Cry in anguish when you try to diff notebooks... 
* The jupyter notebook interface has been designed to be easily usable without having to read the manual.  However, it can be useful to open a notebook and take the interface tour from the `Help` menu to get started.    

## New to Haskell?
Truth be told, this script may not be for you. This is more of an exploration of how I wish the notebook process could work some day.  And even though it does seem to be getting robust enough on my boxes and Travis, I wouldn't be surprised if it fails miserably on yours, or suddenly stops working every few months.  One could easily fall down the rabbit hole trying to track down fixes if you are new to `stack`, `jupyter`, `conda`, `{I}Haskell`, `cabal`, etc.  But, if you do end up giving it a shot, whether you have :+1: or :-1: experience, feel free to open an issue and let me know how it went.  I can't promise to help fix your problems, but I will personally apologize if `stack notebook` ruins your day.  

## Caveats
* While `IHaskell` is quite nice, it might not be mature enough to convince you to abandon your tried and true tools.  This script is a baby step towards better initial user experience, but it is in no way a complete solution.  It may be a step backwards...  
* If you've never used `stack` on your box before, you will want to go get lunch while everything is installing. "Time to first notebook" can be around 45 minutes!  But, after that, launches for any project on the same `lts` should take about 3 seconds.  Every time you switch to a new `lts`, `IHaskell` is rebuilt, taking at least 5 minutes, but up to the full 45 minutes depending on how well you have exercised the new `lts`. (These timings are for `travis`-like machines.)  
* `IHaskell` is provided by a downstream [fork](https://github.com/habemus-papadum/IHaskell).  The fork and this script are meant to be transient.  Upstreamers, please consider forking/rewriting `stack-notebook` in Haskell and and making it your own by having it point back at your repo.  Users beware that notebooks written against the fork, may or may not work against upstream.   
* Only Linux and macOs are supported.  The upstream `IHaskell` has never supported Windows, and while my fork takes some small steps to make it more feasible, I don't really know how hard it would be to get it all the way to the finish line.  
* The provided `IHaskell` may not build with old `lts` snapshots -- it should be easy to resolve this by bisecting old versions of `IHaskell` but that is not in the scope of this exploration.
* Only really tested on `lts-9.9`, `lts-9.10`, `nightly-2017-10-17`
* In the long run, you might find 'emacs(org, intero)+literate haskell' more productive and powerful.  
* `stack-notebook` could have been split into two: `stack-notebook-install-prereqs-as-needed-and-setup-kernel-for-project`  and `stack-notebook-run-notebook-server-for-all-kernels`.  I like just having to think about only one thing.  However, be aware you might experience cognitive dissonance when you notice that even though you launched a notebook server for `projectA`, kernels from other projects are safely usable (they run with the correct environment variables set), but this can be fairly useful.    
* To allow for `rm -rf` uninstall, kernelspecs a placed in `~/.stack-notebook/conda/share/jupyter/kernels`.  This may hinder usability with things like Atom Hydrogen (not sure). 
* A thousand of other things buried in the nooks and crannies of my feeble mind. 


## Theory of Operation
* `IHaskell` is built once, on demand, per `lts` snapshot -- builds live in
 `~/.stack_notebook/<snapshot>/IHaskell`
* When running `stack notebook` for a `stack` `projectA`,  the path to the `pkg-db` of the `IHaskell` matching the project's `lts` is interposed into the second position of projectA's normal `GHC_PACKAGE_PATH`  before launching kernels (so there are 4 directories instead of the `stack` norm of 3). Depending on the internals of `IHaskell`, this may not be necessary, but given that `IHaskell` is "lts pure", this should be safe.  Something similar is done for `HASKELL_PACKAGE_SANDBOXES`.  I've no idea if that is necessary.    
* There is one jupyter kernel created for each `stack` project +`lts` pair (a `jupyter` kernel is basically just a json file and takes no time to create). 
* `python3`+`jupyter` is provided by `miniconda`. Users must BYO[ZMQ](http://zeromq.org), but the script tries to break it to them gently. Upstream IHaskell's `pango`+`cairo`+`gtk`+ `libmagic` deps has been replaced/removed.
* Do scan through the script if you want to know more details.   

## Advanced usage
`stack notebook` just executes whatever is piped into `STDIN`.  A plain `stack notebook` invocation is equivalent to `echo "jupyter notebook" | stack notebook`.  This can be used to render notebooks, list and delete kernels, allow connections from remote boxes, and so forth.  See the `.travis.yml` for ideas.    

#### Use by date
As I write this, it is Oct. 15, 2017 -- If you are still relying on the repo 3-4 months from now, you are asking for trouble...


#### Nice possibilities that probably won't happen
* Allow user to choose a slimmer version of IHaskell lacking bundled displays (don't know how to do this without adding complexity to the script)
* Get ihaskell-display  into stackage (not the full IHaskell beast, just integration shims needed for other projects)
* Allow notebooks to include other notebooks cf. NBInclude.jl.  Useful for notebooks which are meant for teaching.
* Allow cells to have tags + more complicated annotations.  Notebook-include, nbconvert to .hs, etc should allow filtering by tag.  (Notebook 5.0 supports cell tagging)
* Split modules across cells.  Annotate a cell's Module.  
* Long term: Make notebooks a first class citizen within ghc.  Ideally ghc provides an abstraction layer so that tools like
  hoogle, hindent, etc can be used on a first class haskell source file (.hs, .lhs, .ihsnb, etc) without having to know the details of each format.     



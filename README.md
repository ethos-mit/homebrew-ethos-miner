homebrew-ethos
==============

Homebrew tap for Ethos.

Tested on 10.9+


## Installation

Homebrew is required for the installation.

Start with tapping into ethos' brew:

```
brew tap ethos-mit/ethos-miner
```

Set ETHOS_TOKEN with the token you received:

```
export ETHOS_TOKEN=<token>
```

Install ethos:
```
brew install ethos-miner
```

NOTE: You might need to install miniupnpc if you don't have it (requires pip):
```
pip install miniupnpc
```


## Running

Connecting to ethos test-net:

```
ethosd --node 18.85.59.189 --port 30307
```

To get help and see other available arguments, run:

```
ethosd --help
```

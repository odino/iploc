# iploc

Reverse geocoding of IP addresses -- find where that IP comes from!

## Usage

`iploc` is a very straightforward utility: give it an IP address and will return
as many information as possible regarding its geographical location:

```
iploc 12.34.56.78
{"as":"AS7018 AT\u0026T Services, Inc.","city":"Columbus","country":"United States","countryCode":"US","isp":"AT\u0026T Services","lat":39.9653,"lon":-83.0235,"org":"AT\u0026T Services","query":"12.34.56.78","region":"OH","regionName":"Ohio","status":"success","timezone":"America/New_York","zip":"43215"}
```

It provides a very simple *pretty-print* option:

```
iploc 12.34.56.78 -p
{
    "as": "AS7018 AT\u0026T Services, Inc.",
    "city": "Columbus",
    "country": "United States",
    "countryCode": "US",
    "isp": "AT\u0026T Services",
    "lat": 39.9653,
    "lon": -83.0235,
    "org": "AT\u0026T Services",
    "query": "12.34.56.78",
    "region": "OH",
    "regionName": "Ohio",
    "status": "success",
    "timezone": "America/New_York",
    "zip": "43215"
}
```

...but you're much better off with `jq`:

```
iploc 12.34.56.78 | jq -r .city
Columbus
```

Need help?

```
A simple utility to find geographical informations
about an IP address: given an IP as an input, it will return
as many geographical info as possible.

Usage:
  iploc [flags]
  iploc [command]

Examples:
iploc 127.0.0.1
iploc - (own IP address)

Available Commands:
  help        Help about any command
  version     Print the version number of iploc

Flags:
  -h, --help     help for iploc
  -p, --pretty   pretty print json

Use "iploc [command] --help" for more information about a command.
```

Need version info?

```
iploc version
v1.0.0
```

## Installation

Grab a binary for the [release](https://github.com/odino/iploc/releases) page. That's it.

If you fancy building things from scratch, clone this repo and run a `go build`
for yourself!

Note: `iploc` is built on top of [ip-api.com](http://ip-api.com) -- they do the hard work!

## Tests

![lol](https://raw.githubusercontent.com/odino/docsql/master/images/tommy.png)

## Development

For development with Go, I usually use a local docker container -- here's what I do:

* `make build` creates the container
* `make` gets in the container
* `go run main.go` and have fun with the app

Once you're done, you can test binaries with `make release`.

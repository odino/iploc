package cmd

import (
	"errors"
	"fmt"
	"github.com/Jeffail/gabs"
	"github.com/spf13/cobra"
	"io/ioutil"
	"net/http"
	"os"
)

var Pretty bool

var rootCmd = &cobra.Command{
	Use: "iploc",
	Example: `iploc 127.0.0.1
iploc - (own IP address)`,
	Short: "Reverse geocode an IP address -- find where that IP is from!",
	Long: `A simple utility to find geographical informations
about an IP address: given an IP as an input, it will return
as many geographical info as possible.`,
	Args: func(cmd *cobra.Command, args []string) error {
		// because in the future I will DEFINITELY support looking up multiple IPs...
		if len(args) < 1 {
			return errors.New("I need an argument :-(")
		}
		return nil
	},
	Run: func(cmd *cobra.Command, args []string) {
		if args[0] == "-" {
			args[0] = ""
		}
		r, err := http.Get("http://ip-api.com/json/" + args[0])
		checkError(err)
		buf, err := ioutil.ReadAll(r.Body)
		checkError(err)

		if Pretty {
			json, err := gabs.ParseJSON(buf)
			checkError(err)
			fmt.Printf("%s\n", json.StringIndent("", "    "))
			return
		}

		fmt.Printf("%s", buf)
	},
}

func Execute() {
	rootCmd.PersistentFlags().BoolVarP(&Pretty, "pretty", "p", false, "pretty print json")

	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func checkError(err error) {
	if err != nil {
		panic(err)
	}
}

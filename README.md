# KgbScrape

## Description
This module finds the 3 most overly positive reviews from the first 5 pages of reviews for Mckaig Chevrolet Buick Dealership on www.dealerrater.com https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-review-23685/. The method for determining the most overly positive reviews is reached by counting the number of "special words" per review and dividing them by the total number of words per review. This returns a decimal that is used as the score for each respective review. All reviews are then sorted: highest score to lowest score and only the top 3 reviews are returned to the console. Special words are words that imply an extremely satisfied customer. 

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `kgb_scrape` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:kgb_scrape, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/kgb_scrape](https://hexdocs.pm/kgb_scrape).


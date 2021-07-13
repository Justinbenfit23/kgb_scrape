# KgbScrape

## Description
This module finds the 3 most overly positive reviews from the first 5 pages of reviews for Mckaig Chevrolet Buick Dealership on www.dealerrater.com https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-review-23685/. The method for determining the most overly positive reviews is reached by counting the number of "special words" per review and dividing them by the total number of words per review. This returns a decimal that is used as the score for each respective review. All reviews are then sorted: highest score to lowest score and only the top 3 reviews are returned to the console. Special words are words that imply an extremely satisfied customer. 

## Instruction
- Copy module code from here: https://github.com/Justinbenfit23/kgb_scrape/tree/main/lib
- Copy mix.exs code from here: https://github.com/Justinbenfit23/kgb_scrape/blob/main/mix.exs then go to command line and run mix deps.get to install dependencies
- Open elixir interactive shell by running `iex -S mix` at command line
- Run `calc_scores()` function in interactive shell like so `Kgbscrape.calc_score()`
- This will call `get_body()` function which first calls `handle response()` which will pull the response body using `HTTPoison` and `Floki`, handle for errors then grab only the review date and body for the first 5 pages of reviews
- It will then calculate the "score" of each review by dividing the total number of special words by the total number of words in each review
- Lastly it will print the top 3 results to the shell based on score


## Testing
The tests for this module can be found here: https://github.com/Justinbenfit23/kgb_scrape/tree/main/test
4 tests were run to test for the following:
- Test that the date result in the html response is found inside the div class "italic"
- Test that the review content in the html response is found inside the "p" tag "review-content"
- Test that the number of special words and the number of total words in each `compute_score` function are counting
- Test that `handle_response()` prints the reason, provided that it receives an erroneous url and fails to scrape the website




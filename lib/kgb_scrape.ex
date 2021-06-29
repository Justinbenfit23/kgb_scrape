defmodule KgbScrape do

  def get_reviews_url() do
     case HTTPoison.get("https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/#link") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts body
        |> Floki.find("div.col-xs-12.review-section.pad-md.pad-top-none.pad-bottom-none.mobile-hide")
        |> Enum.map(&Floki.text/1)



      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end
end




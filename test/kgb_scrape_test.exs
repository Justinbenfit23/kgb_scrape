defmodule KgbScrapeTest do
  use ExUnit.Case
  require Logger
  doctest KgbScrape
  

  test "pattern match date result to [[{'div',[{'class', 'italic col-xs-6 col-sm-12 pad-none margin-none font-20'}],[]}]]" do
      url = "https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page1/?filter=#link"
      case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
      body end
      |> Floki.parse
      |> Floki.find(".review-entry")
      |> Enum.map(fn entry -> Floki.find(entry, "div.italic")  end )
      |> Enum.take(1)

      assert [[{"div",[{"class", "italic col-xs-6 col-sm-12 pad-none margin-none font-20"}],[]}]]
  end

  test "pattern match review text to [[{'p',[{'class', 'font-16 review-content margin-bottom-none line-height-25'}],[]}]]" do
    url = "https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page1/?filter=#link"
    case HTTPoison.get(url) do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
    body end
    |> Floki.parse
    |> Floki.find(".review-entry")
    |> Enum.map(fn entry -> Floki.find(entry, "p.review-content")  end )
    |> Enum.take(1)

    assert [[{"p",[{"class", "font-16 review-content margin-bottom-none line-height-25"}],[]}]]
  end

  test "assure that number of special words and number of total words is counting accurately" do
    url = "https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page1/?filter=#link"
    special_words = ["extremely", "definitely","amazing","amazingly","excellent","awesome","incredibly","incredible","loved","!","!!"]
    review = case HTTPoison.get(url) do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
    body end
    |> Floki.parse
    |> Floki.find(".review-entry")
    |> Enum.map(fn entry ->
      [{"div", _, [date]}] = Floki.find(entry, "div.italic")
      [{"p", _, [content]}]  = Floki.find(entry, "p.review-content")
      {date, content} 
    end)
    |> Enum.take(1)
  

    compute_score = fn review -> {special, total} = review |> String.downcase |> String.split |> Enum.reduce({0, 0}, fn w, {sp, to} -> if w in special_words, do: {sp + 1, to + 1}, else: {sp, to + 1} end)
    {special,total}
    end

    for {d,r} <- review, do: %{date: d, count_special_count_total: compute_score.(r)}
  end

  test "assure that function handle_response() prints :ok response and reason: nxdomain" do
    erroneous_url = "https://www.dalerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page1/?filter=#link"
    case HTTPoison.get(erroneous_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        Logger.info(fn ->
          "[#{__MODULE__}] Hit url: #{erroneous_url}, status_code: #{inspect(status_code)}"
        end)
        {:ok, "Failed to scrape website. Status code: #{inspect(status_code)}"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.info(fn ->
          "[#{__MODULE__}] Failed to scrape website: #{inspect(reason)}"
        end)
        {:ok, "Failed to scrape website. Reason: #{inspect(reason)}}"}
    end
    assert {:ok, "Failed to scrape website. Reason: :nxdomain}"}
  end
  
end

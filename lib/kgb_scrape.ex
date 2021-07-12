defmodule KgbScrape do
    require Logger
    use HTTPoison.Base
    @endpoint "https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page"
  
    def get_body() do
      page_num = ["1","2","3","4","5"]
      tail_url = ["/?filter=#link"]
      urls_list = for page <- page_num, tail <- tail_url do
        @endpoint <> page <> tail
      end
      urls_list
      |> Enum.map(fn url -> handle_response(url) end)
      |> Floki.parse
      |> Floki.find(".review-entry")
      |> Enum.map(fn entry ->
        [{"div", _, [date]}] = Floki.find(entry, "div.italic")
        [{"p", _, [content]}]  = Floki.find(entry, "p.review-content")
        {date, content} 
      end)
    end

    def calc_score() do
      
      reviews = get_body()
      special_words = ["extremely", "definitely","amazing","very","best","great","excellent","awesome","incredibly","beyond","loved","really","highly"]

      compute_score = fn review -> {special, total} = review |> String.downcase |> String.split |> Enum.reduce({0, 0}, fn w, {sp, to} -> if w in special_words, do: {sp + 1, to + 1}, else: {sp, to + 1} end)                                                              
      special/total
      end

      score = for {d, r} <- reviews, do: %{id: :erlang.phash2(r), date: d, score: compute_score.(r), text: r}
      Enum.sort_by(score, fn(s) -> s.score end) |> Enum.reverse() |> Enum.take(3)

      

    end
    
     
    def handle_response(url) do
      case HTTPoison.get(url) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          body
        {:ok, %HTTPoison.Response{status_code: status_code}} ->
          Logger.info(fn ->
            "[#{__MODULE__}] Hit url: #{url}, status_code: #{inspect(status_code)}"
          end)
          {:ok, "Failed to scrape website. Status code: #{inspect(status_code)}"}
        {:error, %HTTPoison.Error{reason: reason}} ->
          Logger.info(fn ->
            "[#{__MODULE__}] Failed to scrape website: #{inspect(reason)}"
          end)
          {:ok, "Failed to scrape website. Reason: #{inspect(reason)}}"}
      end
    end
end




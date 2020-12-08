defmodule NotionUploader.Uploader do

  alias NotionUploader.Parser
  alias NotionUploader.UrlBuilder

  def upload() do
    map = %{estimate: 2, owner_ids: [3352514,1426364]}

    Enum.each(Parser.get_stories(), fn story ->
      map = Map.put(map, :name, story)
      formatted_body = Poison.encode!(map)
      HTTPoison.post(
        "#{UrlBuilder.url_builder()}",
        "#{formatted_body}",
        [{"Content-Type", "application/json"}])
    end)
  end

  def reader do
    File.read("Test.txt")
  end


end

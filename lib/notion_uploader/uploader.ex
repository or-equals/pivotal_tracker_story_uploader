defmodule NotionUploader.Uploader do

  alias NotionUploader.Controller
  alias NotionUploader.UrlBuilder

  def upload() do
    map = %{
      estimate: 2,
      owner_ids: Controller.owner_ids()
    }

    Enum.each(Controller.get_stories(), fn story ->
      map = Map.put(map, :name, story)

      formatted_body = Poison.encode!(map)

      HTTPoison.post(
        "#{UrlBuilder.url_builder()}",
        "#{formatted_body}",
        [{"Content-Type", "application/json"}])
    end)
  end

  def reader do
    File.read("Test_2.txt")
  end
end

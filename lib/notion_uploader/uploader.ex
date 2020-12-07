defmodule NotionUploader.Uploader do
  alias NotionUploader.Parser
  alias NotionUploader.Api

  def enum() do
    map = %{estimate: 2, owner_ids: [3352514,1426364]}

    Enum.each(Parser.parse_headers(), fn story ->
      map = Map.put(map, :name, story)
      formatted_body = Poison.encode!(map)
      HTTPoison.post(
        "#{url_builder()}",
        "#{formatted_body}",
        [{"Content-Type", "application/json"}])
    end)
  end

  def reader do
    File.read("Test.txt")
  end

  def url_builder do
    url = "https://www.pivotaltracker.com/services/v5/projects/"
    x = url <> url_id()
    x <> Parser.get_api_token()
  end

  def url_id do
    id = Api.get_project_id()
    id = to_string(id)
    id <> "/stories"
  end

  def url_get do
    url = "https://www.pivotaltracker.com/services/v5/projects"
    url <> Parser.get_api_token()
  end

end

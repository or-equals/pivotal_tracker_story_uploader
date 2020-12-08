defmodule NotionUploader.UrlBuilder do

  alias NotionUploader.Parser

  @url "https://www.pivotaltracker.com/services/v5/projects/"

  def url_builder do
    @url
    <> url_add_id()
    <> Parser.get_api_token()
  end

  def url_add_id do
    id =
      Parser.get_project_id()
      |> to_string()
    id <> "/stories"
  end

  def url_get do
    @url <> Parser.get_api_token()
  end
end

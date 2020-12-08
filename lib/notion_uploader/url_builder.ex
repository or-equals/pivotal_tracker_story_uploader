defmodule NotionUploader.UrlBuilder do

  alias NotionUploader.Controller

  @url "https://www.pivotaltracker.com/services/v5/projects"


  def url_builder do
    @url
    <> url_add_id()
    <> Controller.get_api_token()
  end

  def url_add_id do
    id =
      Controller.get_project_id()
      |> to_string()
    "/" <> id <> "/stories"
  end

  def url_get do
    @url <> Controller.get_api_token()
  end

  def url_members do
    id =
      Controller.get_project_id()
      |> to_string()
    @url <> "/" <> id <> "/memberships" <> Controller.get_api_token()
  end

end
